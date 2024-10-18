## Load WGPU
using WGPUNative

include("$(pkgdir(WGPUNative))/examples/logcallback.jl")
include("$(pkgdir(WGPUNative))/examples/requestAdapter.jl")
include("$(pkgdir(WGPUNative))/examples/requestDevice.jl")

supportedLimits =  GC.@preserve getWGPUAdapterLimits()

featureCount = wgpuAdapterEnumerateFeatures(adapter, C_NULL)

featureList = map(WGPUFeatureName, zeros(Int, featureCount))

wgpuAdapterEnumerateFeatures(adapter, featureList)

devFeatureCount = wgpuDeviceEnumerateFeatures(device, C_NULL)
devFeatureList = map(WGPUFeatureName, zeros(Int, devFeatureCount))

wgpuDeviceEnumerateFeatures(device, devFeatureList)
