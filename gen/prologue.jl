# SIZE_MAX needs verification
const SIZE_MAX = 2^32
const UINT32_MAX = 0xffffffff
const UINT64_MAX = 0xffffffffffffffff

const WGPUFlags = UInt32

@cenum WGPUBufferUsage::WGPUFlags begin
	WGPUBufferUsage_None = 0x0000000000000000;
	WGPUBufferUsage_MapRead = 0x0000000000000001;
	WGPUBufferUsage_MapWrite = 0x0000000000000002;
	WGPUBufferUsage_CopySrc = 0x0000000000000004;
	WGPUBufferUsage_CopyDst = 0x0000000000000008;
	WGPUBufferUsage_Index = 0x0000000000000010;
	WGPUBufferUsage_Vertex = 0x0000000000000020;
	WGPUBufferUsage_Uniform = 0x0000000000000040;
	WGPUBufferUsage_Storage = 0x0000000000000080;
	WGPUBufferUsage_Indirect = 0x0000000000000100;
	WGPUBufferUsage_QueryResolve = 0x0000000000000200;
end 

@cenum WGPUColorWriteMask::WGPUFlags begin
	WGPUColorWriteMask_None = 0x0000000000000000;
	WGPUColorWriteMask_Red = 0x0000000000000001;
	WGPUColorWriteMask_Green = 0x0000000000000002;
	WGPUColorWriteMask_Blue = 0x0000000000000004;
	WGPUColorWriteMask_Alpha = 0x0000000000000008;
	WGPUColorWriteMask_All = 0x000000000000000F #/* Red | Green | Blue | Alpha */;
end

@cenum WGPUMapMode::WGPUFlags begin
	WGPUMapMode_None = 0x0000000000000000;
	WGPUMapMode_Read = 0x0000000000000001;
	WGPUMapMode_Write = 0x0000000000000002;
end

@cenum WGPUShaderStage::WGPUFlags begin
	WGPUShaderStage_None = 0x0000000000000000;
	WGPUShaderStage_Vertex = 0x0000000000000001;
	WGPUShaderStage_Fragment = 0x0000000000000002;
	WGPUShaderStage_Compute = 0x0000000000000004;
end

@cenum WGPUTextureUsage::WGPUFlags begin
	WGPUTextureUsage_None = 0x0000000000000000;
	WGPUTextureUsage_CopySrc = 0x0000000000000001;
	WGPUTextureUsage_CopyDst = 0x0000000000000002;
	WGPUTextureUsage_TextureBinding = 0x0000000000000004;
	WGPUTextureUsage_StorageBinding = 0x0000000000000008;
	WGPUTextureUsage_RenderAttachment = 0x0000000000000010;
end

using Libdl
using Pkg
using Pkg.Artifacts

artifact_toml = joinpath(@__DIR__, "..", "Artifacts.toml")

wgpu_hash = artifact_hash("WGPUNative", artifact_toml)

wgpulibpath = artifact_path(wgpu_hash)
resourceName = Sys.iswindows() ? "wgpu_native" : "libwgpu_native"
const libWGPU = "$wgpulibpath/lib/$resourceName.$(Libdl.dlext)" |> normpath
