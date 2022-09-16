const SIZE_MAX = 1024
using Libdl
using Pkg
using Pkg.Artifacts

artifact_toml = joinpath(@__DIR__, "..", "Artifacts.toml")

wgpu_hash = artifact_hash("WGPUNative", artifact_toml)

wgpulibpath = artifact_path(wgpu_hash)

const libWGPU = "$wgpulibpath/libwgpu.$(Libdl.dlext)" |> normpath

const DEFAULT_ARRAY_SIZE = 1024
