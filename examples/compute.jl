using WGPUNative

include("$(pkgdir(WGPUNative))/examples/logcallback.jl")
include("$(pkgdir(WGPUNative))/examples/requestAdapter.jl")
include("$(pkgdir(WGPUNative))/examples/requestDevice.jl")

numbers = UInt32[1,2,3,4]

b = read("$(pkgdir(WGPUNative))/examples/shader.wgsl") 

function load_wgsl(filename)
    b = read(filename)
	wgslDescriptor = WGPUShaderSourceWGSL()
	wgslDescriptor.chain = WGPUChainedStruct(C_NULL, WGPUSType_ShaderSourceWGSL)
	wgslDescriptor.code = WGPUStringView(pointer(b), length(b))
    descriptor = WGPUShaderModuleDescriptor()
    descriptor.nextInChain = wgslDescriptor |> pointer_from_objref
    descriptor.label = WGPUStringView(pointer(filename), length(filename))
    return (descriptor, wgslDescriptor)
end

(shaderSource, _) = load_wgsl("$(pkgdir(WGPUNative))/examples/shader.wgsl")

## 
shader = wgpuDeviceCreateShaderModule(
    device,
    shaderSource |> pointer_from_objref
)

## StagingBuffer 
stagingDescriptor = WGPUBufferDescriptor |> CStruct
l = "StagingBuffer"
stagingDescriptor.nextInChain = C_NULL
stagingDescriptor.label = WGPUStringView(pointer(l), length(l))
stagingDescriptor.usage = WGPUBufferUsage(WGPUBufferUsage_MapRead | WGPUBufferUsage_CopyDst)
stagingDescriptor.size = sizeof(numbers)
stagingDescriptor.mappedAtCreation = false

stagingBuffer = wgpuDeviceCreateBuffer(
                    device,
                    stagingDescriptor |> ptr
                )
## StorageBuffer 
l = "StorageBuffer"
storageDescriptor = WGPUBufferDescriptor |> CStruct
storageDescriptor.nextInChain = C_NULL
storageDescriptor.label = WGPUStringView(pointer(l), length(l))
storageDescriptor.usage = WGPUBufferUsage(WGPUBufferUsage_Storage | WGPUBufferUsage_CopyDst | WGPUBufferUsage_CopySrc)
storageDescriptor.size = sizeof(numbers)
storageDescriptor.mappedAtCreation = false

storageBuffer = wgpuDeviceCreateBuffer(
				    device, 
				    storageDescriptor |> ptr
				)


# compute pipeline
name = "main"
computeStageDesc = GC.@preserve name WGPUProgrammableStageDescriptor(
	C_NULL, 
	shader,
	WGPUStringView(pointer(name), length(name)),
	0,
	C_NULL
)

pipelinename = "compute_pipeline"
computePipelineDesc = CStruct(WGPUComputePipelineDescriptor)
computePipelineDesc.nextInChain = C_NULL
computePipelineDesc.label = WGPUStringView(pointer(pipelinename), length(pipelinename))
computePipelineDesc.layout = C_NULL
computePipelineDesc.compute = computeStageDesc

computePipeline = GC.@preserve computePipelineDesc wgpuDeviceCreateComputePipeline(
	device,
	computePipelineDesc |> ptr
)

## BindGroupLayout
bindgroupLayout  = wgpuComputePipelineGetBindGroupLayout(computePipeline, 0)

## BindGroup
bgEntry = WGPUBindGroupEntry(
	C_NULL, 			#nextInChain
	0, 					#binding
	storageBuffer, 		#buffer
	0, 					#offset
	sizeof(numbers), 	#size
	C_NULL,				#sampler
	C_NULL				#textureView
)

bgName = "BindGroup"
bgentries = WGPUBindGroupEntry[]
push!(bgentries, bgEntry)

bgDescriptor = GC.@preserve bgName bgentries begin
	bgDescriptor = CStruct(WGPUBindGroupDescriptor)
	bgDescriptor.nextInChain = C_NULL
	bgDescriptor.label = WGPUStringView(pointer(bgName), length(bgName))
	bgDescriptor.entries = bgentries |> pointer
	bgDescriptor.entryCount = 1
	bgDescriptor.layout = bindgroupLayout
	bgDescriptor
end

