## Load WGPU
using WGPUNative

## Constants

numbers = UInt32[1,2,3,4]

const DEFAULT_ARRAY_SIZE = 256

## Init Window Size

const width = 200
const height = 200

## default inits for non primitive types

defaultInit(::Type{T}) where T<:Number = T(0)

defaultInit(::Type{T}) where T = begin
		if isprimitivetype(T)
				return T(0)
		else
				ins = []
				for t = fieldnames(T)
						push!(ins, defaultInit(fieldtype(T, t)))
				end
				return T(ins...)
		end
end


defaultInit(::Type{WGPUNativeFeature}) = WGPUNativeFeature(0x10000000)

defaultInit(::Type{WGPUSType}) = WGPUSType(6)

defaultInit(::Type{T}) where T<:Ptr{Nothing} = Ptr{Nothing}()

defaultInit(::Type{Array{T, N}}) where T where N = zeros(T, DEFAULT_ARRAY_SIZE)

defaultInit(::Type{WGPUPowerPreference}) = WGPUPowerPreference(1)

function partialInit(target::Type{T}; fields...) where T
		ins = []
		inPairs = pairs(fields)
		for field in fieldnames(T)
				if field in keys(inPairs)
					push!(ins, inPairs[field])
				else
					push!(ins, defaultInit(fieldtype(T, field)))
				end
		end
		return T(ins...)
end

## Print current version

println("Current Version : $(wgpuGetVersion())")

## Set Log callbacks

function logCallBack(logLevel::WGPULogLevel, msg::Ptr{Cchar})
		if logLevel == WGPULogLevel_Error
				level_str = "ERROR"
		elseif logLevel == WGPULogLevel_Warn
				level_str = "WARN"
		elseif logLevel == WGPULogLevel_Info
				level_str = "INFO"
		elseif logLevel == WGPULogLevel_Debug
				level_str = "DEBUG"
		elseif logLevel == WGPULogLevel_Trace
				level_str = "TRACE"
		else
				level_str = "UNKNOWN LOG LEVEL"
		end
        println("$(level_str) $(unsafe_string(msg))")
end


logcallback = @cfunction(logCallBack, Cvoid, (WGPULogLevel, Ptr{Cchar}))

wgpuSetLogCallback(logcallback, C_NULL)
wgpuSetLogLevel(WGPULogLevel(4))

## 

adapter = Ref(WGPUAdapter())
device = Ref(WGPUDevice())

adapterOptions = Ref(defaultInit(WGPURequestAdapterOptions))

function request_adapter_callback(
				a::WGPURequestAdapterStatus,
				b::WGPUAdapter,
			   c::Ptr{Cchar},
			   d::Ptr{Nothing})
    global adapter[] = b
	return nothing
end

requestAdapterCallback = @cfunction(request_adapter_callback, Cvoid, (WGPURequestAdapterStatus, WGPUAdapter, Ptr{Cchar}, Ptr{Cvoid}))

## device callback

function request_device_callback(
        a::WGPURequestDeviceStatus,
        b::WGPUDevice,
        c::Ptr{Cchar},
        d::Ptr{Nothing})
    global device[] = b
    return nothing
end

requestDeviceCallback = @cfunction(request_device_callback, Cvoid, (WGPURequestDeviceStatus, WGPUDevice, Ptr{Cchar}, Ptr{Cvoid}))

instance = wgpuCreateInstance(WGPUInstanceDescriptor(0) |> Ref)
## request adapter 

wgpuInstanceRequestAdapter(instance, 
						   adapterOptions, 
						   requestAdapterCallback,
						   adapter)

##

# chain = WGPUChainedStruct(C_NULL, WGPUSType(6))
# 
# deviceName = Vector{UInt8}("Device")
# deviceExtras = WGPUDeviceExtras(chain, defaultInit(WGPUNativeFeature), pointer(deviceName), C_NULL)
# 
# const DEFAULT_ARRAY_SIZE = 256
# 
# wgpuLimits = partialInit(WGPULimits; maxBindGroups = 1)
# 
# wgpuRequiredLimits = WGPURequiredLimits(C_NULL, wgpuLimits)
# 
# wgpuQueueDescriptor = WGPUQueueDescriptor(C_NULL, C_NULL)
# 
# wgpuDeviceDescriptor = Ref(
                        # partialInit(
                            # WGPUDeviceDescriptor,
                            # nextInChain = pointer_from_objref(Ref(partialInit(WGPUChainedStruct, chain=deviceExtras))),
                            # requiredLimits = pointer_from_objref(Ref(wgpuRequiredLimits)),
                            # defaultQueue = wgpuQueueDescriptor
                        # )
                      # )


# wgpuAdapterRequestDevice(
                 # adapter[],
                 # wgpuDeviceDescriptor,
                 # requestDeviceCallback,
                 # device[])
                 
wgpuAdapterRequestDevice(
                 adapter[],
                 C_NULL,
                 requestDeviceCallback,
                 device[])

                 
