## Load WGPU
using WGPUNative
using GLFW
## Constants

numbers = UInt32[1,2,3,4]

const DEFAULT_ARRAY_SIZE = 256

## Init Window Size

width = 400
height = 400

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

wgpuSetLogCallback(logcallback)
wgpuSetLogLevel(WGPULogLevel(4))

## Surface 
## X11 Surface
using WGPU
using WGPU: partialInit, defaultInit, pointerRef
using WGPU_jll
using GLFW

surface = Ref(Ptr{Nothing}())

display = GLFW.GetX11Display()
window = GLFW.Window()
windowX11 = GLFW.GetX11Window(window)
surface = wgpuInstanceCreateSurface(
    C_NULL,
    pointer_from_objref(
    	Ref(partialInit(
               WGPUSurfaceDescriptor;
               label = C_NULL,
               nextInChain = pointer_from_objref(Ref(partialInit(	                       
                   WGPUSurfaceDescriptorFromXlibWindow;
                   chain = partialInit(
                       WGPUChainedStruct;
                       next = C_NULL,
                       sType = WGPUSType_SurfaceDescriptorFromXlibWindow
                   ),
                   display = display,
                   window = windowX11.handle
               )))
           ))
    	)
    )


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

wgpuInstanceRequestAdapter(C_NULL, 
						   adapterOptions, 
						   requestAdapterCallback,
						   adapter)

##

chain = WGPUChainedStruct(C_NULL, WGPUSType(6))

deviceName = Vector{UInt8}("Device")
deviceExtras = WGPUDeviceExtras(chain, defaultInit(WGPUNativeFeature), pointer(deviceName), C_NULL)

const DEFAULT_ARRAY_SIZE = 256

wgpuLimits = partialInit(WGPULimits; maxBindGroups = 1)

wgpuRequiredLimits = WGPURequiredLimits(C_NULL, wgpuLimits)

wgpuQueueDescriptor = WGPUQueueDescriptor(C_NULL, C_NULL)

wgpuDeviceDescriptor = Ref(
                        partialInit(
                            WGPUDeviceDescriptor,
                            nextInChain = pointer_from_objref(Ref(partialInit(WGPUChainedStruct, chain=deviceExtras))),
                            requiredLimits = pointer_from_objref(Ref(wgpuRequiredLimits)),
                            defaultQueue = wgpuQueueDescriptor
                        )
                      )


wgpuAdapterRequestDevice(
                 adapter[],
                 wgpuDeviceDescriptor,
                 requestDeviceCallback,
                 device[])


## Device un captured callbacks


## Device lost callbacks


## 

                 
##
b = read(pkgdir(WGPU_jll)*"/examples/shader.wgsl")  
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


shaderSource = Ref(pkgdir(WGPU_jll)*"/examples/triangle.wgsl")[1])

##


shader = wgpuDeviceCreateShaderModule(
    device[],
    pointer_from_objref(shaderSource)
)


## 


## Pipeline Layout
pipelineLayout = wgpuDeviceCreatePipelineLayout(
    device[],
    pointer_from_objref(Ref(partialInit(
        WGPUPipelineLayoutDescriptor;
        bindGroupLayouts = C_NULL,
        bindGroupLayoutCount = 0
       )
    )))


## swapchains 

swapChainFormat = wgpuSurfaceGetPreferredFormat(surface, adapter[])



## pipeline
# 
# pipeline = wgpuDeviceCreateRenderPipeline(
    # device[],
    # pointer_from_objref(Ref(partialInit(
        # WGPURenderPipelineDescriptor;
        # label = pointer(Vector{UInt8}("Render pipeline")),
        # layout = pipelineLayout,
        # vertex = partialInit(
            # WGPUVertexState,
            # _module=shader,
            # entryPoint = pointer(Vector{UInt8}("vs_main")),
            # bufferCount = 0,
            # buffers = C_NULL
           # ),
        # primitive = partialInit(
            # WGPUPrimitiveState;
            # topology = WGPUPrimitiveTopology_TriangleList,
            # stripIndexFormat = WGPUIndexFormat_Undefined,
            # frontFace = WGPUFrontFace_CCW,
            # cullMode = WGPUCullMode_None),
        # multisample = partialInit(
            # WGPUMultisampleState;
            # count = 1,
            # mask = typemax(UInt32),
            # alphaToCoverageEnabled = false,
           # ),
        # fragment = pointer_from_objref(Ref(partialInit(
            # WGPUFragmentState;
            # _module = shader,
            # entryPoint = pointer(Vector{UInt8}("fs_main")),
            # targetCount = 1,
            # targets = pointer_from_objref(Ref(partialInit(
                # WGPUColorTargetState;
                # format=swapChainFormat,
                # blend = pointer_from_objref(Ref(partialInit(
                    # WGPUBlendState;
                    # color = partialInit(
                        # WGPUBlendComponent;
                        # srcFactor = WGPUBlendFactor_One,
                        # dstFactor = WGPUBlendFactor_Zero,
                        # operation = WGPUBlendOperation_Add,
                       # ),
                    # alpha = partialInit(
                        # WGPUBlendComponent;
                        # srcFactor = WGPUBlendFactor_One,
                        # dstFactor = WGPUBlendFactor_Zero,
                        # operation = WGPUBlendOperation_Add,
                       # ),
                   # ))),
                # writeMask = WGPUColorWriteMask_All))))),
           # ),
        # depthStencil = C_NULL,
       # ))))