bindGroup = GC.@preserve bgDescriptor wgpuDeviceCreateBindGroup(
    device,
    bgDescriptor |> ptr
)

@assert bindGroup != C_NULL

## encoder
cmdName = "CmdEncoder"
cmdEncoderDesc = WGPUCommandEncoderDescriptor |> CStruct
cmdEncoderDesc.nextInChain = C_NULL
cmdEncoderDesc.label = WGPUStringView(pointer(name), length(name))

cmdEncoder = GC.@preserve cmdName cmdEncoderDesc wgpuDeviceCreateCommandEncoder(
            device,
            cmdEncoderDesc |> ptr
        )


## computePass
computepassName = "compute pass"
computePassDesc = GC.@preserve computepassName begin
	computePassDesc = WGPUComputePassDescriptor |> CStruct
	computePassDesc.nextInChain = C_NULL
	computePassDesc.timestampWrites = C_NULL
	computePassDesc.label = WGPUStringView(pointer(computepassName), length(computepassName))
	computePassDesc
end

computePassEncoder = wgpuCommandEncoderBeginComputePass(
    cmdEncoder,
    computePassDesc |> ptr
)

## set pipeline
wgpuComputePassEncoderSetPipeline(computePassEncoder, computePipeline)
wgpuComputePassEncoderSetBindGroup(computePassEncoder, 0, bindGroup, 0, C_NULL)
wgpuComputePassEncoderDispatchWorkgroups(computePassEncoder, length(numbers), 1, 1)
wgpuComputePassEncoderEnd(computePassEncoder)
wgpuComputePassEncoderRelease(computePassEncoder)

## buffer copy buffer
wgpuCommandEncoderCopyBufferToBuffer(cmdEncoder, storageBuffer, 0, stagingBuffer, 0, sizeof(numbers))

## queue
queue = wgpuDeviceGetQueue(device)

## commandBuffer
cmdBufferName = "cmd Buffer"
cmdBufferDesc = GC.@preserve cmdBufferName begin
	cmdBufferDesc = WGPUCommandBufferDescriptor |> CStruct
	cmdBufferDesc.nextInChain = C_NULL
	cmdBufferDesc.label = WGPUStringView(pointer(cmdBufferName), length(cmdBufferName))
	cmdBufferDesc
end

cmdBuffer = wgpuCommandEncoderFinish(
    cmdEncoder,
    cmdBufferDesc |> ptr
)


## writeBuffer
wgpuQueueWriteBuffer(queue, storageBuffer, 0, pointer(numbers), sizeof(numbers))

## submit queue
wgpuQueueSubmit(queue, 1, Ref(cmdBuffer))

## MapAsync
asyncstatus = WGPUMapAsyncStatus(2)

function readBufferMap(status::WGPUMapAsyncStatus, userData)
	global asyncstatus
    asyncstatus = status
    return nothing
end


readbuffermap = @cfunction(readBufferMap, Cvoid, (WGPUMapAsyncStatus, Ptr{Cvoid}))
readBufferMapInfo = WGPUBufferMapCallbackInfo |> CStruct
readBufferMapInfo.callback = readbuffermap

wgpuBufferMapAsync(stagingBuffer, WGPUMapMode_Read, 0, sizeof(numbers), readBufferMapInfo |> concrete)


## device polling
wgpuDevicePoll(device, true, C_NULL)

@assert asyncstatus == WGPUMapAsyncStatus_Success
## times
times = convert(Ptr{UInt32}, wgpuBufferGetMappedRange(stagingBuffer, 0, sizeof(numbers)))

## result
for i in eachindex(numbers)
    println(numbers[i], " : " ,unsafe_load(times, i))
end

wgpuBufferUnmap(stagingBuffer)
wgpuCommandBufferRelease(cmdBuffer)
wgpuCommandEncoderRelease(cmdEncoder)
wgpuBindGroupRelease(bindGroup)
wgpuBindGroupLayoutRelease(bindgroupLayout)
wgpuComputePipelineRelease(computePipeline)
wgpuBufferRelease(storageBuffer)
wgpuBufferRelease(stagingBuffer)
wgpuShaderModuleRelease(shader)
wgpuQueueRelease(queue)
wgpuDeviceRelease(device)
wgpuAdapterRelease(adapter)
wgpuInstanceRelease(instance)
