using WGPUNative

include("$(pkgdir(WGPUNative))/examples/logcallback.jl")
include("$(pkgdir(WGPUNative))/examples/requestAdapter.jl")
include("$(pkgdir(WGPUNative))/examples/requestDevice.jl")

numbers = UInt32[1,2,3,4]

b = read("$(pkgdir(WGPUNative))/examples/shader.wgsl") 

function load_wgsl(filename)
    b = read(filename)
	wgslDescriptor = WGPUShaderModuleWGSLDescriptor()
	wgslDescriptor.chain = WGPUChainedStruct(C_NULL, WGPUSType_ShaderModuleWGSLDescriptor)
	wgslDescriptor.code = pointer(b)
    descriptor = WGPUShaderModuleDescriptor()
    descriptor.nextInChain = wgslDescriptor |> pointer_from_objref
    descriptor.label = pointer(filename)
    descriptor.hintCount = 0
    descriptor.hints = C_NULL
    return (descriptor, wgslDescriptor)
end

(shaderSource, _) = load_wgsl("$(pkgdir(WGPUNative))/examples/shader.wgsl")

##
shader = wgpuDeviceCreateShaderModule(
    device,
    shaderSource |> pointer_from_objref
)

## StagingBuffer 
stagingDescriptor = WGPUBufferDescriptor()
stagingDescriptor.nextInChain = C_NULL
stagingDescriptor.label = pointer("StagingBuffer")
stagingDescriptor.usage = WGPUBufferUsage_MapRead | WGPUBufferUsage_CopyDst
stagingDescriptor.size = sizeof(numbers)
stagingDescriptor.mappedAtCreation = false

stagingBuffer = wgpuDeviceCreateBuffer(
                    device,
                    stagingDescriptor |> pointer_from_objref
                )
## StorageBuffer 
storageDescriptor = WGPUBufferDescriptor()
storageDescriptor.nextInChain = C_NULL
storageDescriptor.label = pointer("StorageBuffer")
storageDescriptor.usage = WGPUBufferUsage_Storage | WGPUBufferUsage_CopyDst | WGPUBufferUsage_CopySrc
storageDescriptor.size = sizeof(numbers)
storageDescriptor.mappedAtCreation = false

storageBuffer = wgpuDeviceCreateBuffer(
                    device, 
                    storageDescriptor |> pointer_from_objref
                )


# compute pipeline
name = "main"
computeStageDesc = GC.@preserve name WGPUProgrammableStageDescriptor(
	C_NULL, 
	shader,
	pointer(name),
	0,
	C_NULL
)

computePipelineDesc = WGPUComputePipelineDescriptor()
computePipelineDesc.nextInChain = C_NULL
computePipelineDesc.label = pointer("compute_pipeline")
computePipelineDesc.layout = C_NULL
computePipelineDesc.compute = computeStageDesc

computePipeline = GC.@preserve computePipelineDesc wgpuDeviceCreateComputePipeline(
	device,
	computePipelineDesc |> pointer_from_objref
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
	bgDescriptor = WGPUBindGroupDescriptor()
	bgDescriptor.nextInChain = C_NULL
	bgDescriptor.label = pointer(bgName)
	bgDescriptor.entries = bgentries |> pointer
	bgDescriptor.entryCount = 1
	bgDescriptor.layout = bindgroupLayout
	bgDescriptor
end

bindGroup = GC.@preserve bgDescriptor wgpuDeviceCreateBindGroup(
    device,
    bgDescriptor |> pointer_from_objref
)

@assert bindGroup != C_NULL

## encoder
cmdName = "CmdEncoder"
cmdEncoderDesc = WGPUCommandEncoderDescriptor()
cmdEncoderDesc.nextInChain = C_NULL
cmdEncoderDesc.label = pointer(name)

cmdEncoder = GC.@preserve cmdName cmdEncoderDesc wgpuDeviceCreateCommandEncoder(
            device,
            cmdEncoderDesc |> pointer_from_objref
        )


## computePass
computepassName = "compute pass"
computePassDesc = GC.@preserve computepassName begin
	computePassDesc = WGPUComputePassDescriptor()
	computePassDesc.nextInChain = C_NULL
	computePassDesc.timestampWrites = C_NULL
	computePassDesc.label = pointer(computepassName)
	computePassDesc
end

computePassEncoder = wgpuCommandEncoderBeginComputePass(
    cmdEncoder,
    computePassDesc |> pointer_from_objref
)

## set pipeline
wgpuComputePassEncoderSetPipeline(computePassEncoder, computePipeline)
wgpuComputePassEncoderSetBindGroup(computePassEncoder, 0, bindGroup, 0, C_NULL)
wgpuComputePassEncoderDispatchWorkgroups(computePassEncoder, length(numbers), 1, 1)
wgpuComputePassEncoderEnd(computePassEncoder)

## buffer copy buffer
wgpuCommandEncoderCopyBufferToBuffer(cmdEncoder, storageBuffer, 0, stagingBuffer, 0, sizeof(numbers))

## queue
queue = wgpuDeviceGetQueue(device)

## commandBuffer
cmdBufferName = "cmd Buffer"
cmdBufferDesc = GC.@preserve cmdBufferName begin
	cmdBufferDesc = WGPUCommandBufferDescriptor()
	cmdBufferDesc.nextInChain = C_NULL
	cmdBufferDesc.label = pointer("cmd buffer")
	cmdBufferDesc
end

cmdBuffer = wgpuCommandEncoderFinish(
    cmdEncoder,
    cmdBufferDesc |> pointer_from_objref
)


## writeBuffer
wgpuQueueWriteBuffer(queue, storageBuffer, 0, pointer(numbers), sizeof(numbers))

## submit queue
wgpuQueueSubmit(queue, 1, Ref(cmdBuffer))

## MapAsync
asyncstatus = WGPUBufferMapAsyncStatus(2)

function readBufferMap(status::WGPUBufferMapAsyncStatus, userData)
	global asyncstatus
    asyncstatus = status
    return nothing
end

readbuffermap = @cfunction(readBufferMap, Cvoid, (WGPUBufferMapAsyncStatus, Ptr{Cvoid}))

wgpuBufferMapAsync(stagingBuffer, WGPUMapMode_Read, 0, sizeof(numbers), readbuffermap, C_NULL)


## device polling
wgpuDevicePoll(device, true, C_NULL)

@assert asyncstatus == WGPUBufferMapAsyncStatus_Success
## times
times = convert(Ptr{UInt32}, wgpuBufferGetMappedRange(stagingBuffer, 0, sizeof(numbers)))

## result
for i in eachindex(numbers)
    println(numbers[i], " : " ,unsafe_load(times, i))
end

wgpuBufferUnmap(stagingBuffer)
wgpuCommandBufferRelease(cmdBuffer)
wgpuComputePassEncoderRelease(computePassEncoder)
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