pipeline = wgpuDeviceCreateRenderPipeline(
    device[],
    pointer_from_objref(Ref(partialInit(
        WGPURenderPipelineDescriptor;
        label = pointer(Vector{UInt8}("Render pipeline")),
        layout = pipelineLayout,
        vertex = partialInit(
            WGPUVertexState,
            _module=shader,
            entryPoint = pointer(Vector{UInt8}("vs_main")),
            bufferCount = 0,
            buffers = C_NULL
           ),
        primitive = partialInit(
            WGPUPrimitiveState;
            topology = WGPUPrimitiveTopology_TriangleList,
            stripIndexFormat = WGPUIndexFormat_Undefined,
            frontFace = WGPUFrontFace_CCW,
            cullMode = WGPUCullMode_None),
        multisample = partialInit(
            WGPUMultisampleState;
            count = 1,
            mask = typemax(UInt32),
            alphaToCoverageEnabled = false,
           ),
        fragment = pointer([partialInit(
            WGPUFragmentState;                                                       
            _module = shader,
            entryPoint = pointer(Vector{UInt8}("fs_main")),
            targetCount = 1,
            targets = pointer([partialInit(
                WGPUColorTargetState;                                                          
                format=swapChainFormat,
                blend = pointer_from_objref(Ref(partialInit(
                    WGPUBlendState;
                    color = partialInit(
                        WGPUBlendComponent;
                        srcFactor = WGPUBlendFactor_One,
                        dstFactor = WGPUBlendFactor_Zero,
                        operation = WGPUBlendOperation_Add,
                       ),
                    alpha = partialInit(
                        WGPUBlendComponent;
                        srcFactor = WGPUBlendFactor_One,
                        dstFactor = WGPUBlendFactor_Zero,
                        operation = WGPUBlendOperation_Add,
                       ),
                ))),
                writeMask = WGPUColorWriteMask_All)])
           )]),
        depthStencil = C_NULL,
	)))
)



## previos dims

prevWidth = 0;
prevHeight = 0;

(prevWidth, prevHeight) = GLFW.GetWindowSize(window)

swapChain = Ref(wgpuDeviceCreateSwapChain(
    device[],
    surface,
    pointer_from_objref(Ref(partialInit(
        WGPUSwapChainDescriptor;
        usage = WGPUTextureUsage_RenderAttachment,
        format = swapChainFormat,
        width = prevWidth,
        height = prevHeight,
        presentMode = WGPUPresentMode_Fifo,
       )))))

## Window loop
queue = Ref(C_NULL)
encoder = Ref(C_NULL)
renderPass = Ref(C_NULL)
nextTexture = Ref(C_NULL)
cmdBuffer = Ref(C_NULL)


while !GLFW.WindowShouldClose(window)
    global encoder, renderPass, nextTexture
    for attempt in 0:2
        global width = 0
        global height = 0
        (width, height) = GLFW.GetWindowSize(window)
        if (width != prevWidth) || (height != prevHeight)
            global prevWidth = width
            global prevHeight = height

 
            swapChain[] = wgpuDeviceCreateSwapChain(
                device[],
                surface,
                pointer_from_objref(Ref(partialInit(
                    WGPUSwapChainDescriptor;
                    usage = WGPUTextureUsage_RenderAttachment,
                    format = swapChainFormat,
                    width = prevWidth,
                    height = prevHeight,
                    presentMode = WGPUPresentMode_Fifo,
                ))))
        end

        nextTexture[] = wgpuSwapChainGetCurrentTextureView(swapChain[]);

        if attempt == 0 && nextTexture[] == C_NULL
            @error ("wgpuSwapChainGetCurrentTextureView() failed; Trying to create a new swap chain")
            prevWidth = 0
            prevHeight = 0
            continue
        end
        break
    end

    if nextTexture[] == C_NULL
        @error ("Cannot acquire next swap chain texture\n")
        exit(1)
    end
        
    encoder[] = wgpuDeviceCreateCommandEncoder(
        device[],
        pointer_from_objref(Ref(partialInit(
            WGPUCommandEncoderDescriptor;
            label = pointer(Vector{UInt8}("Command Encoder"))
           )
    )))

    renderPass[] = wgpuCommandEncoderBeginRenderPass(
        encoder[],
        pointer_from_objref(Ref(partialInit(
            WGPURenderPassDescriptor;
            colorAttachments = pointer_from_objref(Ref(partialInit(
                WGPURenderPassColorAttachment;
                view = nextTexture[],
                resolveTarget = 0,
                loadOp = WGPULoadOp_Clear,
                storeOp = WGPUStoreOp_Store,
                clearValue = WGPUColor(0.0, 1.0, 0.0, 1.0),
               ))),
            colorAttachmentCount = 1,
            depthStencilAttachment = C_NULL,
           ))))

    wgpuRenderPassEncoderSetPipeline(renderPass[], pipeline)
    wgpuRenderPassEncoderDraw(renderPass[], 3, 1, 0, 0)
    wgpuRenderPassEncoderEnd(renderPass[])

    queue[] = wgpuDeviceGetQueue(device[])
    cmdBuffer[] = wgpuCommandEncoderFinish(
        encoder[],
        pointer_from_objref(Ref(partialInit(
            WGPUCommandBufferDescriptor;
            label = C_NULL
           ))))
    
    wgpuQueueSubmit(queue[], 1, pointer_from_objref(cmdBuffer))
    wgpuSwapChainPresent(swapChain[])
    GLFW.PollEvents()
end

## Destroy window
GLFW.DestroyWindow(window)
GLFW.Terminate()

            
