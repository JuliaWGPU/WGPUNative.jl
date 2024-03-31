## Load WGPU
@warn "Garbage Collector State"  GC.enable(false)
using WGPUNative

include("$(pkgdir(WGPUNative))/examples/logcallback.jl")
include("$(pkgdir(WGPUNative))/examples/requestAdapter.jl")
include("$(pkgdir(WGPUNative))/examples/requestDevice.jl")

## Buffer dimensions
width, height = (20, 20)

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

bufferDesc = WGPUBufferDescriptor()
bufferLabel = "Output Buffer"
bufferDesc.label = pointer(bufferLabel)
bufferDesc.usage = WGPUBufferUsage_MapRead | WGPUBufferUsage_CopyDst
bufferDesc.size = bufferSize
bufferDesc.mappedAtCreation = false

outputBuffer = GC.@preserve bufferDesc bufferLabel wgpuDeviceCreateBuffer(
    device,
    pointer_from_objref(bufferDesc)
)

## textureExtent 

textureExtent = WGPUExtent3D(
    bufferDimensions.width,
    bufferDimensions.height,
    1 # depth of array layers
)

## texture

textureDesc = WGPUTextureDescriptor()
textureDesc.size = textureExtent
textureDesc.mipLevelCount = 1
textureDesc.sampleCount = 1
textureDesc.dimension = WGPUTextureDimension_2D
textureDesc.format = WGPUTextureFormat_RGBA8UnormSrgb
textureDesc.usage = WGPUTextureUsage_RenderAttachment | WGPUTextureUsage_CopySrc

texture = GC.@preserve device textureDesc wgpuDeviceCreateTexture(
    device,
    pointer_from_objref(textureDesc)
)

## encoder
encoderDesc = WGPUCommandEncoderDescriptor()
encoder = GC.@preserve device encoderDesc wgpuDeviceCreateCommandEncoder(
        device, 
        pointer_from_objref(encoderDesc)
)

## outputAttachment

outputAttachment = GC.@preserve texture wgpuTextureCreateView(
    texture,
    C_NULL
)

## renderPass
renderPassDesc = WGPURenderPassDescriptor()
colorAttachments = WGPURenderPassColorAttachment[]
push!(colorAttachments, WGPURenderPassColorAttachment(
		C_NULL,
		outputAttachment,
		0,
		WGPULoadOp_Clear,
		WGPUStoreOp_Store,
		WGPUColor(1.0, 0.0, 0.0, 1.0)
	)
)
renderPassDesc.colorAttachments = pointer(colorAttachments)
renderPassDesc.colorAttachmentCount = 1

renderPass = GC.@preserve renderPassDesc wgpuCommandEncoderBeginRenderPass(
    encoder,
    pointer_from_objref(renderPassDesc)
)

## end renderpass 
wgpuRenderPassEncoderEnd(renderPass)

## Copy texture to buffer
textureDataLayout = WGPUTextureDataLayout(
	C_NULL, #nextInChain
	0,		#offset
	bufferDimensions.padded_bytes_per_row, #bytesPerRow
	WGPU_COPY_STRIDE_UNDEFINED #rowsPerImage
)

imgCopyBuffer = WGPUImageCopyBuffer()
imgCopyBuffer.buffer = outputBuffer
imgCopyBuffer.layout = textureDataLayout

imgCopyTexture = WGPUImageCopyTexture(
	C_NULL, #nextInChain
	texture, #texture
	0, #mipLevel
	WGPUOrigin3D(0, 0, 0), #origin
	WGPUTextureAspect_All #aspect
)

GC.@preserve imgCopyTexture imgCopyBuffer textureExtent wgpuCommandEncoderCopyTextureToBuffer(
    encoder,
    Ref(imgCopyTexture),
    pointer_from_objref(imgCopyBuffer),
    Ref(textureExtent)
)

queue = wgpuDeviceGetQueue(device)

## commandBuffer
cmdDesc = WGPUCommandBufferDescriptor()
cmdBuffer = GC.@preserve cmdDesc encoder wgpuCommandEncoderFinish(
    encoder,
    pointer_from_objref(cmdDesc)
)

## submit queue

wgpuQueueSubmit(queue, 1, Ref(cmdBuffer))

## MapAsync
asyncstatus = WGPUBufferMapAsyncStatus(2)

function readBufferMap(
        status::WGPUBufferMapAsyncStatus,
        userData)
    asyncstatus = status
    return nothing
end

readbuffermap = @cfunction(readBufferMap, Cvoid, (WGPUBufferMapAsyncStatus, Ptr{Cvoid}))

wgpuBufferMapAsync(outputBuffer, WGPUMapMode_Read, 0, bufferSize, readbuffermap, C_NULL)

print(asyncstatus)

## device polling

wgpuDevicePoll(device, true, C_NULL)

## times
times = convert(Ptr{UInt8}, wgpuBufferGetMappedRange(outputBuffer, 0, bufferSize))

## result
for i in 1:width*height
    println(i, " : ", unsafe_load(times, i))
end

## Unmap
wgpuBufferUnmap(outputBuffer)

## TODO dump as an image
