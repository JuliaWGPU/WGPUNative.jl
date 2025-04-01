## Load WGPU
using WGPUNative

adapter = WGPUAdapter()

function request_adapter_callback(
				status::WGPURequestAdapterStatus,
				returnAdapter::WGPUAdapter,
			   message::WGPUStringView,
			   userdata::Ptr{Cvoid}
		   )
    global adapter = returnAdapter
    return nothing
end

Base.cconvert(::Type{Ptr{WGPUAdapterInfo}}, info::WGPUAdapterInfo) = begin
	pointer_from_objref(info)
end

Base.cconvert(::Type{Ptr{WGPULimits}}, supportedLimits::WGPULimits) = begin\
	pointer_from_objref(supportedLimits)
end

Base.cconvert(::Type{Ptr{WGPULimits}}, supportedLimits::Array{WGPULimits, 1}) = begin
	pointer(supportedLimits)
end


requestAdapterCallback = @cfunction(request_adapter_callback, Cvoid, (WGPURequestAdapterStatus, WGPUAdapter, WGPUStringView, Ptr{Cvoid}))

callbackInfo = WGPURequestAdapterCallbackInfo()
callbackInfo.nextInChain = C_NULL
callbackInfo.userdata1 = adapter
callbackInfo.callback = requestAdapterCallback

instance = wgpuCreateInstance(C_NULL)

wgpuInstanceRequestAdapter(
	instance, 
	C_NULL, 
	callbackInfo,
)

@assert adapter != C_NULL

function getWGPUAdapterInfo()
	info = WGPUAdapterInfo()
	GC.@preserve adapter wgpuAdapterGetInfo(adapter, info)
	return info
end

infos = getWGPUAdapterInfo()

nativelimits = CStruct(WGPUNativeLimits)
supportedLimits = CStruct(WGPULimits)
supportedLimits.nextInChain = nativelimits.chain.next

function getWGPUAdapterLimits(supportedLimits)
	chainsOutSet = wgpuAdapterGetLimits(adapter, supportedLimits)
	return chainsOutSet
end
supportedLimitsPtr = ptr(supportedLimits)
status = getWGPUAdapterLimits(supportedLimitsPtr)

if status == WGPUStatus_Success
	# Print supportedLimits here
end
