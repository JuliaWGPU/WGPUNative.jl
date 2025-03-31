# SIZE_MAX needs verification
const SIZE_MAX = 2^32

using Libdl
using Pkg
using Pkg.Artifacts

artifact_toml = joinpath(@__DIR__, "..", "Artifacts.toml")

wgpu_hash = artifact_hash("WGPUNative", artifact_toml)

wgpulibpath = artifact_path(wgpu_hash)
resourceName = Sys.iswindows() ? "wgpu_native" : "libwgpu_native"
const libWGPU = "$wgpulibpath/lib/$resourceName.$(Libdl.dlext)" |> normpath
