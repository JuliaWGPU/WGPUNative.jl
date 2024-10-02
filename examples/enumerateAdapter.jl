using WGPUNative

instance = wgpuCreateInstance(C_NULL)

@assert instance != C_NULL

adapterOptions = WGPUInstanceEnumerateAdapterOptions() |> Ref

adapterCount = wgpuInstanceEnumerateAdapters(instance, adapterOptions, C_NULL)

const adapters = Vector{WGPUAdapter}(undef, adapterCount)

GC.@preserve adapters wgpuInstanceEnumerateAdapters(instance, adapterOptions, adapters)

for idx = 1:adapterCount
    adapter = adapters[idx]
    info = Ref(WGPUAdapterInfo())
    GC.@preserve info wgpuAdapterGetInfo(adapter, Base.unsafe_convert(Ptr{WGPUAdapterInfo}, info))
    vendorID = Int(info[].vendorID)
    architecture = unsafe_load(info[].architecture)
    deviceID = Int(info[].deviceID)
    vendorName = unsafe_string(info[].vendor)
    description = unsafe_string(info[].description)
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
