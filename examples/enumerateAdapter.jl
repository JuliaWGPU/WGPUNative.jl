@warn "Garbage Collector State"  GC.enable(false)
using WGPUNative

instance = wgpuCreateInstance(C_NULL)

@assert instance != C_NULL

adapterCount = wgpuInstanceEnumerateAdapters(instance, C_NULL, C_NULL)

adapters = WGPUAdapter[WGPUAdapter() for _ in 1:adapterCount]

wgpuInstanceEnumerateAdapters(instance, C_NULL, adapters |> pointer)

for (idx, adapter) in enumerate(adapters)
	properties = WGPUAdapterProperties()
	wgpuAdapterGetProperties(adapter, properties |> pointer_from_objref)
	@info(
		adapter, 
		idx, 
		properties.vendorID,
		properties.vendorName,
		properties.architecture,
		properties.deviceID,
		properties.name,
		properties.driverDescription,
		properties.adapterType,
		properties.backendType
	)
	wgpuAdapterRelease(adapter)
end

adapters = WGPUAdapter[]
wgpuInstanceRelease(instance)

