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
println("Current Version : $(wgpuGetVersion())")

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

wgpuSetLogCallback(logcallback, Ptr{Cvoid}())
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

## request adapter 

instance = wgpuCreateInstance(WGPUInstanceDescriptor(0) |> Ref)

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


wgpuAdapterRequestDevice(
                 adapter[],
                 C_NULL,
                 requestDeviceCallback,
                 device[])

## Buffer dimensions

struct BufferDimensions
    height::UInt32
    width::UInt32
    padded_bytes_per_row::UInt32
    unpadded_bytes_per_row::UInt32
    function BufferDimensions(width, height)
        bytes_per_pixel = sizeof(UInt32)
        unpadded_bytes_per_row = width*bytes_per_pixel
        align = 256
        padded_bytes_per_row_padding = (align - unpadded_bytes_per_row % align) % align
        padded_bytes_per_row = unpadded_bytes_per_row + padded_bytes_per_row_padding
        return new(height, width, padded_bytes_per_row, unpadded_bytes_per_row)
    end
end

bufferDimensions = BufferDimensions(width, height)


bufferSize = bufferDimensions.padded_bytes_per_row*bufferDimensions.height

outputBuffer = wgpuDeviceCreateBuffer(
    device[],
    pointer_from_objref(Ref(partialInit(WGPUBufferDescriptor;
                nextInChain = C_NULL,
                label = pointer(Vector{UInt8}("Output Buffer")),
                usage = WGPUBufferUsage_MapRead | WGPUBufferUsage_CopyDst,
                size = bufferSize,
                mappedAtCreation = false
               )))
   )

## textureExtent 

textureExtent = partialInit(
    WGPUExtent3D;
    width = bufferDimensions.width,
    height = bufferDimensions.height,
    depthOrArrayLayers = 1
   )

## texture

texture = wgpuDeviceCreateTexture(
    device[],
    pointer_from_objref(Ref(partialInit(WGPUTextureDescriptor;
                                        size = textureExtent,
                                        mipLevelCount = 1,
                                        sampleCount = 1,
                                        dimension = WGPUTextureDimension_2D,
                                        format = WGPUTextureFormat_RGBA8UnormSrgb,
                                        usage = WGPUTextureUsage_RenderAttachment | WGPUTextureUsage_CopySrc,
                                       ))))

## encoder

encoder = wgpuDeviceCreateCommandEncoder(
               device[], 
               pointer_from_objref(Ref(defaultInit(WGPUCommandEncoderDescriptor))))

## outputAttachment
# outputAttachment = wgpuTextureCreateView(
    # texture,
    # pointer_from_objref(Ref(defaultInit(WGPUTextureViewDescriptor)))
   # )
outputAttachment = wgpuTextureCreateView(
    texture,
    C_NULL
)

           
## renderPass
renderPass = wgpuCommandEncoderBeginRenderPass(
    encoder,
    pointer_from_objref(Ref(partialInit(WGPURenderPassDescriptor;
        colorAttachments = pointer_from_objref(Ref(partialInit(WGPURenderPassColorAttachment;
                                                               view = outputAttachment,
                                                               resolveTarget = 0,
                                                               loadOp = WGPULoadOp_Clear,
                                                               storeOp = WGPUStoreOp_Store,
                                                               clearValue = WGPUColor(1.0, 0.0, 0.0, 1.0),
                                                              ))),
        colorAttachmentCount = 1,
        depthStencilAttachment = C_NULL
       )))
   )




## end renderpass 
wgpuRenderPassEncoderEnd(renderPass)

## Copy texture to buffer

wgpuCommandEncoderCopyTextureToBuffer(
    encoder,
    pointer_from_objref(Ref(partialInit(WGPUImageCopyTexture;
                                        texture = texture,
                                        miplevel = 0,
                                        origin = WGPUOrigin3D(0, 0, 0)))),
    pointer_from_objref(Ref(partialInit(WGPUImageCopyBuffer;
                                        buffer = outputBuffer,
                                        layout = partialInit(WGPUTextureDataLayout;
                                                             offset = 0,
                                                             bytesPerRow = bufferDimensions.padded_bytes_per_row,
                                                             rowsPerImage = WGPU_COPY_STRIDE_UNDEFINED
                                                            )))),
    Ref(textureExtent))

##


## 
#
#
#
#
##
#
#
#
##
#
#
#
#
##
#
#
#
#
## queue
queue = wgpuDeviceGetQueue(device[])

## commandBuffer
cmdBuffer = wgpuCommandEncoderFinish(
    encoder,
    pointer_from_objref(Ref(defaultInit(WGPUCommandBufferDescriptor)))
   )

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

wgpuBufferMapAsync(outputBuffer, WGPUMapMode_Read, 0, bufferSize, readbuffermap, C_NULL)

print(asyncstatus[])

## device polling

wgpuDevicePoll(device[], true, C_NULL)

## times
times = convert(Ptr{UInt8}, wgpuBufferGetMappedRange(outputBuffer, 0, bufferSize))

## result
for i in 1:width*height
    println(i, " : ", unsafe_load(times, i))
end




## Unmap
#
wgpuBufferUnmap(outputBuffer)

## TODO dump as an image






