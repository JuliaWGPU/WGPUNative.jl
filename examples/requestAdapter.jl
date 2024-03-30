## Load WGPU
using WGPUNative

adapter = WGPUAdapter()

function request_adapter_callback(
				status::WGPURequestAdapterStatus,
				returnAdapter::WGPUAdapter,
			   message::Ptr{Cchar},
			   userData::Ptr{Cvoid})
    global adapter = returnAdapter
    return nothing
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

properties = WGPUAdapterProperties()

wgpuAdapterGetProperties(adapter, pointer_from_objref(properties))

supportedLimits = WGPUSupportedLimits()

wgpuAdapterGetLimits(adapter, pointer_from_objref(supportedLimits))


