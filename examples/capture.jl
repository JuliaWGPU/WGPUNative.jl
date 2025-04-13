
## Load WGPU
using WGPUNative

include("$(pkgdir(WGPUNative))/examples/logcallback.jl")
include("$(pkgdir(WGPUNative))/examples/requestAdapter.jl")
include("$(pkgdir(WGPUNative))/examples/requestDevice.jl")

## Buffer dimensions
width, height = (32, 32)

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
bufferLabel = "Output Buffer"

bufferDesc = WGPUBufferDescriptor |> CStruct
bufferDesc.nextInChain = C_NULL
bufferDesc.label = WGPUStringView(C_NULL, 0)
bufferDesc.usage = WGPUBufferUsage(WGPUBufferUsage_MapRead | WGPUBufferUsage_CopyDst)
bufferDesc.size = (bufferSize) |> Int64
bufferDesc.mappedAtCreation = false

outputBuffer = GC.@preserve bufferDesc bufferLabel wgpuDeviceCreateBuffer(
    device,
    bufferDesc |> ptr
)

## textureExtent 

# textureExtent = WGPUExtent3D |> CStruct
# textureExtent.width = bufferDimensions.width
# textureExtent.height = bufferDimensions.height
# textureExtent.depthOrArrayLayers = 1

textureExtent = WGPUExtent3D(
    bufferDimensions.width,
    bufferDimensions.height,
    1 # depth of array layers
)

ltext = "texture"

## texture
textureDesc = WGPUTextureDescriptor(
    C_NULL,
    WGPUStringView(pointer(ltext), length(ltext)),
    WGPUTextureUsage(WGPUTextureUsage_RenderAttachment | WGPUTextureUsage_CopySrc),
    WGPUTextureDimension_2D,
    textureExtent,
    WGPUTextureFormat_RGBA8UnormSrgb,
    1,
    1,
    0, 
    C_NULL
)

# sv = WGPUStringView |> CStruct
# sv.data = pointer(ltext)
# sv.length = WGPU_STRLEN


# textureDesc = WGPUTextureDescriptor |> CStruct
# textureDesc.nextInChain = C_NULL
# textureDesc.usage = WGPUTextureUsage_None
# textureDesc.label = sv |> concrete
# textureDesc.size = textureExtent
# textureDesc.mipLevelCount = 1
# textureDesc.sampleCount = 1
# textureDesc.dimension = WGPUTextureDimension_2D
# textureDesc.format = WGPUTextureFormat_RGBA8UnormSrgb

texture = wgpuDeviceCreateTexture(
    device,
    textureDesc |> Ref
)

## encoder
encoderDesc = WGPUCommandEncoderDescriptor |> CStruct
encoderDesc.nextInChain = C_NULL
encoderDesc.label = WGPUStringView(C_NULL, 0)
encoder = GC.@preserve device encoderDesc wgpuDeviceCreateCommandEncoder(
        device, 
        (encoderDesc) |> ptr
)

## outputAttachment

outputAttachment = GC.@preserve texture wgpuTextureCreateView(
    texture,
    C_NULL
)

## renderPass
colorAttachments = GC.@preserve outputAttachment begin
	colorAttachments = WGPURenderPassColorAttachment[]
	push!(colorAttachments, WGPURenderPassColorAttachment(
			C_NULL,
			outputAttachment,
			0,
			0,
			WGPULoadOp_Clear,
			WGPUStoreOp_Store,
			WGPUColor(1.0, 0.0, 0.0, 1.0)
		)
	)
	colorAttachments
end

renderPassDesc = GC.@preserve colorAttachments begin
	renderpassdesc = WGPURenderPassDescriptor |> CStruct
	renderpassdesc.nextInChain = C_NULL
	renderpassdesc.label = WGPUStringView(C_NULL, 0)
	renderpassdesc.colorAttachments = pointer(colorAttachments)
	renderpassdesc.depthStencilAttachment = C_NULL
	renderpassdesc.occlusionQuerySet = C_NULL
	renderpassdesc.timestampWrites = C_NULL
	renderpassdesc.colorAttachmentCount = 1
	renderpassdesc
end

renderPass = GC.@preserve renderPassDesc colorAttachments wgpuCommandEncoderBeginRenderPass(
    encoder,
    ptr(renderPassDesc)
)

GC.gc()
## end renderpass 
wgpuRenderPassEncoderEnd(renderPass)
wgpuRenderPassEncoderRelease(renderPass)

## Copy texture to buffer
textureDataLayout = WGPUTexelCopyBufferLayout(
	0,		#offset
	bufferDimensions.padded_bytes_per_row, #bytesPerRow
	WGPU_COPY_STRIDE_UNDEFINED #rowsPerImage
)

imgCopyBuffer = WGPUTexelCopyBufferInfo(
    textureDataLayout,
    outputBuffer
)

imgCopyTexture = WGPUTexelCopyTextureInfo(
	texture, #texture
	0, #mipLevel
	WGPUOrigin3D(0, 0, 0), #origin
	WGPUTextureAspect_All #aspect
)

GC.@preserve imgCopyTexture imgCopyBuffer textureExtent wgpuCommandEncoderCopyTextureToBuffer(
    encoder,
    Ref(imgCopyTexture),
    Ref(imgCopyBuffer),
    Ref(textureExtent)
)

queue = wgpuDeviceGetQueue(device)

## commandBuffer
cmdDesc = WGPUCommandBufferDescriptor(C_NULL, WGPUStringView(C_NULL, 0))

cmdBuffer = GC.@preserve cmdDesc encoder wgpuCommandEncoderFinish(
    encoder,
    Ref(cmdDesc)
)

## submit queue

wgpuQueueSubmit(queue, 1, Ref(cmdBuffer))

## MapAsync
asyncstatus = WGPUMapAsyncStatus(0)


function readBufferMap(
        status::WGPUMapAsyncStatus,
        userData)
    global asyncstatus
    asyncstatus = status
    return nothing
end

readbuffermap = @cfunction(readBufferMap, Cvoid, (WGPUMapAsyncStatus, Ptr{Cvoid}))

bufferMapCallbackInfo = CStruct(WGPUBufferMapCallbackInfo)
bufferMapCallbackInfo.callback = readbuffermap


wgpuBufferMapAsync(outputBuffer, WGPUMapMode_Read, 0, bufferSize, bufferMapCallbackInfo |> concrete)


## device polling

wgpuDevicePoll(device, true, C_NULL)
print(asyncstatus)

@assert asyncstatus == WGPUMapAsyncStatus_Success

## times
times = convert(Ptr{UInt8}, wgpuBufferGetMappedRange(outputBuffer, 0, bufferSize))

## result
for i in 1:width*height
    println(i, " : ", unsafe_load(times, i))
end

## Unmap
wgpuBufferUnmap(outputBuffer)

GC.gc()
## TODO dump as an image
