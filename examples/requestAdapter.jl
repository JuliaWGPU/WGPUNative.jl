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

Base.cconvert(::Type{Ptr{WGPUSupportedLimits}}, supportedLimits::WGPUSupportedLimits) = begin\
	pointer_from_objref(supportedLimits)
end

Base.cconvert(::Type{Ptr{WGPUSupportedLimits}}, supportedLimits::Array{WGPUSupportedLimits, 1}) = begin
	pointer(supportedLimits)
end

requestAdapterCallback = @cfunction(request_adapter_callback, Cvoid, (WGPURequestAdapterStatus, WGPUAdapter, Ptr{Cchar}, Ptr{Cvoid}))

instance = wgpuCreateInstance(C_NULL)

wgpuInstanceRequestAdapter(
	instance, 
	C_NULL, 
	requestAdapterCallback,
	adapter
)

@assert adapter != C_NULL

infoArray = Ptr{WGPUAdapterInfo}()
function getWGPUAdapterInfo()
	info = WGPUAdapterInfo()
	GC.@preserve adapter infoArray wgpuAdapterGetInfo(adapter, info)
	return info
end

infos = getWGPUAdapterInfo()

function getWGPUAdapterLimits()
	supportedLimits = WGPUSupportedLimits()
	extrasPtr = Ptr{WGPUSupportedLimitsExtras}(Libc.malloc(sizeof(WGPUSupportedLimitsExtras)))
	supportedLimits.nextInChain = extrasPtr
	chainsOutSet = GC.@preserve adapter supportedLimits wgpuAdapterGetLimits(adapter, supportedLimits)
	finalizer(supportedLimits) do x
		Libc.free(x.nextInChain)
	end
	return supportedLimits
end

supportedLimits =  GC.@preserve getWGPUAdapterLimits()

