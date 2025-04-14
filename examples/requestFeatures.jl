## Load WGPU
using WGPUNative
using CEnum
include("$(pkgdir(WGPUNative))/examples/logcallback.jl")
include("$(pkgdir(WGPUNative))/examples/requestAdapter.jl")
include("$(pkgdir(WGPUNative))/examples/requestDevice.jl")

adapterFeatures = CStruct(WGPUSupportedFeatures)
wgpuAdapterGetFeatures(adapter, adapterFeatures |> ptr)

deviceFeatures = CStruct(WGPUSupportedFeatures)
wgpuDeviceGetFeatures(device, deviceFeatures |> ptr)
