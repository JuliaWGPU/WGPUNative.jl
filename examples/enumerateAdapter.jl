using WGPUNative

instance = wgpuCreateInstance(C_NULL)

@assert instance != C_NULL

adapterCount = wgpuInstanceEnumerateAdapters(instance, C_NULL, C_NULL)

adapters = WGPUAdapter[WGPUAdapter() for _ in 1:adapterCount]

GC.@preserve adapters wgpuInstanceEnumerateAdapters(instance, C_NULL, adapters |> pointer)

for (idx, adapter) in enumerate(adapters)
	properties = WGPUAdapterProperties()
	GC.@preserve properties wgpuAdapterGetProperties(adapter, properties |> pointer_from_objref)
	vendorID = properties.vendorID |> Int
	architecture = properties.architecture |> unsafe_string
	deviceID = properties.deviceID |> Int
	name = properties.name |> unsafe_string
	vendorName = properties.vendorName |> unsafe_string
	description = properties.driverDescription |> unsafe_string
	adapterType = properties.adapterType
	backendType = properties.backendType
	@info( name,
		adapter, 
		idx, 
		vendorID,
		vendorName,
		architecture,
		deviceID,
		description,
		adapterType,
		backendType
	)
	wgpuAdapterRelease(adapter)
end

adapters = WGPUAdapter[]
wgpuInstanceRelease(instance)

