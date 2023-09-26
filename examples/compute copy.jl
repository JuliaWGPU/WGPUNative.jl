using WGPUNative

numbers = UInt32[1,2,3,4]

include("$(pkgdir(WGPUNative))/examples/requestDevice.jl")

##
b = read("examples/shader.wgsl") 
wgslDescriptor = cStruct(WGPUShaderModuleWGSLDescriptor)
wgslDescriptor.chain = cStruct(WGPUChainedStruct) |> concrete 
wgslDescriptor.code = pointer(b)

# wgslDescriptor = WGPUShaderModuleWGSLDescriptor(
#         cStruct(WGPUChainedStruct) |> concrete,
#         pointer(b)
#     )
 
## WGSL loading

function load_wgsl(filename)
    b = read(filename)
    wgslDescriptor = cStruct(WGPUShaderModuleWGSLDescriptor)
    wgslDescriptor.chain = cStruct(
            WGPUChainedStruct;
            sType=WGPUSType_ShaderModuleWGSLDescriptor
        ) |> concrete 
    wgslDescriptor.code = pointer(b)
    
    a = cStruct(
        WGPUShaderModuleDescriptor;
        nextInChain = wgslDescriptor |> ptr,
        label = toCString(filename)
    )
    return (a, wgslDescriptor)
end


(shaderSource, _) = load_wgsl("examples/shader.wgsl")

##

shader = wgpuDeviceCreateShaderModule(
    device[],
    shaderSource |> ptr
)

## StagingBuffer 

stagingBuffer = wgpuDeviceCreateBuffer(
                    device[], 
                    cStruct(
                        WGPUBufferDescriptor;
                        nextInChain = C_NULL,
                        label = toCString("StagingBuffer"),
                        usage = WGPUBufferUsage_MapRead | WGPUBufferUsage_CopyDst,
                        size = sizeof(numbers),
                        mappedAtCreation = false
                    ) |> ptr
                )
## StorageBuffer 

storageBuffer = wgpuDeviceCreateBuffer(
                    device[], 
                    cStruct(
                        WGPUBufferDescriptor;
                        nextInChain = C_NULL,
                        label = toCString("StorageBuffer"),
                        usage = WGPUBufferUsage_Storage | WGPUBufferUsage_CopyDst | WGPUBufferUsage_CopySrc,
                        size = sizeof(numbers),
                        mappedAtCreation = false
                    ) |> ptr
                )


## BindGroupLayout
bindGroupLayout = wgpuDeviceCreateBindGroupLayout(
    device[],
    cStruct(
        WGPUBindGroupLayoutDescriptor;
        label = toCString("Bind Group Layout"),
        entries = cStruct(
            WGPUBindGroupLayoutEntry;
            nextInChain = C_NULL,
            binding = 0,
            visibility = WGPUShaderStage_Compute,
            buffer = cStruct(
                WGPUBufferBindingLayout;
                type=WGPUBufferBindingType_Storage
            ) |> concrete,
            sampler = cStruct(
                WGPUSamplerBindingLayout;
            ) |> concrete,
            texture = cStruct(
                WGPUTextureBindingLayout;
            ) |> concrete,
            storageTexture = cStruct(
                WGPUStorageTextureBindingLayout;        
            ) |> concrete
        ) |> ptr,
        entryCount = 1
    ) |> ptr
)

## BindGroup

bindGroup = wgpuDeviceCreateBindGroup(
    device[],
    cStruct(
        WGPUBindGroupDescriptor;
        label = toCString("Bind Group"),
        layout = bindGroupLayout,
        entries = cStruct(
            WGPUBindGroupEntry;
            binding = 0,
            buffer = storageBuffer,
            offset = 0,
            size = sizeof(numbers)
        ) |> ptr,
        entryCount = 1
    ) |> ptr
)


## bindGroupLayouts 

bindGroupLayouts = [bindGroupLayout,]

## Pipeline Layout
pipelineLayout = wgpuDeviceCreatePipelineLayout(
    device[],
    cStruct(
        WGPUPipelineLayoutDescriptor;
        bindGroupLayouts = pointer(bindGroupLayouts),
        bindGroupLayoutCount = 1
    ) |> ptr
)

## TODO fix

compute = cStruct(
    WGPUProgrammableStageDescriptor;
    _module = shader,
    entryPoint = toCString("main")
) |> concrete


## compute pipeline

computePipeline = wgpuDeviceCreateComputePipeline(
    device[],
    cStruct(
        WGPUComputePipelineDescriptor,
        layout = pipelineLayout,
        compute = cStruct(
            WGPUProgrammableStageDescriptor;
            _module = shader,
            entryPoint = toCString("main")
        ) |> concrete
    ) |> ptr
)

## encoder

encoder = wgpuDeviceCreateCommandEncoder(
            device[],
            cStruct(
                WGPUCommandEncoderDescriptor;
                label = toCString("Command Encoder")
            ) |> ptr
        )


## computePass
computePass = wgpuCommandEncoderBeginComputePass(
    encoder,
    cStruct(
        WGPUComputePassDescriptor;
        label = toCString("Compute Pass")
    ) |> ptr
)


## set pipeline
wgpuComputePassEncoderSetPipeline(computePass, computePipeline)
wgpuComputePassEncoderSetBindGroup(computePass, 0, bindGroup, 0, C_NULL)
wgpuComputePassEncoderDispatchWorkgroups(computePass, length(numbers), 1, 1)
wgpuComputePassEncoderEnd(computePass)

## buffer copy buffer
wgpuCommandEncoderCopyBufferToBuffer(encoder, storageBuffer, 0, stagingBuffer, 0, sizeof(numbers))

## queue
queue = wgpuDeviceGetQueue(device[])

## commandBuffer
cmdBuffer = wgpuCommandEncoderFinish(
    encoder,
    cStruct(WGPUCommandBufferDescriptor) |> ptr
)


## writeBuffer
wgpuQueueWriteBuffer(queue, storageBuffer, 0, pointer(numbers), sizeof(numbers))


## submit queue

wgpuQueueSubmit(queue, 1, Ref(cmdBuffer))

## MapAsync

asyncstatus = Ref(WGPUBufferMapAsyncStatus(3))

function readBufferMap(
        status::WGPUBufferMapAsyncStatus,
        userData)
    asyncstatus[] = status
    return nothing
end

readbuffermap = @cfunction(readBufferMap, Cvoid, (WGPUBufferMapAsyncStatus, Ptr{Cvoid}))

wgpuBufferMapAsync(stagingBuffer, WGPUMapMode_Read, 0, sizeof(numbers), readbuffermap, C_NULL)

print(asyncstatus[])

## device polling

wgpuDevicePoll(device[], true, C_NULL)

## times
times = convert(Ptr{UInt32}, wgpuBufferGetMappedRange(stagingBuffer, 0, sizeof(numbers)))

## result
for i in eachindex(numbers)
    println(numbers[i], " : " ,unsafe_load(times, i))
end











