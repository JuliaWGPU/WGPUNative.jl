## Load WGPU
using WGPUNative

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
wgpuSetLogLevel(WGPULogLevel_Debug)

adapter = Ref{WGPUAdapter}()

chain = cStruct(
    WGPUChainedStruct;
    sType = WGPUSType(Int64(WGPUSType_AdapterExtras)),
)


extras = cStruct(
    WGPUAdapterExtras;
    backend=WGPUBackendType_Vulkan, # TODO hardcoding on windows for now
    chain = chain |> concrete
)

# extras.chain = chain |> concrete

adapterOptions = cStruct(WGPURequestAdapterOptions)
adapterOptions.compatibleSurface = C_NULL
adapterOptions.nextInChain = rawCast(WGPUChainedStruct, extras)
adapterOptions.powerPreference = WGPUPowerPreference_HighPerformance
adapterOptions.forceFallbackAdapter = false

function request_adapter_callback(
				status::WGPURequestAdapterStatus,
				returnAdapter::WGPUAdapter,
			   message::Ptr{Cchar},
			   userData::Ptr{Cvoid})
    global adapter
    # @debug status
    if status == WGPURequestAdapterStatus_Success
        adapter[] = returnAdapter
    elseif message != C_NULL
        @error unsafe_string(message)
    end
	return nothing
end

requestAdapterCallback = @cfunction(request_adapter_callback, Cvoid, (WGPURequestAdapterStatus, WGPUAdapter, Ptr{Cchar}, Ptr{Cvoid}))
## request adapter 
instanceDesc = cStruct(WGPUInstanceDescriptor)
instanceDesc.nextInChain = C_NULL

instance = wgpuCreateInstance(instanceDesc  |> ptr)

wgpuInstanceRequestAdapter(instance, 
						   adapterOptions |> ptr, 
						   requestAdapterCallback,
						   C_NULL)

@assert adapter[] != C_NULL

properties = cStruct(WGPUAdapterProperties)

wgpuAdapterGetProperties(adapter[], properties |> ptr)

supportedLimits = cStruct(WGPUSupportedLimits)
cLimits = supportedLimits.limits

wgpuAdapterGetLimits(adapter[], supportedLimits |> ptr)