##
b = read("examples/shader.wgsl")  
wgslDescriptor = WGPUShaderModuleWGSLDescriptor(
        defaultInit(WGPUChainedStruct),
        pointer(b)
    )
 
## WGSL loading

function load_wgsl(filename)
    b = read(filename)
    wgslDescriptor = Ref(WGPUShaderModuleWGSLDescriptor(
        defaultInit(WGPUChainedStruct),
        pointer(b)
       ))
    a = partialInit(
        WGPUShaderModuleDescriptor;
        nextInChain = pointer_from_objref(wgslDescriptor),
        label = pointer(Vector{UInt8}("$(filename)"))
    )
    return (a, wgslDescriptor)
end


shaderSource = Ref(load_wgsl("examples/shader.wgsl")[1])

##


shader = wgpuDeviceCreateShaderModule(
    device[],
    pointer_from_objref(shaderSource)
)

## StagingBuffer 

stagingBuffer = wgpuDeviceCreateBuffer(device[], 
                      Ref(partialInit(WGPUBufferDescriptor;
                                   nextInChain = C_NULL,
                                   label = pointer(Vector{UInt8}("StagingBuffer")),
                                   usage = WGPUBufferUsage_MapRead | WGPUBufferUsage_CopyDst,
                                   size = sizeof(numbers),
                                   mappedAtCreation = false
                                  )))
## StorageBuffer 

storageBuffer = wgpuDeviceCreateBuffer(device[], 
                      Ref(partialInit(WGPUBufferDescriptor;
                                   nextInChain = C_NULL,
                                   label = pointer(Vector{UInt8}("StorageBuffer")),
                                   usage = WGPUBufferUsage_Storage | WGPUBufferUsage_CopyDst | WGPUBufferUsage_CopySrc,
                                   size = sizeof(numbers),
                                   mappedAtCreation = false
                                  )))


## BindGroupLayout
bindGroupLayout = wgpuDeviceCreateBindGroupLayout(
    device[],
    Ref(partialInit(WGPUBindGroupLayoutDescriptor;
        label = pointer(Vector{UInt8}("Bind Group Layout")),
        entries = pointer_from_objref(Ref(partialInit(
            WGPUBindGroupLayoutEntry;
            nextInChain = C_NULL,
            binding = 0,
            visibility = WGPUShaderStage_Compute,
            buffer = partialInit(
                WGPUBufferBindingLayout;
                type=WGPUBufferBindingType_Storage
            ),
            sampler = defaultInit(
                WGPUSamplerBindingLayout;
            ),
            texture = defaultInit(
                WGPUTextureBindingLayout;
            ),
            storageTexture = defaultInit(
                WGPUStorageTextureBindingLayout;        
            )
           ))),
        entryCount = 1
       ))
   )

## BindGroup

bindGroup = wgpuDeviceCreateBindGroup(
    device[],
    pointer_from_objref(Ref(partialInit(
        WGPUBindGroupDescriptor;
        label = pointer(Vector{UInt8}("Bind Group")),
        layout = bindGroupLayout,
        entries = pointer_from_objref(Ref(partialInit(WGPUBindGroupEntry;
                              binding = 0,
                              buffer = storageBuffer,
                              offset = 0,
                              size = sizeof(numbers)))),
        entryCount = 1
       ))))


## bindGroupLayouts 

bindGroupLayouts = [bindGroupLayout,]

## Pipeline Layout
pipelineLayout = wgpuDeviceCreatePipelineLayout(
    device[],
    pointer_from_objref(Ref(partialInit(
        WGPUPipelineLayoutDescriptor;
        bindGroupLayouts = pointer(bindGroupLayouts),
        bindGroupLayoutCount = 1
       )
    )))

## TODO fix

        compute = partialInit(
             WGPUProgrammableStageDescriptor;
             _module = shader,
             entryPoint = pointer(Vector{UInt8}("main"))
            )


## compute pipeline

computePipeline = wgpuDeviceCreateComputePipeline(
    device[],
    pointer_from_objref(Ref(partialInit(
        WGPUComputePipelineDescriptor,
        layout = pipelineLayout,
        compute = partialInit(
             WGPUProgrammableStageDescriptor;
             _module = shader,
             entryPoint = pointer(Vector{UInt8}("main"))
            )
            ))))

## encoder

encoder = wgpuDeviceCreateCommandEncoder(device[],
    pointer_from_objref(Ref(partialInit(
                            WGPUCommandEncoderDescriptor;
                            label = pointer(Vector{UInt8}("Command Encoder"))
                           ))))


## computePass
computePass = wgpuCommandEncoderBeginComputePass(encoder,
    pointer_from_objref(Ref(partialInit(
                            WGPUComputePassDescriptor;
                            label = pointer(Vector{UInt8}("Compute Pass"))
                           ))))


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
    pointer_from_objref(Ref(defaultInit(WGPUCommandBufferDescriptor)))
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
for i in 1:length(numbers)
    println(numbers[i], " : " ,unsafe_load(times, i))
end











