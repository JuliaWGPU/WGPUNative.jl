using WGPUNative

instance = wgpuCreateInstance(C_NULL)

@assert instance != C_NULL

adapterCount = wgpuInstanceEnumerateAdapters(instance, C_NULL, C_NULL)

const adapters = Vector{WGPUAdapter}(undef, adapterCount)

GC.@preserve adapters wgpuInstanceEnumerateAdapters(instance, C_NULL, adapters)

for idx = 1:adapterCount
    adapter = adapters[idx]
    info = Ref(WGPUAdapterInfo())
    GC.@preserve info wgpuAdapterGetInfo(adapter, Base.unsafe_convert(Ptr{WGPUAdapterInfo}, info))
    vendorID = Int(info[].vendorID)
    architecture= ""
    if info[].architecture.length > 1
    	architecture = unsafe_string(info[].architecture.data, info[].architecture.length)
    end
    deviceID = Int(info[].deviceID)
    vendorName = unsafe_string(info[].vendor.data, info[].vendor.length)
    description = unsafe_string(info[].description.data, info[].description.length)
    adapterType = info[].adapterType
    backendType = info[].backendType
    @info(adapter,
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

empty!(adapters)
wgpuInstanceRelease(instance)

