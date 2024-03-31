@warn "Garbage Collector State"  GC.enable(false)
using WGPUNative

include("$(pkgdir(WGPUNative))/examples/logcallback.jl")
include("$(pkgdir(WGPUNative))/examples/requestAdapter.jl")
include("$(pkgdir(WGPUNative))/examples/requestDevice.jl")

numbers = UInt32[1,2,3,4]

b = read("$(pkgdir(WGPUNative))/examples/shader.wgsl") 
wgslDescriptor = WGPUShaderModuleWGSLDescriptor()
wgslDescriptor.code = pointer(b)

function load_wgsl(filename)
    b = read(filename)
    wgslDescriptor = WGPUShaderModuleWGSLDescriptor()
    wgslDescriptor.chain = WGPUChainedStruct(
    	C_NULL,
    	WGPUSType_ShaderModuleWGSLDescriptor
    )
    wgslDescriptor.code = pointer(b)
    
    descriptor = WGPUShaderModuleDescriptor()
    descriptor.nextInChain = wgslDescriptor |> pointer_from_objref
    descriptor.label = pointer(filename)
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
storageDescriptor.label = pointer("StorageBuffer")
storageDescriptor.usage = WGPUBufferUsage_Storage | WGPUBufferUsage_CopyDst | WGPUBufferUsage_CopySrc
storageDescriptor.size = sizeof(numbers)
storageDescriptor.mappedAtCreation = false

storageBuffer = wgpuDeviceCreateBuffer(
                    device, 
                    storageDescriptor |> pointer_from_objref
                )


# compute pipeline
computeStageDesc = WGPUProgrammableStageDescriptor(
	C_NULL, 
	shader,
	pointer("main"),
	0,
	C_NULL
)

computePipelineDesc = WGPUComputePipelineDescriptor()
computePipelineDesc.label = pointer("compute_pipeline")
computePipelineDesc.compute = computeStageDesc

computePipeline = wgpuDeviceCreateComputePipeline(
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

bgDescriptor = WGPUBindGroupDescriptor()
bgDescriptor.label = pointer("BindGroup")
bgentries = WGPUBindGroupEntry[]
push!(bgentries, bgEntry)
bgDescriptor.entries = bgentries |> pointer
bgDescriptor.entryCount = 1
bgDescriptor.layout = bindgroupLayout

bindGroup = wgpuDeviceCreateBindGroup(
    device,
    bgDescriptor |> pointer_from_objref
)

@assert bindGroup != C_NULL

## encoder
cmdEncoderDesc = WGPUCommandEncoderDescriptor()
cmdEncoderDesc.label = pointer("Cmd Encoder")

cmdEncoder = wgpuDeviceCreateCommandEncoder(
            device,
            cmdEncoderDesc |> pointer_from_objref
        )


## computePass
computePassDesc = WGPUComputePassDescriptor()
computePassDesc.label = pointer("compute pass")
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
cmdBufferDesc = WGPUCommandBufferDescriptor()
cmdBufferDesc.label = pointer("cmd buffer")
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
    asyncstatus = status
    return nothing
end

readbuffermap = @cfunction(readBufferMap, Cvoid, (WGPUBufferMapAsyncStatus, Ptr{Cvoid}))

wgpuBufferMapAsync(stagingBuffer, WGPUMapMode_Read, 0, sizeof(numbers), readbuffermap, C_NULL)

print(asyncstatus)

## device polling
wgpuDevicePoll(device, true, C_NULL)

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
