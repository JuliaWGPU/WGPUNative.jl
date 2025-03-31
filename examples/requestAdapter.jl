## Load WGPU
using WGPUNative
using Infiltrator
adapter = WGPUAdapter()

function request_adapter_callback(
				status::WGPURequestAdapterStatus,
				returnAdapter::WGPUAdapter,
			   message::Ptr{Cchar},
			   userData::Ptr{Cvoid})
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


requestAdapterCallback = @cfunction(request_adapter_callback, Cvoid, (WGPURequestAdapterStatus, WGPUAdapter, Ptr{Cchar}, Ptr{Cvoid}))

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

infoArray = Ptr{WGPUAdapterInfo}()
function getWGPUAdapterInfo()
	info = WGPUAdapterInfo()
	GC.@preserve adapter infoArray wgpuAdapterGetInfo(adapter, info)
	return info
end

infos = getWGPUAdapterInfo()

nativelimits = WGPUNativeLimits()
supportedLimits = WGPULimits(
	nativelimits.chain.next,
	zeros(UInt32, 14)...,
	zeros(UInt64, 2)...,
	zeros(UInt32, 3)...,
	UInt64(0),
	zeros(UInt32, 11)...
) |> Ref

function getWGPUAdapterLimits(suportedLimits)
	chainsOutSet = wgpuAdapterGetLimits(adapter, supportedLimits)
	return chainsOutSet
end

status = getWGPUAdapterLimits(supportedLimits)

if status == WGPUStatus_Success
	# Print supportedLimits here
end
