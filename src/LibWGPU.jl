module LibWGPU

using CEnum

# SIZE_MAX needs verification
const SIZE_MAX = 2^16
using Libdl
using Pkg
using Pkg.Artifacts

artifact_toml = joinpath(@__DIR__, "..", "Artifacts.toml")

wgpu_hash = artifact_hash("WGPUNative", artifact_toml)

wgpulibpath = artifact_path(wgpu_hash)
resourceName = Sys.iswindows() ? "wgpu_native" : "libwgpu_native"
const libWGPU = "$wgpulibpath/$resourceName.$(Libdl.dlext)" |> normpath


const WGPUFlags = UInt32

mutable struct WGPUAdapterImpl end

const WGPUAdapter = Ptr{WGPUAdapterImpl}

mutable struct WGPUBindGroupImpl end

const WGPUBindGroup = Ptr{WGPUBindGroupImpl}

mutable struct WGPUBindGroupLayoutImpl end

const WGPUBindGroupLayout = Ptr{WGPUBindGroupLayoutImpl}

mutable struct WGPUBufferImpl end

const WGPUBuffer = Ptr{WGPUBufferImpl}

mutable struct WGPUCommandBufferImpl end

const WGPUCommandBuffer = Ptr{WGPUCommandBufferImpl}

mutable struct WGPUCommandEncoderImpl end

const WGPUCommandEncoder = Ptr{WGPUCommandEncoderImpl}

mutable struct WGPUComputePassEncoderImpl end

const WGPUComputePassEncoder = Ptr{WGPUComputePassEncoderImpl}

mutable struct WGPUComputePipelineImpl end

const WGPUComputePipeline = Ptr{WGPUComputePipelineImpl}

mutable struct WGPUDeviceImpl end

const WGPUDevice = Ptr{WGPUDeviceImpl}

mutable struct WGPUInstanceImpl end

const WGPUInstance = Ptr{WGPUInstanceImpl}

mutable struct WGPUPipelineLayoutImpl end

const WGPUPipelineLayout = Ptr{WGPUPipelineLayoutImpl}

mutable struct WGPUQuerySetImpl end

const WGPUQuerySet = Ptr{WGPUQuerySetImpl}

mutable struct WGPUQueueImpl end

const WGPUQueue = Ptr{WGPUQueueImpl}

mutable struct WGPURenderBundleImpl end

const WGPURenderBundle = Ptr{WGPURenderBundleImpl}

mutable struct WGPURenderBundleEncoderImpl end

const WGPURenderBundleEncoder = Ptr{WGPURenderBundleEncoderImpl}

mutable struct WGPURenderPassEncoderImpl end

const WGPURenderPassEncoder = Ptr{WGPURenderPassEncoderImpl}

mutable struct WGPURenderPipelineImpl end

const WGPURenderPipeline = Ptr{WGPURenderPipelineImpl}

mutable struct WGPUSamplerImpl end

const WGPUSampler = Ptr{WGPUSamplerImpl}

mutable struct WGPUShaderModuleImpl end

const WGPUShaderModule = Ptr{WGPUShaderModuleImpl}

mutable struct WGPUSurfaceImpl end

const WGPUSurface = Ptr{WGPUSurfaceImpl}

mutable struct WGPUSwapChainImpl end

const WGPUSwapChain = Ptr{WGPUSwapChainImpl}

mutable struct WGPUTextureImpl end

const WGPUTexture = Ptr{WGPUTextureImpl}

mutable struct WGPUTextureViewImpl end

const WGPUTextureView = Ptr{WGPUTextureViewImpl}

@cenum WGPUAdapterType::UInt32 begin
    WGPUAdapterType_DiscreteGPU = 0
    WGPUAdapterType_IntegratedGPU = 1
    WGPUAdapterType_CPU = 2
    WGPUAdapterType_Unknown = 3
    WGPUAdapterType_Force32 = 2147483647
end

@cenum WGPUAddressMode::UInt32 begin
    WGPUAddressMode_Repeat = 0
    WGPUAddressMode_MirrorRepeat = 1
    WGPUAddressMode_ClampToEdge = 2
    WGPUAddressMode_Force32 = 2147483647
end

@cenum WGPUBackendType::UInt32 begin
    WGPUBackendType_Undefined = 0
    WGPUBackendType_Null = 1
    WGPUBackendType_WebGPU = 2
    WGPUBackendType_D3D11 = 3
    WGPUBackendType_D3D12 = 4
    WGPUBackendType_Metal = 5
    WGPUBackendType_Vulkan = 6
    WGPUBackendType_OpenGL = 7
    WGPUBackendType_OpenGLES = 8
    WGPUBackendType_Force32 = 2147483647
end

@cenum WGPUBlendFactor::UInt32 begin
    WGPUBlendFactor_Zero = 0
    WGPUBlendFactor_One = 1
    WGPUBlendFactor_Src = 2
    WGPUBlendFactor_OneMinusSrc = 3
    WGPUBlendFactor_SrcAlpha = 4
    WGPUBlendFactor_OneMinusSrcAlpha = 5
    WGPUBlendFactor_Dst = 6
    WGPUBlendFactor_OneMinusDst = 7
    WGPUBlendFactor_DstAlpha = 8
    WGPUBlendFactor_OneMinusDstAlpha = 9
    WGPUBlendFactor_SrcAlphaSaturated = 10
    WGPUBlendFactor_Constant = 11
    WGPUBlendFactor_OneMinusConstant = 12
    WGPUBlendFactor_Force32 = 2147483647
end

@cenum WGPUBlendOperation::UInt32 begin
    WGPUBlendOperation_Add = 0
    WGPUBlendOperation_Subtract = 1
    WGPUBlendOperation_ReverseSubtract = 2
    WGPUBlendOperation_Min = 3
    WGPUBlendOperation_Max = 4
    WGPUBlendOperation_Force32 = 2147483647
end

@cenum WGPUBufferBindingType::UInt32 begin
    WGPUBufferBindingType_Undefined = 0
    WGPUBufferBindingType_Uniform = 1
    WGPUBufferBindingType_Storage = 2
    WGPUBufferBindingType_ReadOnlyStorage = 3
    WGPUBufferBindingType_Force32 = 2147483647
end

@cenum WGPUBufferMapAsyncStatus::UInt32 begin
    WGPUBufferMapAsyncStatus_Success = 0
    WGPUBufferMapAsyncStatus_ValidationError = 1
    WGPUBufferMapAsyncStatus_Unknown = 2
    WGPUBufferMapAsyncStatus_DeviceLost = 3
    WGPUBufferMapAsyncStatus_DestroyedBeforeCallback = 4
    WGPUBufferMapAsyncStatus_UnmappedBeforeCallback = 5
    WGPUBufferMapAsyncStatus_MappingAlreadyPending = 6
    WGPUBufferMapAsyncStatus_OffsetOutOfRange = 7
    WGPUBufferMapAsyncStatus_SizeOutOfRange = 8
    WGPUBufferMapAsyncStatus_Force32 = 2147483647
end

@cenum WGPUBufferMapState::UInt32 begin
    WGPUBufferMapState_Unmapped = 0
    WGPUBufferMapState_Pending = 1
    WGPUBufferMapState_Mapped = 2
    WGPUBufferMapState_Force32 = 2147483647
end

@cenum WGPUCompareFunction::UInt32 begin
    WGPUCompareFunction_Undefined = 0
    WGPUCompareFunction_Never = 1
    WGPUCompareFunction_Less = 2
    WGPUCompareFunction_LessEqual = 3
    WGPUCompareFunction_Greater = 4
    WGPUCompareFunction_GreaterEqual = 5
    WGPUCompareFunction_Equal = 6
    WGPUCompareFunction_NotEqual = 7
    WGPUCompareFunction_Always = 8
    WGPUCompareFunction_Force32 = 2147483647
end

@cenum WGPUCompilationInfoRequestStatus::UInt32 begin
    WGPUCompilationInfoRequestStatus_Success = 0
    WGPUCompilationInfoRequestStatus_Error = 1
    WGPUCompilationInfoRequestStatus_DeviceLost = 2
    WGPUCompilationInfoRequestStatus_Unknown = 3
    WGPUCompilationInfoRequestStatus_Force32 = 2147483647
end

@cenum WGPUCompilationMessageType::UInt32 begin
    WGPUCompilationMessageType_Error = 0
    WGPUCompilationMessageType_Warning = 1
    WGPUCompilationMessageType_Info = 2
    WGPUCompilationMessageType_Force32 = 2147483647
end

@cenum WGPUComputePassTimestampLocation::UInt32 begin
    WGPUComputePassTimestampLocation_Beginning = 0
    WGPUComputePassTimestampLocation_End = 1
    WGPUComputePassTimestampLocation_Force32 = 2147483647
end

@cenum WGPUCreatePipelineAsyncStatus::UInt32 begin
    WGPUCreatePipelineAsyncStatus_Success = 0
    WGPUCreatePipelineAsyncStatus_ValidationError = 1
    WGPUCreatePipelineAsyncStatus_InternalError = 2
    WGPUCreatePipelineAsyncStatus_DeviceLost = 3
    WGPUCreatePipelineAsyncStatus_DeviceDestroyed = 4
    WGPUCreatePipelineAsyncStatus_Unknown = 5
    WGPUCreatePipelineAsyncStatus_Force32 = 2147483647
end

@cenum WGPUCullMode::UInt32 begin
    WGPUCullMode_None = 0
    WGPUCullMode_Front = 1
    WGPUCullMode_Back = 2
    WGPUCullMode_Force32 = 2147483647
end

@cenum WGPUDeviceLostReason::UInt32 begin
    WGPUDeviceLostReason_Undefined = 0
    WGPUDeviceLostReason_Destroyed = 1
    WGPUDeviceLostReason_Force32 = 2147483647
end

@cenum WGPUErrorFilter::UInt32 begin
    WGPUErrorFilter_Validation = 0
    WGPUErrorFilter_OutOfMemory = 1
    WGPUErrorFilter_Internal = 2
    WGPUErrorFilter_Force32 = 2147483647
end

@cenum WGPUErrorType::UInt32 begin
    WGPUErrorType_NoError = 0
    WGPUErrorType_Validation = 1
    WGPUErrorType_OutOfMemory = 2
    WGPUErrorType_Internal = 3
    WGPUErrorType_Unknown = 4
    WGPUErrorType_DeviceLost = 5
    WGPUErrorType_Force32 = 2147483647
end

@cenum WGPUFeatureName::UInt32 begin
    WGPUFeatureName_Undefined = 0
    WGPUFeatureName_DepthClipControl = 1
    WGPUFeatureName_Depth32FloatStencil8 = 2
    WGPUFeatureName_TimestampQuery = 3
    WGPUFeatureName_PipelineStatisticsQuery = 4
    WGPUFeatureName_TextureCompressionBC = 5
    WGPUFeatureName_TextureCompressionETC2 = 6
    WGPUFeatureName_TextureCompressionASTC = 7
    WGPUFeatureName_IndirectFirstInstance = 8
    WGPUFeatureName_ShaderF16 = 9
    WGPUFeatureName_RG11B10UfloatRenderable = 10
    WGPUFeatureName_BGRA8UnormStorage = 11
    WGPUFeatureName_Float32Filterable = 12
    WGPUFeatureName_Force32 = 2147483647
end

@cenum WGPUFilterMode::UInt32 begin
    WGPUFilterMode_Nearest = 0
    WGPUFilterMode_Linear = 1
    WGPUFilterMode_Force32 = 2147483647
end

@cenum WGPUFrontFace::UInt32 begin
    WGPUFrontFace_CCW = 0
    WGPUFrontFace_CW = 1
    WGPUFrontFace_Force32 = 2147483647
end

@cenum WGPUIndexFormat::UInt32 begin
    WGPUIndexFormat_Undefined = 0
    WGPUIndexFormat_Uint16 = 1
    WGPUIndexFormat_Uint32 = 2
    WGPUIndexFormat_Force32 = 2147483647
end

@cenum WGPULoadOp::UInt32 begin
    WGPULoadOp_Undefined = 0
    WGPULoadOp_Clear = 1
    WGPULoadOp_Load = 2
    WGPULoadOp_Force32 = 2147483647
end

@cenum WGPUMipmapFilterMode::UInt32 begin
    WGPUMipmapFilterMode_Nearest = 0
    WGPUMipmapFilterMode_Linear = 1
    WGPUMipmapFilterMode_Force32 = 2147483647
end

@cenum WGPUPipelineStatisticName::UInt32 begin
    WGPUPipelineStatisticName_VertexShaderInvocations = 0
    WGPUPipelineStatisticName_ClipperInvocations = 1
    WGPUPipelineStatisticName_ClipperPrimitivesOut = 2
    WGPUPipelineStatisticName_FragmentShaderInvocations = 3
    WGPUPipelineStatisticName_ComputeShaderInvocations = 4
    WGPUPipelineStatisticName_Force32 = 2147483647
end

@cenum WGPUPowerPreference::UInt32 begin
    WGPUPowerPreference_Undefined = 0
    WGPUPowerPreference_LowPower = 1
    WGPUPowerPreference_HighPerformance = 2
    WGPUPowerPreference_Force32 = 2147483647
end

@cenum WGPUPresentMode::UInt32 begin
    WGPUPresentMode_Immediate = 0
    WGPUPresentMode_Mailbox = 1
    WGPUPresentMode_Fifo = 2
    WGPUPresentMode_Force32 = 2147483647
end

@cenum WGPUPrimitiveTopology::UInt32 begin
    WGPUPrimitiveTopology_PointList = 0
    WGPUPrimitiveTopology_LineList = 1
    WGPUPrimitiveTopology_LineStrip = 2
    WGPUPrimitiveTopology_TriangleList = 3
    WGPUPrimitiveTopology_TriangleStrip = 4
    WGPUPrimitiveTopology_Force32 = 2147483647
end

@cenum WGPUQueryType::UInt32 begin
    WGPUQueryType_Occlusion = 0
    WGPUQueryType_PipelineStatistics = 1
    WGPUQueryType_Timestamp = 2
    WGPUQueryType_Force32 = 2147483647
end

@cenum WGPUQueueWorkDoneStatus::UInt32 begin
    WGPUQueueWorkDoneStatus_Success = 0
    WGPUQueueWorkDoneStatus_Error = 1
    WGPUQueueWorkDoneStatus_Unknown = 2
    WGPUQueueWorkDoneStatus_DeviceLost = 3
    WGPUQueueWorkDoneStatus_Force32 = 2147483647
end

@cenum WGPURenderPassTimestampLocation::UInt32 begin
    WGPURenderPassTimestampLocation_Beginning = 0
    WGPURenderPassTimestampLocation_End = 1
    WGPURenderPassTimestampLocation_Force32 = 2147483647
end

@cenum WGPURequestAdapterStatus::UInt32 begin
    WGPURequestAdapterStatus_Success = 0
    WGPURequestAdapterStatus_Unavailable = 1
    WGPURequestAdapterStatus_Error = 2
    WGPURequestAdapterStatus_Unknown = 3
    WGPURequestAdapterStatus_Force32 = 2147483647
end

@cenum WGPURequestDeviceStatus::UInt32 begin
    WGPURequestDeviceStatus_Success = 0
    WGPURequestDeviceStatus_Error = 1
    WGPURequestDeviceStatus_Unknown = 2
    WGPURequestDeviceStatus_Force32 = 2147483647
end

@cenum WGPUSType::UInt32 begin
    WGPUSType_Invalid = 0
    WGPUSType_SurfaceDescriptorFromMetalLayer = 1
    WGPUSType_SurfaceDescriptorFromWindowsHWND = 2
    WGPUSType_SurfaceDescriptorFromXlibWindow = 3
    WGPUSType_SurfaceDescriptorFromCanvasHTMLSelector = 4
    WGPUSType_ShaderModuleSPIRVDescriptor = 5
    WGPUSType_ShaderModuleWGSLDescriptor = 6
    WGPUSType_PrimitiveDepthClipControl = 7
    WGPUSType_SurfaceDescriptorFromWaylandSurface = 8
    WGPUSType_SurfaceDescriptorFromAndroidNativeWindow = 9
    WGPUSType_SurfaceDescriptorFromXcbWindow = 10
    WGPUSType_RenderPassDescriptorMaxDrawCount = 15
    WGPUSType_Force32 = 2147483647
end

@cenum WGPUSamplerBindingType::UInt32 begin
    WGPUSamplerBindingType_Undefined = 0
    WGPUSamplerBindingType_Filtering = 1
    WGPUSamplerBindingType_NonFiltering = 2
    WGPUSamplerBindingType_Comparison = 3
    WGPUSamplerBindingType_Force32 = 2147483647
end

@cenum WGPUStencilOperation::UInt32 begin
    WGPUStencilOperation_Keep = 0
    WGPUStencilOperation_Zero = 1
    WGPUStencilOperation_Replace = 2
    WGPUStencilOperation_Invert = 3
    WGPUStencilOperation_IncrementClamp = 4
    WGPUStencilOperation_DecrementClamp = 5
    WGPUStencilOperation_IncrementWrap = 6
    WGPUStencilOperation_DecrementWrap = 7
    WGPUStencilOperation_Force32 = 2147483647
end

@cenum WGPUStorageTextureAccess::UInt32 begin
    WGPUStorageTextureAccess_Undefined = 0
    WGPUStorageTextureAccess_WriteOnly = 1
    WGPUStorageTextureAccess_Force32 = 2147483647
end

@cenum WGPUStoreOp::UInt32 begin
    WGPUStoreOp_Undefined = 0
    WGPUStoreOp_Store = 1
    WGPUStoreOp_Discard = 2
    WGPUStoreOp_Force32 = 2147483647
end

@cenum WGPUTextureAspect::UInt32 begin
    WGPUTextureAspect_All = 0
    WGPUTextureAspect_StencilOnly = 1
    WGPUTextureAspect_DepthOnly = 2
    WGPUTextureAspect_Force32 = 2147483647
end

@cenum WGPUTextureDimension::UInt32 begin
    WGPUTextureDimension_1D = 0
    WGPUTextureDimension_2D = 1
    WGPUTextureDimension_3D = 2
    WGPUTextureDimension_Force32 = 2147483647
end

@cenum WGPUTextureFormat::UInt32 begin
    WGPUTextureFormat_Undefined = 0
    WGPUTextureFormat_R8Unorm = 1
    WGPUTextureFormat_R8Snorm = 2
    WGPUTextureFormat_R8Uint = 3
    WGPUTextureFormat_R8Sint = 4
    WGPUTextureFormat_R16Uint = 5
    WGPUTextureFormat_R16Sint = 6
    WGPUTextureFormat_R16Float = 7
    WGPUTextureFormat_RG8Unorm = 8
    WGPUTextureFormat_RG8Snorm = 9
    WGPUTextureFormat_RG8Uint = 10
    WGPUTextureFormat_RG8Sint = 11
    WGPUTextureFormat_R32Float = 12
    WGPUTextureFormat_R32Uint = 13
    WGPUTextureFormat_R32Sint = 14
    WGPUTextureFormat_RG16Uint = 15
    WGPUTextureFormat_RG16Sint = 16
    WGPUTextureFormat_RG16Float = 17
    WGPUTextureFormat_RGBA8Unorm = 18
    WGPUTextureFormat_RGBA8UnormSrgb = 19
    WGPUTextureFormat_RGBA8Snorm = 20
    WGPUTextureFormat_RGBA8Uint = 21
    WGPUTextureFormat_RGBA8Sint = 22
    WGPUTextureFormat_BGRA8Unorm = 23
    WGPUTextureFormat_BGRA8UnormSrgb = 24
    WGPUTextureFormat_RGB10A2Unorm = 25
    WGPUTextureFormat_RG11B10Ufloat = 26
    WGPUTextureFormat_RGB9E5Ufloat = 27
    WGPUTextureFormat_RG32Float = 28
    WGPUTextureFormat_RG32Uint = 29
    WGPUTextureFormat_RG32Sint = 30
    WGPUTextureFormat_RGBA16Uint = 31
    WGPUTextureFormat_RGBA16Sint = 32
    WGPUTextureFormat_RGBA16Float = 33
    WGPUTextureFormat_RGBA32Float = 34
    WGPUTextureFormat_RGBA32Uint = 35
    WGPUTextureFormat_RGBA32Sint = 36
    WGPUTextureFormat_Stencil8 = 37
    WGPUTextureFormat_Depth16Unorm = 38
    WGPUTextureFormat_Depth24Plus = 39
    WGPUTextureFormat_Depth24PlusStencil8 = 40
    WGPUTextureFormat_Depth32Float = 41
    WGPUTextureFormat_Depth32FloatStencil8 = 42
    WGPUTextureFormat_BC1RGBAUnorm = 43
    WGPUTextureFormat_BC1RGBAUnormSrgb = 44
    WGPUTextureFormat_BC2RGBAUnorm = 45
    WGPUTextureFormat_BC2RGBAUnormSrgb = 46
    WGPUTextureFormat_BC3RGBAUnorm = 47
    WGPUTextureFormat_BC3RGBAUnormSrgb = 48
    WGPUTextureFormat_BC4RUnorm = 49
    WGPUTextureFormat_BC4RSnorm = 50
    WGPUTextureFormat_BC5RGUnorm = 51
    WGPUTextureFormat_BC5RGSnorm = 52
    WGPUTextureFormat_BC6HRGBUfloat = 53
    WGPUTextureFormat_BC6HRGBFloat = 54
    WGPUTextureFormat_BC7RGBAUnorm = 55
    WGPUTextureFormat_BC7RGBAUnormSrgb = 56
    WGPUTextureFormat_ETC2RGB8Unorm = 57
    WGPUTextureFormat_ETC2RGB8UnormSrgb = 58
    WGPUTextureFormat_ETC2RGB8A1Unorm = 59
    WGPUTextureFormat_ETC2RGB8A1UnormSrgb = 60
    WGPUTextureFormat_ETC2RGBA8Unorm = 61
    WGPUTextureFormat_ETC2RGBA8UnormSrgb = 62
    WGPUTextureFormat_EACR11Unorm = 63
    WGPUTextureFormat_EACR11Snorm = 64
    WGPUTextureFormat_EACRG11Unorm = 65
    WGPUTextureFormat_EACRG11Snorm = 66
    WGPUTextureFormat_ASTC4x4Unorm = 67
    WGPUTextureFormat_ASTC4x4UnormSrgb = 68
    WGPUTextureFormat_ASTC5x4Unorm = 69
    WGPUTextureFormat_ASTC5x4UnormSrgb = 70
    WGPUTextureFormat_ASTC5x5Unorm = 71
    WGPUTextureFormat_ASTC5x5UnormSrgb = 72
    WGPUTextureFormat_ASTC6x5Unorm = 73
    WGPUTextureFormat_ASTC6x5UnormSrgb = 74
    WGPUTextureFormat_ASTC6x6Unorm = 75
    WGPUTextureFormat_ASTC6x6UnormSrgb = 76
    WGPUTextureFormat_ASTC8x5Unorm = 77
    WGPUTextureFormat_ASTC8x5UnormSrgb = 78
    WGPUTextureFormat_ASTC8x6Unorm = 79
    WGPUTextureFormat_ASTC8x6UnormSrgb = 80
    WGPUTextureFormat_ASTC8x8Unorm = 81
    WGPUTextureFormat_ASTC8x8UnormSrgb = 82
    WGPUTextureFormat_ASTC10x5Unorm = 83
    WGPUTextureFormat_ASTC10x5UnormSrgb = 84
    WGPUTextureFormat_ASTC10x6Unorm = 85
    WGPUTextureFormat_ASTC10x6UnormSrgb = 86
    WGPUTextureFormat_ASTC10x8Unorm = 87
    WGPUTextureFormat_ASTC10x8UnormSrgb = 88
    WGPUTextureFormat_ASTC10x10Unorm = 89
    WGPUTextureFormat_ASTC10x10UnormSrgb = 90
    WGPUTextureFormat_ASTC12x10Unorm = 91
    WGPUTextureFormat_ASTC12x10UnormSrgb = 92
    WGPUTextureFormat_ASTC12x12Unorm = 93
    WGPUTextureFormat_ASTC12x12UnormSrgb = 94
    WGPUTextureFormat_Force32 = 2147483647
end

@cenum WGPUTextureSampleType::UInt32 begin
    WGPUTextureSampleType_Undefined = 0
    WGPUTextureSampleType_Float = 1
    WGPUTextureSampleType_UnfilterableFloat = 2
    WGPUTextureSampleType_Depth = 3
    WGPUTextureSampleType_Sint = 4
    WGPUTextureSampleType_Uint = 5
    WGPUTextureSampleType_Force32 = 2147483647
end

@cenum WGPUTextureViewDimension::UInt32 begin
    WGPUTextureViewDimension_Undefined = 0
    WGPUTextureViewDimension_1D = 1
    WGPUTextureViewDimension_2D = 2
    WGPUTextureViewDimension_2DArray = 3
    WGPUTextureViewDimension_Cube = 4
    WGPUTextureViewDimension_CubeArray = 5
    WGPUTextureViewDimension_3D = 6
    WGPUTextureViewDimension_Force32 = 2147483647
end

@cenum WGPUVertexFormat::UInt32 begin
    WGPUVertexFormat_Undefined = 0
    WGPUVertexFormat_Uint8x2 = 1
    WGPUVertexFormat_Uint8x4 = 2
    WGPUVertexFormat_Sint8x2 = 3
    WGPUVertexFormat_Sint8x4 = 4
    WGPUVertexFormat_Unorm8x2 = 5
    WGPUVertexFormat_Unorm8x4 = 6
    WGPUVertexFormat_Snorm8x2 = 7
    WGPUVertexFormat_Snorm8x4 = 8
    WGPUVertexFormat_Uint16x2 = 9
    WGPUVertexFormat_Uint16x4 = 10
    WGPUVertexFormat_Sint16x2 = 11
    WGPUVertexFormat_Sint16x4 = 12
    WGPUVertexFormat_Unorm16x2 = 13
    WGPUVertexFormat_Unorm16x4 = 14
    WGPUVertexFormat_Snorm16x2 = 15
    WGPUVertexFormat_Snorm16x4 = 16
    WGPUVertexFormat_Float16x2 = 17
    WGPUVertexFormat_Float16x4 = 18
    WGPUVertexFormat_Float32 = 19
    WGPUVertexFormat_Float32x2 = 20
    WGPUVertexFormat_Float32x3 = 21
    WGPUVertexFormat_Float32x4 = 22
    WGPUVertexFormat_Uint32 = 23
    WGPUVertexFormat_Uint32x2 = 24
    WGPUVertexFormat_Uint32x3 = 25
    WGPUVertexFormat_Uint32x4 = 26
    WGPUVertexFormat_Sint32 = 27
    WGPUVertexFormat_Sint32x2 = 28
    WGPUVertexFormat_Sint32x3 = 29
    WGPUVertexFormat_Sint32x4 = 30
    WGPUVertexFormat_Force32 = 2147483647
end

@cenum WGPUVertexStepMode::UInt32 begin
    WGPUVertexStepMode_Vertex = 0
    WGPUVertexStepMode_Instance = 1
    WGPUVertexStepMode_VertexBufferNotUsed = 2
    WGPUVertexStepMode_Force32 = 2147483647
end

@cenum WGPUBufferUsage::UInt32 begin
    WGPUBufferUsage_None = 0
    WGPUBufferUsage_MapRead = 1
    WGPUBufferUsage_MapWrite = 2
    WGPUBufferUsage_CopySrc = 4
    WGPUBufferUsage_CopyDst = 8
    WGPUBufferUsage_Index = 16
    WGPUBufferUsage_Vertex = 32
    WGPUBufferUsage_Uniform = 64
    WGPUBufferUsage_Storage = 128
    WGPUBufferUsage_Indirect = 256
    WGPUBufferUsage_QueryResolve = 512
    WGPUBufferUsage_Force32 = 2147483647
end

const WGPUBufferUsageFlags = WGPUFlags

@cenum WGPUColorWriteMask::UInt32 begin
    WGPUColorWriteMask_None = 0
    WGPUColorWriteMask_Red = 1
    WGPUColorWriteMask_Green = 2
    WGPUColorWriteMask_Blue = 4
    WGPUColorWriteMask_Alpha = 8
    WGPUColorWriteMask_All = 15
    WGPUColorWriteMask_Force32 = 2147483647
end

const WGPUColorWriteMaskFlags = WGPUFlags

@cenum WGPUMapMode::UInt32 begin
    WGPUMapMode_None = 0
    WGPUMapMode_Read = 1
    WGPUMapMode_Write = 2
    WGPUMapMode_Force32 = 2147483647
end

const WGPUMapModeFlags = WGPUFlags

@cenum WGPUShaderStage::UInt32 begin
    WGPUShaderStage_None = 0
    WGPUShaderStage_Vertex = 1
    WGPUShaderStage_Fragment = 2
    WGPUShaderStage_Compute = 4
    WGPUShaderStage_Force32 = 2147483647
end

const WGPUShaderStageFlags = WGPUFlags

@cenum WGPUTextureUsage::UInt32 begin
    WGPUTextureUsage_None = 0
    WGPUTextureUsage_CopySrc = 1
    WGPUTextureUsage_CopyDst = 2
    WGPUTextureUsage_TextureBinding = 4
    WGPUTextureUsage_StorageBinding = 8
    WGPUTextureUsage_RenderAttachment = 16
    WGPUTextureUsage_Force32 = 2147483647
end

const WGPUTextureUsageFlags = WGPUFlags

# typedef void ( * WGPUBufferMapCallback ) ( WGPUBufferMapAsyncStatus status , void * userdata )
const WGPUBufferMapCallback = Ptr{Cvoid}

# typedef void ( * WGPUCompilationInfoCallback ) ( WGPUCompilationInfoRequestStatus status , struct WGPUCompilationInfo const * compilationInfo , void * userdata )
const WGPUCompilationInfoCallback = Ptr{Cvoid}

# typedef void ( * WGPUCreateComputePipelineAsyncCallback ) ( WGPUCreatePipelineAsyncStatus status , WGPUComputePipeline pipeline , char const * message , void * userdata )
const WGPUCreateComputePipelineAsyncCallback = Ptr{Cvoid}

# typedef void ( * WGPUCreateRenderPipelineAsyncCallback ) ( WGPUCreatePipelineAsyncStatus status , WGPURenderPipeline pipeline , char const * message , void * userdata )
const WGPUCreateRenderPipelineAsyncCallback = Ptr{Cvoid}

# typedef void ( * WGPUDeviceLostCallback ) ( WGPUDeviceLostReason reason , char const * message , void * userdata )
const WGPUDeviceLostCallback = Ptr{Cvoid}

# typedef void ( * WGPUErrorCallback ) ( WGPUErrorType type , char const * message , void * userdata )
const WGPUErrorCallback = Ptr{Cvoid}

# typedef void ( * WGPUProc ) ( void )
const WGPUProc = Ptr{Cvoid}

# typedef void ( * WGPUQueueWorkDoneCallback ) ( WGPUQueueWorkDoneStatus status , void * userdata )
const WGPUQueueWorkDoneCallback = Ptr{Cvoid}

# typedef void ( * WGPURequestAdapterCallback ) ( WGPURequestAdapterStatus status , WGPUAdapter adapter , char const * message , void * userdata )
const WGPURequestAdapterCallback = Ptr{Cvoid}

# typedef void ( * WGPURequestDeviceCallback ) ( WGPURequestDeviceStatus status , WGPUDevice device , char const * message , void * userdata )
const WGPURequestDeviceCallback = Ptr{Cvoid}

struct WGPUChainedStruct
    next::Ptr{WGPUChainedStruct}
    sType::WGPUSType
end

struct WGPUChainedStructOut
    next::Ptr{WGPUChainedStructOut}
    sType::WGPUSType
end

struct WGPUAdapterProperties
    nextInChain::Ptr{WGPUChainedStructOut}
    vendorID::UInt32
    vendorName::Ptr{Cchar}
    architecture::Ptr{Cchar}
    deviceID::UInt32
    name::Ptr{Cchar}
    driverDescription::Ptr{Cchar}
    adapterType::WGPUAdapterType
    backendType::WGPUBackendType
end

struct WGPUBindGroupEntry
    nextInChain::Ptr{WGPUChainedStruct}
    binding::UInt32
    buffer::WGPUBuffer
    offset::UInt64
    size::UInt64
    sampler::WGPUSampler
    textureView::WGPUTextureView
end

struct WGPUBlendComponent
    operation::WGPUBlendOperation
    srcFactor::WGPUBlendFactor
    dstFactor::WGPUBlendFactor
end

struct WGPUBufferBindingLayout
    nextInChain::Ptr{WGPUChainedStruct}
    type::WGPUBufferBindingType
    hasDynamicOffset::Bool
    minBindingSize::UInt64
end

struct WGPUBufferDescriptor
    nextInChain::Ptr{WGPUChainedStruct}
    label::Ptr{Cchar}
    usage::WGPUBufferUsageFlags
    size::UInt64
    mappedAtCreation::Bool
end

struct WGPUColor
    r::Cdouble
    g::Cdouble
    b::Cdouble
    a::Cdouble
end

struct WGPUCommandBufferDescriptor
    nextInChain::Ptr{WGPUChainedStruct}
    label::Ptr{Cchar}
end

struct WGPUCommandEncoderDescriptor
    nextInChain::Ptr{WGPUChainedStruct}
    label::Ptr{Cchar}
end

struct WGPUCompilationMessage
    nextInChain::Ptr{WGPUChainedStruct}
    message::Ptr{Cchar}
    type::WGPUCompilationMessageType
    lineNum::UInt64
    linePos::UInt64
    offset::UInt64
    length::UInt64
    utf16LinePos::UInt64
    utf16Offset::UInt64
    utf16Length::UInt64
end

struct WGPUComputePassTimestampWrite
    querySet::WGPUQuerySet
    queryIndex::UInt32
    location::WGPUComputePassTimestampLocation
end

struct WGPUConstantEntry
    nextInChain::Ptr{WGPUChainedStruct}
    key::Ptr{Cchar}
    value::Cdouble
end

struct WGPUExtent3D
    width::UInt32
    height::UInt32
    depthOrArrayLayers::UInt32
end

struct WGPUInstanceDescriptor
    nextInChain::Ptr{WGPUChainedStruct}
end

struct WGPULimits
    maxTextureDimension1D::UInt32
    maxTextureDimension2D::UInt32
    maxTextureDimension3D::UInt32
    maxTextureArrayLayers::UInt32
    maxBindGroups::UInt32
    maxBindingsPerBindGroup::UInt32
    maxDynamicUniformBuffersPerPipelineLayout::UInt32
    maxDynamicStorageBuffersPerPipelineLayout::UInt32
    maxSampledTexturesPerShaderStage::UInt32
    maxSamplersPerShaderStage::UInt32
    maxStorageBuffersPerShaderStage::UInt32
    maxStorageTexturesPerShaderStage::UInt32
    maxUniformBuffersPerShaderStage::UInt32
    maxUniformBufferBindingSize::UInt64
    maxStorageBufferBindingSize::UInt64
    minUniformBufferOffsetAlignment::UInt32
    minStorageBufferOffsetAlignment::UInt32
    maxVertexBuffers::UInt32
    maxBufferSize::UInt64
    maxVertexAttributes::UInt32
    maxVertexBufferArrayStride::UInt32
    maxInterStageShaderComponents::UInt32
    maxInterStageShaderVariables::UInt32
    maxColorAttachments::UInt32
    maxColorAttachmentBytesPerSample::UInt32
    maxComputeWorkgroupStorageSize::UInt32
    maxComputeInvocationsPerWorkgroup::UInt32
    maxComputeWorkgroupSizeX::UInt32
    maxComputeWorkgroupSizeY::UInt32
    maxComputeWorkgroupSizeZ::UInt32
    maxComputeWorkgroupsPerDimension::UInt32
end

struct WGPUMultisampleState
    nextInChain::Ptr{WGPUChainedStruct}
    count::UInt32
    mask::UInt32
    alphaToCoverageEnabled::Bool
end

struct WGPUOrigin3D
    x::UInt32
    y::UInt32
    z::UInt32
end

struct WGPUPipelineLayoutDescriptor
    nextInChain::Ptr{WGPUChainedStruct}
    label::Ptr{Cchar}
    bindGroupLayoutCount::Csize_t
    bindGroupLayouts::Ptr{WGPUBindGroupLayout}
end

struct WGPUPrimitiveDepthClipControl
    chain::WGPUChainedStruct
    unclippedDepth::Bool
end

struct WGPUPrimitiveState
    nextInChain::Ptr{WGPUChainedStruct}
    topology::WGPUPrimitiveTopology
    stripIndexFormat::WGPUIndexFormat
    frontFace::WGPUFrontFace
    cullMode::WGPUCullMode
end

struct WGPUQuerySetDescriptor
    nextInChain::Ptr{WGPUChainedStruct}
    label::Ptr{Cchar}
    type::WGPUQueryType
    count::UInt32
    pipelineStatistics::Ptr{WGPUPipelineStatisticName}
    pipelineStatisticsCount::Csize_t
end

struct WGPUQueueDescriptor
    nextInChain::Ptr{WGPUChainedStruct}
    label::Ptr{Cchar}
end

struct WGPURenderBundleDescriptor
    nextInChain::Ptr{WGPUChainedStruct}
    label::Ptr{Cchar}
end

struct WGPURenderBundleEncoderDescriptor
    nextInChain::Ptr{WGPUChainedStruct}
    label::Ptr{Cchar}
    colorFormatsCount::Csize_t
    colorFormats::Ptr{WGPUTextureFormat}
    depthStencilFormat::WGPUTextureFormat
    sampleCount::UInt32
    depthReadOnly::Bool
    stencilReadOnly::Bool
end

struct WGPURenderPassDepthStencilAttachment
    view::WGPUTextureView
    depthLoadOp::WGPULoadOp
    depthStoreOp::WGPUStoreOp
    depthClearValue::Cfloat
    depthReadOnly::Bool
    stencilLoadOp::WGPULoadOp
    stencilStoreOp::WGPUStoreOp
    stencilClearValue::UInt32
    stencilReadOnly::Bool
end

struct WGPURenderPassDescriptorMaxDrawCount
    chain::WGPUChainedStruct
    maxDrawCount::UInt64
end

struct WGPURenderPassTimestampWrite
    querySet::WGPUQuerySet
    queryIndex::UInt32
    location::WGPURenderPassTimestampLocation
end

struct WGPURequestAdapterOptions
    nextInChain::Ptr{WGPUChainedStruct}
    compatibleSurface::WGPUSurface
    powerPreference::WGPUPowerPreference
    backendType::WGPUBackendType
    forceFallbackAdapter::Bool
end

struct WGPUSamplerBindingLayout
    nextInChain::Ptr{WGPUChainedStruct}
    type::WGPUSamplerBindingType
end

struct WGPUSamplerDescriptor
    nextInChain::Ptr{WGPUChainedStruct}
    label::Ptr{Cchar}
    addressModeU::WGPUAddressMode
    addressModeV::WGPUAddressMode
    addressModeW::WGPUAddressMode
    magFilter::WGPUFilterMode
    minFilter::WGPUFilterMode
    mipmapFilter::WGPUMipmapFilterMode
    lodMinClamp::Cfloat
    lodMaxClamp::Cfloat
    compare::WGPUCompareFunction
    maxAnisotropy::UInt16
end

struct WGPUShaderModuleCompilationHint
    nextInChain::Ptr{WGPUChainedStruct}
    entryPoint::Ptr{Cchar}
    layout::WGPUPipelineLayout
end

struct WGPUShaderModuleSPIRVDescriptor
    chain::WGPUChainedStruct
    codeSize::UInt32
    code::Ptr{UInt32}
end

struct WGPUShaderModuleWGSLDescriptor
    chain::WGPUChainedStruct
    code::Ptr{Cchar}
end

struct WGPUStencilFaceState
    compare::WGPUCompareFunction
    failOp::WGPUStencilOperation
    depthFailOp::WGPUStencilOperation
    passOp::WGPUStencilOperation
end

struct WGPUStorageTextureBindingLayout
    nextInChain::Ptr{WGPUChainedStruct}
    access::WGPUStorageTextureAccess
    format::WGPUTextureFormat
    viewDimension::WGPUTextureViewDimension
end

struct WGPUSurfaceDescriptor
    nextInChain::Ptr{WGPUChainedStruct}
    label::Ptr{Cchar}
end

struct WGPUSurfaceDescriptorFromAndroidNativeWindow
    chain::WGPUChainedStruct
    window::Ptr{Cvoid}
end

struct WGPUSurfaceDescriptorFromCanvasHTMLSelector
    chain::WGPUChainedStruct
    selector::Ptr{Cchar}
end

struct WGPUSurfaceDescriptorFromMetalLayer
    chain::WGPUChainedStruct
    layer::Ptr{Cvoid}
end

struct WGPUSurfaceDescriptorFromWaylandSurface
    chain::WGPUChainedStruct
    display::Ptr{Cvoid}
    surface::Ptr{Cvoid}
end

struct WGPUSurfaceDescriptorFromWindowsHWND
    chain::WGPUChainedStruct
    hinstance::Ptr{Cvoid}
    hwnd::Ptr{Cvoid}
end

struct WGPUSurfaceDescriptorFromXcbWindow
    chain::WGPUChainedStruct
    connection::Ptr{Cvoid}
    window::UInt32
end

struct WGPUSurfaceDescriptorFromXlibWindow
    chain::WGPUChainedStruct
    display::Ptr{Cvoid}
    window::UInt32
end

struct WGPUSwapChainDescriptor
    nextInChain::Ptr{WGPUChainedStruct}
    label::Ptr{Cchar}
    usage::WGPUTextureUsageFlags
    format::WGPUTextureFormat
    width::UInt32
    height::UInt32
    presentMode::WGPUPresentMode
end

struct WGPUTextureBindingLayout
    nextInChain::Ptr{WGPUChainedStruct}
    sampleType::WGPUTextureSampleType
    viewDimension::WGPUTextureViewDimension
    multisampled::Bool
end

struct WGPUTextureDataLayout
    nextInChain::Ptr{WGPUChainedStruct}
    offset::UInt64
    bytesPerRow::UInt32
    rowsPerImage::UInt32
end

struct WGPUTextureViewDescriptor
    nextInChain::Ptr{WGPUChainedStruct}
    label::Ptr{Cchar}
    format::WGPUTextureFormat
    dimension::WGPUTextureViewDimension
    baseMipLevel::UInt32
    mipLevelCount::UInt32
    baseArrayLayer::UInt32
    arrayLayerCount::UInt32
    aspect::WGPUTextureAspect
end

struct WGPUVertexAttribute
    format::WGPUVertexFormat
    offset::UInt64
    shaderLocation::UInt32
end

struct WGPUBindGroupDescriptor
    nextInChain::Ptr{WGPUChainedStruct}
    label::Ptr{Cchar}
    layout::WGPUBindGroupLayout
    entryCount::Csize_t
    entries::Ptr{WGPUBindGroupEntry}
end

struct WGPUBindGroupLayoutEntry
    nextInChain::Ptr{WGPUChainedStruct}
    binding::UInt32
    visibility::WGPUShaderStageFlags
    buffer::WGPUBufferBindingLayout
    sampler::WGPUSamplerBindingLayout
    texture::WGPUTextureBindingLayout
    storageTexture::WGPUStorageTextureBindingLayout
end

struct WGPUBlendState
    color::WGPUBlendComponent
    alpha::WGPUBlendComponent
end

struct WGPUCompilationInfo
    nextInChain::Ptr{WGPUChainedStruct}
    messageCount::Csize_t
    messages::Ptr{WGPUCompilationMessage}
end

struct WGPUComputePassDescriptor
    nextInChain::Ptr{WGPUChainedStruct}
    label::Ptr{Cchar}
    timestampWriteCount::Csize_t
    timestampWrites::Ptr{WGPUComputePassTimestampWrite}
end

struct WGPUDepthStencilState
    nextInChain::Ptr{WGPUChainedStruct}
    format::WGPUTextureFormat
    depthWriteEnabled::Bool
    depthCompare::WGPUCompareFunction
    stencilFront::WGPUStencilFaceState
    stencilBack::WGPUStencilFaceState
    stencilReadMask::UInt32
    stencilWriteMask::UInt32
    depthBias::Int32
    depthBiasSlopeScale::Cfloat
    depthBiasClamp::Cfloat
end

struct WGPUImageCopyBuffer
    nextInChain::Ptr{WGPUChainedStruct}
    layout::WGPUTextureDataLayout
    buffer::WGPUBuffer
end

struct WGPUImageCopyTexture
    nextInChain::Ptr{WGPUChainedStruct}
    texture::WGPUTexture
    mipLevel::UInt32
    origin::WGPUOrigin3D
    aspect::WGPUTextureAspect
end

struct WGPUProgrammableStageDescriptor
    nextInChain::Ptr{WGPUChainedStruct}
    _module::WGPUShaderModule
    entryPoint::Ptr{Cchar}
    constantCount::Csize_t
    constants::Ptr{WGPUConstantEntry}
end

struct WGPURenderPassColorAttachment
    view::WGPUTextureView
    resolveTarget::WGPUTextureView
    loadOp::WGPULoadOp
    storeOp::WGPUStoreOp
    clearValue::WGPUColor
end

struct WGPURequiredLimits
    nextInChain::Ptr{WGPUChainedStruct}
    limits::WGPULimits
end

struct WGPUShaderModuleDescriptor
    nextInChain::Ptr{WGPUChainedStruct}
    label::Ptr{Cchar}
    hintCount::Csize_t
    hints::Ptr{WGPUShaderModuleCompilationHint}
end

struct WGPUSupportedLimits
    nextInChain::Ptr{WGPUChainedStructOut}
    limits::WGPULimits
end

struct WGPUTextureDescriptor
    nextInChain::Ptr{WGPUChainedStruct}
    label::Ptr{Cchar}
    usage::WGPUTextureUsageFlags
    dimension::WGPUTextureDimension
    size::WGPUExtent3D
    format::WGPUTextureFormat
    mipLevelCount::UInt32
    sampleCount::UInt32
    viewFormatCount::Csize_t
    viewFormats::Ptr{WGPUTextureFormat}
end

struct WGPUVertexBufferLayout
    arrayStride::UInt64
    stepMode::WGPUVertexStepMode
    attributeCount::Csize_t
    attributes::Ptr{WGPUVertexAttribute}
end

struct WGPUBindGroupLayoutDescriptor
    nextInChain::Ptr{WGPUChainedStruct}
    label::Ptr{Cchar}
    entryCount::Csize_t
    entries::Ptr{WGPUBindGroupLayoutEntry}
end

struct WGPUColorTargetState
    nextInChain::Ptr{WGPUChainedStruct}
    format::WGPUTextureFormat
    blend::Ptr{WGPUBlendState}
    writeMask::WGPUColorWriteMaskFlags
end

struct WGPUComputePipelineDescriptor
    nextInChain::Ptr{WGPUChainedStruct}
    label::Ptr{Cchar}
    layout::WGPUPipelineLayout
    compute::WGPUProgrammableStageDescriptor
end

struct WGPUDeviceDescriptor
    nextInChain::Ptr{WGPUChainedStruct}
    label::Ptr{Cchar}
    requiredFeaturesCount::Csize_t
    requiredFeatures::Ptr{WGPUFeatureName}
    requiredLimits::Ptr{WGPURequiredLimits}
    defaultQueue::WGPUQueueDescriptor
    deviceLostCallback::WGPUDeviceLostCallback
    deviceLostUserdata::Ptr{Cvoid}
end

struct WGPURenderPassDescriptor
    nextInChain::Ptr{WGPUChainedStruct}
    label::Ptr{Cchar}
    colorAttachmentCount::Csize_t
    colorAttachments::Ptr{WGPURenderPassColorAttachment}
    depthStencilAttachment::Ptr{WGPURenderPassDepthStencilAttachment}
    occlusionQuerySet::WGPUQuerySet
    timestampWriteCount::Csize_t
    timestampWrites::Ptr{WGPURenderPassTimestampWrite}
end

struct WGPUVertexState
    nextInChain::Ptr{WGPUChainedStruct}
    _module::WGPUShaderModule
    entryPoint::Ptr{Cchar}
    constantCount::Csize_t
    constants::Ptr{WGPUConstantEntry}
    bufferCount::Csize_t
    buffers::Ptr{WGPUVertexBufferLayout}
end

struct WGPUFragmentState
    nextInChain::Ptr{WGPUChainedStruct}
    _module::WGPUShaderModule
    entryPoint::Ptr{Cchar}
    constantCount::Csize_t
    constants::Ptr{WGPUConstantEntry}
    targetCount::Csize_t
    targets::Ptr{WGPUColorTargetState}
end

struct WGPURenderPipelineDescriptor
    nextInChain::Ptr{WGPUChainedStruct}
    label::Ptr{Cchar}
    layout::WGPUPipelineLayout
    vertex::WGPUVertexState
    primitive::WGPUPrimitiveState
    depthStencil::Ptr{WGPUDepthStencilState}
    multisample::WGPUMultisampleState
    fragment::Ptr{WGPUFragmentState}
end

# typedef WGPUInstance ( * WGPUProcCreateInstance ) ( WGPUInstanceDescriptor const * descriptor )
const WGPUProcCreateInstance = Ptr{Cvoid}

# typedef WGPUProc ( * WGPUProcGetProcAddress ) ( WGPUDevice device , char const * procName )
const WGPUProcGetProcAddress = Ptr{Cvoid}

# typedef size_t ( * WGPUProcAdapterEnumerateFeatures ) ( WGPUAdapter adapter , WGPUFeatureName * features )
const WGPUProcAdapterEnumerateFeatures = Ptr{Cvoid}

# typedef bool ( * WGPUProcAdapterGetLimits ) ( WGPUAdapter adapter , WGPUSupportedLimits * limits )
const WGPUProcAdapterGetLimits = Ptr{Cvoid}

# typedef void ( * WGPUProcAdapterGetProperties ) ( WGPUAdapter adapter , WGPUAdapterProperties * properties )
const WGPUProcAdapterGetProperties = Ptr{Cvoid}

# typedef bool ( * WGPUProcAdapterHasFeature ) ( WGPUAdapter adapter , WGPUFeatureName feature )
const WGPUProcAdapterHasFeature = Ptr{Cvoid}

# typedef void ( * WGPUProcAdapterRequestDevice ) ( WGPUAdapter adapter , WGPU_NULLABLE WGPUDeviceDescriptor const * descriptor , WGPURequestDeviceCallback callback , void * userdata )
const WGPUProcAdapterRequestDevice = Ptr{Cvoid}

# typedef void ( * WGPUProcAdapterReference ) ( WGPUAdapter adapter )
const WGPUProcAdapterReference = Ptr{Cvoid}

# typedef void ( * WGPUProcAdapterRelease ) ( WGPUAdapter adapter )
const WGPUProcAdapterRelease = Ptr{Cvoid}

# typedef void ( * WGPUProcBindGroupSetLabel ) ( WGPUBindGroup bindGroup , char const * label )
const WGPUProcBindGroupSetLabel = Ptr{Cvoid}

# typedef void ( * WGPUProcBindGroupReference ) ( WGPUBindGroup bindGroup )
const WGPUProcBindGroupReference = Ptr{Cvoid}

# typedef void ( * WGPUProcBindGroupRelease ) ( WGPUBindGroup bindGroup )
const WGPUProcBindGroupRelease = Ptr{Cvoid}

# typedef void ( * WGPUProcBindGroupLayoutSetLabel ) ( WGPUBindGroupLayout bindGroupLayout , char const * label )
const WGPUProcBindGroupLayoutSetLabel = Ptr{Cvoid}

# typedef void ( * WGPUProcBindGroupLayoutReference ) ( WGPUBindGroupLayout bindGroupLayout )
const WGPUProcBindGroupLayoutReference = Ptr{Cvoid}

# typedef void ( * WGPUProcBindGroupLayoutRelease ) ( WGPUBindGroupLayout bindGroupLayout )
const WGPUProcBindGroupLayoutRelease = Ptr{Cvoid}

# typedef void ( * WGPUProcBufferDestroy ) ( WGPUBuffer buffer )
const WGPUProcBufferDestroy = Ptr{Cvoid}

# typedef void const * ( * WGPUProcBufferGetConstMappedRange ) ( WGPUBuffer buffer , size_t offset , size_t size )
const WGPUProcBufferGetConstMappedRange = Ptr{Cvoid}

# typedef WGPUBufferMapState ( * WGPUProcBufferGetMapState ) ( WGPUBuffer buffer )
const WGPUProcBufferGetMapState = Ptr{Cvoid}

# typedef void * ( * WGPUProcBufferGetMappedRange ) ( WGPUBuffer buffer , size_t offset , size_t size )
const WGPUProcBufferGetMappedRange = Ptr{Cvoid}

# typedef uint64_t ( * WGPUProcBufferGetSize ) ( WGPUBuffer buffer )
const WGPUProcBufferGetSize = Ptr{Cvoid}

# typedef WGPUBufferUsageFlags ( * WGPUProcBufferGetUsage ) ( WGPUBuffer buffer )
const WGPUProcBufferGetUsage = Ptr{Cvoid}

# typedef void ( * WGPUProcBufferMapAsync ) ( WGPUBuffer buffer , WGPUMapModeFlags mode , size_t offset , size_t size , WGPUBufferMapCallback callback , void * userdata )
const WGPUProcBufferMapAsync = Ptr{Cvoid}

# typedef void ( * WGPUProcBufferSetLabel ) ( WGPUBuffer buffer , char const * label )
const WGPUProcBufferSetLabel = Ptr{Cvoid}

# typedef void ( * WGPUProcBufferUnmap ) ( WGPUBuffer buffer )
const WGPUProcBufferUnmap = Ptr{Cvoid}

# typedef void ( * WGPUProcBufferReference ) ( WGPUBuffer buffer )
const WGPUProcBufferReference = Ptr{Cvoid}

# typedef void ( * WGPUProcBufferRelease ) ( WGPUBuffer buffer )
const WGPUProcBufferRelease = Ptr{Cvoid}

# typedef void ( * WGPUProcCommandBufferSetLabel ) ( WGPUCommandBuffer commandBuffer , char const * label )
const WGPUProcCommandBufferSetLabel = Ptr{Cvoid}

# typedef void ( * WGPUProcCommandBufferReference ) ( WGPUCommandBuffer commandBuffer )
const WGPUProcCommandBufferReference = Ptr{Cvoid}

# typedef void ( * WGPUProcCommandBufferRelease ) ( WGPUCommandBuffer commandBuffer )
const WGPUProcCommandBufferRelease = Ptr{Cvoid}

# typedef WGPUComputePassEncoder ( * WGPUProcCommandEncoderBeginComputePass ) ( WGPUCommandEncoder commandEncoder , WGPU_NULLABLE WGPUComputePassDescriptor const * descriptor )
const WGPUProcCommandEncoderBeginComputePass = Ptr{Cvoid}

# typedef WGPURenderPassEncoder ( * WGPUProcCommandEncoderBeginRenderPass ) ( WGPUCommandEncoder commandEncoder , WGPURenderPassDescriptor const * descriptor )
const WGPUProcCommandEncoderBeginRenderPass = Ptr{Cvoid}

# typedef void ( * WGPUProcCommandEncoderClearBuffer ) ( WGPUCommandEncoder commandEncoder , WGPUBuffer buffer , uint64_t offset , uint64_t size )
const WGPUProcCommandEncoderClearBuffer = Ptr{Cvoid}

# typedef void ( * WGPUProcCommandEncoderCopyBufferToBuffer ) ( WGPUCommandEncoder commandEncoder , WGPUBuffer source , uint64_t sourceOffset , WGPUBuffer destination , uint64_t destinationOffset , uint64_t size )
const WGPUProcCommandEncoderCopyBufferToBuffer = Ptr{Cvoid}

# typedef void ( * WGPUProcCommandEncoderCopyBufferToTexture ) ( WGPUCommandEncoder commandEncoder , WGPUImageCopyBuffer const * source , WGPUImageCopyTexture const * destination , WGPUExtent3D const * copySize )
const WGPUProcCommandEncoderCopyBufferToTexture = Ptr{Cvoid}

# typedef void ( * WGPUProcCommandEncoderCopyTextureToBuffer ) ( WGPUCommandEncoder commandEncoder , WGPUImageCopyTexture const * source , WGPUImageCopyBuffer const * destination , WGPUExtent3D const * copySize )
const WGPUProcCommandEncoderCopyTextureToBuffer = Ptr{Cvoid}

# typedef void ( * WGPUProcCommandEncoderCopyTextureToTexture ) ( WGPUCommandEncoder commandEncoder , WGPUImageCopyTexture const * source , WGPUImageCopyTexture const * destination , WGPUExtent3D const * copySize )
const WGPUProcCommandEncoderCopyTextureToTexture = Ptr{Cvoid}

# typedef WGPUCommandBuffer ( * WGPUProcCommandEncoderFinish ) ( WGPUCommandEncoder commandEncoder , WGPU_NULLABLE WGPUCommandBufferDescriptor const * descriptor )
const WGPUProcCommandEncoderFinish = Ptr{Cvoid}

# typedef void ( * WGPUProcCommandEncoderInsertDebugMarker ) ( WGPUCommandEncoder commandEncoder , char const * markerLabel )
const WGPUProcCommandEncoderInsertDebugMarker = Ptr{Cvoid}

# typedef void ( * WGPUProcCommandEncoderPopDebugGroup ) ( WGPUCommandEncoder commandEncoder )
const WGPUProcCommandEncoderPopDebugGroup = Ptr{Cvoid}

# typedef void ( * WGPUProcCommandEncoderPushDebugGroup ) ( WGPUCommandEncoder commandEncoder , char const * groupLabel )
const WGPUProcCommandEncoderPushDebugGroup = Ptr{Cvoid}

# typedef void ( * WGPUProcCommandEncoderResolveQuerySet ) ( WGPUCommandEncoder commandEncoder , WGPUQuerySet querySet , uint32_t firstQuery , uint32_t queryCount , WGPUBuffer destination , uint64_t destinationOffset )
const WGPUProcCommandEncoderResolveQuerySet = Ptr{Cvoid}

# typedef void ( * WGPUProcCommandEncoderSetLabel ) ( WGPUCommandEncoder commandEncoder , char const * label )
const WGPUProcCommandEncoderSetLabel = Ptr{Cvoid}

# typedef void ( * WGPUProcCommandEncoderWriteTimestamp ) ( WGPUCommandEncoder commandEncoder , WGPUQuerySet querySet , uint32_t queryIndex )
const WGPUProcCommandEncoderWriteTimestamp = Ptr{Cvoid}

# typedef void ( * WGPUProcCommandEncoderReference ) ( WGPUCommandEncoder commandEncoder )
const WGPUProcCommandEncoderReference = Ptr{Cvoid}

# typedef void ( * WGPUProcCommandEncoderRelease ) ( WGPUCommandEncoder commandEncoder )
const WGPUProcCommandEncoderRelease = Ptr{Cvoid}

# typedef void ( * WGPUProcComputePassEncoderBeginPipelineStatisticsQuery ) ( WGPUComputePassEncoder computePassEncoder , WGPUQuerySet querySet , uint32_t queryIndex )
const WGPUProcComputePassEncoderBeginPipelineStatisticsQuery = Ptr{Cvoid}

# typedef void ( * WGPUProcComputePassEncoderDispatchWorkgroups ) ( WGPUComputePassEncoder computePassEncoder , uint32_t workgroupCountX , uint32_t workgroupCountY , uint32_t workgroupCountZ )
const WGPUProcComputePassEncoderDispatchWorkgroups = Ptr{Cvoid}

# typedef void ( * WGPUProcComputePassEncoderDispatchWorkgroupsIndirect ) ( WGPUComputePassEncoder computePassEncoder , WGPUBuffer indirectBuffer , uint64_t indirectOffset )
const WGPUProcComputePassEncoderDispatchWorkgroupsIndirect = Ptr{Cvoid}

# typedef void ( * WGPUProcComputePassEncoderEnd ) ( WGPUComputePassEncoder computePassEncoder )
const WGPUProcComputePassEncoderEnd = Ptr{Cvoid}

# typedef void ( * WGPUProcComputePassEncoderEndPipelineStatisticsQuery ) ( WGPUComputePassEncoder computePassEncoder )
const WGPUProcComputePassEncoderEndPipelineStatisticsQuery = Ptr{Cvoid}

# typedef void ( * WGPUProcComputePassEncoderInsertDebugMarker ) ( WGPUComputePassEncoder computePassEncoder , char const * markerLabel )
const WGPUProcComputePassEncoderInsertDebugMarker = Ptr{Cvoid}

# typedef void ( * WGPUProcComputePassEncoderPopDebugGroup ) ( WGPUComputePassEncoder computePassEncoder )
const WGPUProcComputePassEncoderPopDebugGroup = Ptr{Cvoid}

# typedef void ( * WGPUProcComputePassEncoderPushDebugGroup ) ( WGPUComputePassEncoder computePassEncoder , char const * groupLabel )
const WGPUProcComputePassEncoderPushDebugGroup = Ptr{Cvoid}

# typedef void ( * WGPUProcComputePassEncoderSetBindGroup ) ( WGPUComputePassEncoder computePassEncoder , uint32_t groupIndex , WGPU_NULLABLE WGPUBindGroup group , size_t dynamicOffsetCount , uint32_t const * dynamicOffsets )
const WGPUProcComputePassEncoderSetBindGroup = Ptr{Cvoid}

# typedef void ( * WGPUProcComputePassEncoderSetLabel ) ( WGPUComputePassEncoder computePassEncoder , char const * label )
const WGPUProcComputePassEncoderSetLabel = Ptr{Cvoid}

# typedef void ( * WGPUProcComputePassEncoderSetPipeline ) ( WGPUComputePassEncoder computePassEncoder , WGPUComputePipeline pipeline )
const WGPUProcComputePassEncoderSetPipeline = Ptr{Cvoid}

# typedef void ( * WGPUProcComputePassEncoderReference ) ( WGPUComputePassEncoder computePassEncoder )
const WGPUProcComputePassEncoderReference = Ptr{Cvoid}

# typedef void ( * WGPUProcComputePassEncoderRelease ) ( WGPUComputePassEncoder computePassEncoder )
const WGPUProcComputePassEncoderRelease = Ptr{Cvoid}

# typedef WGPUBindGroupLayout ( * WGPUProcComputePipelineGetBindGroupLayout ) ( WGPUComputePipeline computePipeline , uint32_t groupIndex )
const WGPUProcComputePipelineGetBindGroupLayout = Ptr{Cvoid}

# typedef void ( * WGPUProcComputePipelineSetLabel ) ( WGPUComputePipeline computePipeline , char const * label )
const WGPUProcComputePipelineSetLabel = Ptr{Cvoid}

# typedef void ( * WGPUProcComputePipelineReference ) ( WGPUComputePipeline computePipeline )
const WGPUProcComputePipelineReference = Ptr{Cvoid}

# typedef void ( * WGPUProcComputePipelineRelease ) ( WGPUComputePipeline computePipeline )
const WGPUProcComputePipelineRelease = Ptr{Cvoid}

# typedef WGPUBindGroup ( * WGPUProcDeviceCreateBindGroup ) ( WGPUDevice device , WGPUBindGroupDescriptor const * descriptor )
const WGPUProcDeviceCreateBindGroup = Ptr{Cvoid}

# typedef WGPUBindGroupLayout ( * WGPUProcDeviceCreateBindGroupLayout ) ( WGPUDevice device , WGPUBindGroupLayoutDescriptor const * descriptor )
const WGPUProcDeviceCreateBindGroupLayout = Ptr{Cvoid}

# typedef WGPUBuffer ( * WGPUProcDeviceCreateBuffer ) ( WGPUDevice device , WGPUBufferDescriptor const * descriptor )
const WGPUProcDeviceCreateBuffer = Ptr{Cvoid}

# typedef WGPUCommandEncoder ( * WGPUProcDeviceCreateCommandEncoder ) ( WGPUDevice device , WGPU_NULLABLE WGPUCommandEncoderDescriptor const * descriptor )
const WGPUProcDeviceCreateCommandEncoder = Ptr{Cvoid}

# typedef WGPUComputePipeline ( * WGPUProcDeviceCreateComputePipeline ) ( WGPUDevice device , WGPUComputePipelineDescriptor const * descriptor )
const WGPUProcDeviceCreateComputePipeline = Ptr{Cvoid}

# typedef void ( * WGPUProcDeviceCreateComputePipelineAsync ) ( WGPUDevice device , WGPUComputePipelineDescriptor const * descriptor , WGPUCreateComputePipelineAsyncCallback callback , void * userdata )
const WGPUProcDeviceCreateComputePipelineAsync = Ptr{Cvoid}

# typedef WGPUPipelineLayout ( * WGPUProcDeviceCreatePipelineLayout ) ( WGPUDevice device , WGPUPipelineLayoutDescriptor const * descriptor )
const WGPUProcDeviceCreatePipelineLayout = Ptr{Cvoid}

# typedef WGPUQuerySet ( * WGPUProcDeviceCreateQuerySet ) ( WGPUDevice device , WGPUQuerySetDescriptor const * descriptor )
const WGPUProcDeviceCreateQuerySet = Ptr{Cvoid}

# typedef WGPURenderBundleEncoder ( * WGPUProcDeviceCreateRenderBundleEncoder ) ( WGPUDevice device , WGPURenderBundleEncoderDescriptor const * descriptor )
const WGPUProcDeviceCreateRenderBundleEncoder = Ptr{Cvoid}

# typedef WGPURenderPipeline ( * WGPUProcDeviceCreateRenderPipeline ) ( WGPUDevice device , WGPURenderPipelineDescriptor const * descriptor )
const WGPUProcDeviceCreateRenderPipeline = Ptr{Cvoid}

# typedef void ( * WGPUProcDeviceCreateRenderPipelineAsync ) ( WGPUDevice device , WGPURenderPipelineDescriptor const * descriptor , WGPUCreateRenderPipelineAsyncCallback callback , void * userdata )
const WGPUProcDeviceCreateRenderPipelineAsync = Ptr{Cvoid}

# typedef WGPUSampler ( * WGPUProcDeviceCreateSampler ) ( WGPUDevice device , WGPU_NULLABLE WGPUSamplerDescriptor const * descriptor )
const WGPUProcDeviceCreateSampler = Ptr{Cvoid}

# typedef WGPUShaderModule ( * WGPUProcDeviceCreateShaderModule ) ( WGPUDevice device , WGPUShaderModuleDescriptor const * descriptor )
const WGPUProcDeviceCreateShaderModule = Ptr{Cvoid}

# typedef WGPUSwapChain ( * WGPUProcDeviceCreateSwapChain ) ( WGPUDevice device , WGPUSurface surface , WGPUSwapChainDescriptor const * descriptor )
const WGPUProcDeviceCreateSwapChain = Ptr{Cvoid}

# typedef WGPUTexture ( * WGPUProcDeviceCreateTexture ) ( WGPUDevice device , WGPUTextureDescriptor const * descriptor )
const WGPUProcDeviceCreateTexture = Ptr{Cvoid}

# typedef void ( * WGPUProcDeviceDestroy ) ( WGPUDevice device )
const WGPUProcDeviceDestroy = Ptr{Cvoid}

# typedef size_t ( * WGPUProcDeviceEnumerateFeatures ) ( WGPUDevice device , WGPUFeatureName * features )
const WGPUProcDeviceEnumerateFeatures = Ptr{Cvoid}

# typedef bool ( * WGPUProcDeviceGetLimits ) ( WGPUDevice device , WGPUSupportedLimits * limits )
const WGPUProcDeviceGetLimits = Ptr{Cvoid}

# typedef WGPUQueue ( * WGPUProcDeviceGetQueue ) ( WGPUDevice device )
const WGPUProcDeviceGetQueue = Ptr{Cvoid}

# typedef bool ( * WGPUProcDeviceHasFeature ) ( WGPUDevice device , WGPUFeatureName feature )
const WGPUProcDeviceHasFeature = Ptr{Cvoid}

# typedef void ( * WGPUProcDevicePopErrorScope ) ( WGPUDevice device , WGPUErrorCallback callback , void * userdata )
const WGPUProcDevicePopErrorScope = Ptr{Cvoid}

# typedef void ( * WGPUProcDevicePushErrorScope ) ( WGPUDevice device , WGPUErrorFilter filter )
const WGPUProcDevicePushErrorScope = Ptr{Cvoid}

# typedef void ( * WGPUProcDeviceSetLabel ) ( WGPUDevice device , char const * label )
const WGPUProcDeviceSetLabel = Ptr{Cvoid}

# typedef void ( * WGPUProcDeviceSetUncapturedErrorCallback ) ( WGPUDevice device , WGPUErrorCallback callback , void * userdata )
const WGPUProcDeviceSetUncapturedErrorCallback = Ptr{Cvoid}

# typedef void ( * WGPUProcDeviceReference ) ( WGPUDevice device )
const WGPUProcDeviceReference = Ptr{Cvoid}

# typedef void ( * WGPUProcDeviceRelease ) ( WGPUDevice device )
const WGPUProcDeviceRelease = Ptr{Cvoid}

# typedef WGPUSurface ( * WGPUProcInstanceCreateSurface ) ( WGPUInstance instance , WGPUSurfaceDescriptor const * descriptor )
const WGPUProcInstanceCreateSurface = Ptr{Cvoid}

# typedef void ( * WGPUProcInstanceProcessEvents ) ( WGPUInstance instance )
const WGPUProcInstanceProcessEvents = Ptr{Cvoid}

# typedef void ( * WGPUProcInstanceRequestAdapter ) ( WGPUInstance instance , WGPU_NULLABLE WGPURequestAdapterOptions const * options , WGPURequestAdapterCallback callback , void * userdata )
const WGPUProcInstanceRequestAdapter = Ptr{Cvoid}

# typedef void ( * WGPUProcInstanceReference ) ( WGPUInstance instance )
const WGPUProcInstanceReference = Ptr{Cvoid}

# typedef void ( * WGPUProcInstanceRelease ) ( WGPUInstance instance )
const WGPUProcInstanceRelease = Ptr{Cvoid}

# typedef void ( * WGPUProcPipelineLayoutSetLabel ) ( WGPUPipelineLayout pipelineLayout , char const * label )
const WGPUProcPipelineLayoutSetLabel = Ptr{Cvoid}

# typedef void ( * WGPUProcPipelineLayoutReference ) ( WGPUPipelineLayout pipelineLayout )
const WGPUProcPipelineLayoutReference = Ptr{Cvoid}

# typedef void ( * WGPUProcPipelineLayoutRelease ) ( WGPUPipelineLayout pipelineLayout )
const WGPUProcPipelineLayoutRelease = Ptr{Cvoid}

# typedef void ( * WGPUProcQuerySetDestroy ) ( WGPUQuerySet querySet )
const WGPUProcQuerySetDestroy = Ptr{Cvoid}

# typedef uint32_t ( * WGPUProcQuerySetGetCount ) ( WGPUQuerySet querySet )
const WGPUProcQuerySetGetCount = Ptr{Cvoid}

# typedef WGPUQueryType ( * WGPUProcQuerySetGetType ) ( WGPUQuerySet querySet )
const WGPUProcQuerySetGetType = Ptr{Cvoid}

# typedef void ( * WGPUProcQuerySetSetLabel ) ( WGPUQuerySet querySet , char const * label )
const WGPUProcQuerySetSetLabel = Ptr{Cvoid}

# typedef void ( * WGPUProcQuerySetReference ) ( WGPUQuerySet querySet )
const WGPUProcQuerySetReference = Ptr{Cvoid}

# typedef void ( * WGPUProcQuerySetRelease ) ( WGPUQuerySet querySet )
const WGPUProcQuerySetRelease = Ptr{Cvoid}

# typedef void ( * WGPUProcQueueOnSubmittedWorkDone ) ( WGPUQueue queue , WGPUQueueWorkDoneCallback callback , void * userdata )
const WGPUProcQueueOnSubmittedWorkDone = Ptr{Cvoid}

# typedef void ( * WGPUProcQueueSetLabel ) ( WGPUQueue queue , char const * label )
const WGPUProcQueueSetLabel = Ptr{Cvoid}

# typedef void ( * WGPUProcQueueSubmit ) ( WGPUQueue queue , size_t commandCount , WGPUCommandBuffer const * commands )
const WGPUProcQueueSubmit = Ptr{Cvoid}

# typedef void ( * WGPUProcQueueWriteBuffer ) ( WGPUQueue queue , WGPUBuffer buffer , uint64_t bufferOffset , void const * data , size_t size )
const WGPUProcQueueWriteBuffer = Ptr{Cvoid}

# typedef void ( * WGPUProcQueueWriteTexture ) ( WGPUQueue queue , WGPUImageCopyTexture const * destination , void const * data , size_t dataSize , WGPUTextureDataLayout const * dataLayout , WGPUExtent3D const * writeSize )
const WGPUProcQueueWriteTexture = Ptr{Cvoid}

# typedef void ( * WGPUProcQueueReference ) ( WGPUQueue queue )
const WGPUProcQueueReference = Ptr{Cvoid}

# typedef void ( * WGPUProcQueueRelease ) ( WGPUQueue queue )
const WGPUProcQueueRelease = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderBundleSetLabel ) ( WGPURenderBundle renderBundle , char const * label )
const WGPUProcRenderBundleSetLabel = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderBundleReference ) ( WGPURenderBundle renderBundle )
const WGPUProcRenderBundleReference = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderBundleRelease ) ( WGPURenderBundle renderBundle )
const WGPUProcRenderBundleRelease = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderBundleEncoderDraw ) ( WGPURenderBundleEncoder renderBundleEncoder , uint32_t vertexCount , uint32_t instanceCount , uint32_t firstVertex , uint32_t firstInstance )
const WGPUProcRenderBundleEncoderDraw = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderBundleEncoderDrawIndexed ) ( WGPURenderBundleEncoder renderBundleEncoder , uint32_t indexCount , uint32_t instanceCount , uint32_t firstIndex , int32_t baseVertex , uint32_t firstInstance )
const WGPUProcRenderBundleEncoderDrawIndexed = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderBundleEncoderDrawIndexedIndirect ) ( WGPURenderBundleEncoder renderBundleEncoder , WGPUBuffer indirectBuffer , uint64_t indirectOffset )
const WGPUProcRenderBundleEncoderDrawIndexedIndirect = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderBundleEncoderDrawIndirect ) ( WGPURenderBundleEncoder renderBundleEncoder , WGPUBuffer indirectBuffer , uint64_t indirectOffset )
const WGPUProcRenderBundleEncoderDrawIndirect = Ptr{Cvoid}

# typedef WGPURenderBundle ( * WGPUProcRenderBundleEncoderFinish ) ( WGPURenderBundleEncoder renderBundleEncoder , WGPU_NULLABLE WGPURenderBundleDescriptor const * descriptor )
const WGPUProcRenderBundleEncoderFinish = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderBundleEncoderInsertDebugMarker ) ( WGPURenderBundleEncoder renderBundleEncoder , char const * markerLabel )
const WGPUProcRenderBundleEncoderInsertDebugMarker = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderBundleEncoderPopDebugGroup ) ( WGPURenderBundleEncoder renderBundleEncoder )
const WGPUProcRenderBundleEncoderPopDebugGroup = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderBundleEncoderPushDebugGroup ) ( WGPURenderBundleEncoder renderBundleEncoder , char const * groupLabel )
const WGPUProcRenderBundleEncoderPushDebugGroup = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderBundleEncoderSetBindGroup ) ( WGPURenderBundleEncoder renderBundleEncoder , uint32_t groupIndex , WGPU_NULLABLE WGPUBindGroup group , size_t dynamicOffsetCount , uint32_t const * dynamicOffsets )
const WGPUProcRenderBundleEncoderSetBindGroup = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderBundleEncoderSetIndexBuffer ) ( WGPURenderBundleEncoder renderBundleEncoder , WGPUBuffer buffer , WGPUIndexFormat format , uint64_t offset , uint64_t size )
const WGPUProcRenderBundleEncoderSetIndexBuffer = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderBundleEncoderSetLabel ) ( WGPURenderBundleEncoder renderBundleEncoder , char const * label )
const WGPUProcRenderBundleEncoderSetLabel = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderBundleEncoderSetPipeline ) ( WGPURenderBundleEncoder renderBundleEncoder , WGPURenderPipeline pipeline )
const WGPUProcRenderBundleEncoderSetPipeline = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderBundleEncoderSetVertexBuffer ) ( WGPURenderBundleEncoder renderBundleEncoder , uint32_t slot , WGPU_NULLABLE WGPUBuffer buffer , uint64_t offset , uint64_t size )
const WGPUProcRenderBundleEncoderSetVertexBuffer = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderBundleEncoderReference ) ( WGPURenderBundleEncoder renderBundleEncoder )
const WGPUProcRenderBundleEncoderReference = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderBundleEncoderRelease ) ( WGPURenderBundleEncoder renderBundleEncoder )
const WGPUProcRenderBundleEncoderRelease = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderPassEncoderBeginOcclusionQuery ) ( WGPURenderPassEncoder renderPassEncoder , uint32_t queryIndex )
const WGPUProcRenderPassEncoderBeginOcclusionQuery = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderPassEncoderBeginPipelineStatisticsQuery ) ( WGPURenderPassEncoder renderPassEncoder , WGPUQuerySet querySet , uint32_t queryIndex )
const WGPUProcRenderPassEncoderBeginPipelineStatisticsQuery = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderPassEncoderDraw ) ( WGPURenderPassEncoder renderPassEncoder , uint32_t vertexCount , uint32_t instanceCount , uint32_t firstVertex , uint32_t firstInstance )
const WGPUProcRenderPassEncoderDraw = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderPassEncoderDrawIndexed ) ( WGPURenderPassEncoder renderPassEncoder , uint32_t indexCount , uint32_t instanceCount , uint32_t firstIndex , int32_t baseVertex , uint32_t firstInstance )
const WGPUProcRenderPassEncoderDrawIndexed = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderPassEncoderDrawIndexedIndirect ) ( WGPURenderPassEncoder renderPassEncoder , WGPUBuffer indirectBuffer , uint64_t indirectOffset )
const WGPUProcRenderPassEncoderDrawIndexedIndirect = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderPassEncoderDrawIndirect ) ( WGPURenderPassEncoder renderPassEncoder , WGPUBuffer indirectBuffer , uint64_t indirectOffset )
const WGPUProcRenderPassEncoderDrawIndirect = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderPassEncoderEnd ) ( WGPURenderPassEncoder renderPassEncoder )
const WGPUProcRenderPassEncoderEnd = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderPassEncoderEndOcclusionQuery ) ( WGPURenderPassEncoder renderPassEncoder )
const WGPUProcRenderPassEncoderEndOcclusionQuery = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderPassEncoderEndPipelineStatisticsQuery ) ( WGPURenderPassEncoder renderPassEncoder )
const WGPUProcRenderPassEncoderEndPipelineStatisticsQuery = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderPassEncoderExecuteBundles ) ( WGPURenderPassEncoder renderPassEncoder , size_t bundleCount , WGPURenderBundle const * bundles )
const WGPUProcRenderPassEncoderExecuteBundles = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderPassEncoderInsertDebugMarker ) ( WGPURenderPassEncoder renderPassEncoder , char const * markerLabel )
const WGPUProcRenderPassEncoderInsertDebugMarker = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderPassEncoderPopDebugGroup ) ( WGPURenderPassEncoder renderPassEncoder )
const WGPUProcRenderPassEncoderPopDebugGroup = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderPassEncoderPushDebugGroup ) ( WGPURenderPassEncoder renderPassEncoder , char const * groupLabel )
const WGPUProcRenderPassEncoderPushDebugGroup = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderPassEncoderSetBindGroup ) ( WGPURenderPassEncoder renderPassEncoder , uint32_t groupIndex , WGPU_NULLABLE WGPUBindGroup group , size_t dynamicOffsetCount , uint32_t const * dynamicOffsets )
const WGPUProcRenderPassEncoderSetBindGroup = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderPassEncoderSetBlendConstant ) ( WGPURenderPassEncoder renderPassEncoder , WGPUColor const * color )
const WGPUProcRenderPassEncoderSetBlendConstant = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderPassEncoderSetIndexBuffer ) ( WGPURenderPassEncoder renderPassEncoder , WGPUBuffer buffer , WGPUIndexFormat format , uint64_t offset , uint64_t size )
const WGPUProcRenderPassEncoderSetIndexBuffer = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderPassEncoderSetLabel ) ( WGPURenderPassEncoder renderPassEncoder , char const * label )
const WGPUProcRenderPassEncoderSetLabel = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderPassEncoderSetPipeline ) ( WGPURenderPassEncoder renderPassEncoder , WGPURenderPipeline pipeline )
const WGPUProcRenderPassEncoderSetPipeline = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderPassEncoderSetScissorRect ) ( WGPURenderPassEncoder renderPassEncoder , uint32_t x , uint32_t y , uint32_t width , uint32_t height )
const WGPUProcRenderPassEncoderSetScissorRect = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderPassEncoderSetStencilReference ) ( WGPURenderPassEncoder renderPassEncoder , uint32_t reference )
const WGPUProcRenderPassEncoderSetStencilReference = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderPassEncoderSetVertexBuffer ) ( WGPURenderPassEncoder renderPassEncoder , uint32_t slot , WGPU_NULLABLE WGPUBuffer buffer , uint64_t offset , uint64_t size )
const WGPUProcRenderPassEncoderSetVertexBuffer = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderPassEncoderSetViewport ) ( WGPURenderPassEncoder renderPassEncoder , float x , float y , float width , float height , float minDepth , float maxDepth )
const WGPUProcRenderPassEncoderSetViewport = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderPassEncoderReference ) ( WGPURenderPassEncoder renderPassEncoder )
const WGPUProcRenderPassEncoderReference = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderPassEncoderRelease ) ( WGPURenderPassEncoder renderPassEncoder )
const WGPUProcRenderPassEncoderRelease = Ptr{Cvoid}

# typedef WGPUBindGroupLayout ( * WGPUProcRenderPipelineGetBindGroupLayout ) ( WGPURenderPipeline renderPipeline , uint32_t groupIndex )
const WGPUProcRenderPipelineGetBindGroupLayout = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderPipelineSetLabel ) ( WGPURenderPipeline renderPipeline , char const * label )
const WGPUProcRenderPipelineSetLabel = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderPipelineReference ) ( WGPURenderPipeline renderPipeline )
const WGPUProcRenderPipelineReference = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderPipelineRelease ) ( WGPURenderPipeline renderPipeline )
const WGPUProcRenderPipelineRelease = Ptr{Cvoid}

# typedef void ( * WGPUProcSamplerSetLabel ) ( WGPUSampler sampler , char const * label )
const WGPUProcSamplerSetLabel = Ptr{Cvoid}

# typedef void ( * WGPUProcSamplerReference ) ( WGPUSampler sampler )
const WGPUProcSamplerReference = Ptr{Cvoid}

# typedef void ( * WGPUProcSamplerRelease ) ( WGPUSampler sampler )
const WGPUProcSamplerRelease = Ptr{Cvoid}

# typedef void ( * WGPUProcShaderModuleGetCompilationInfo ) ( WGPUShaderModule shaderModule , WGPUCompilationInfoCallback callback , void * userdata )
const WGPUProcShaderModuleGetCompilationInfo = Ptr{Cvoid}

# typedef void ( * WGPUProcShaderModuleSetLabel ) ( WGPUShaderModule shaderModule , char const * label )
const WGPUProcShaderModuleSetLabel = Ptr{Cvoid}

# typedef void ( * WGPUProcShaderModuleReference ) ( WGPUShaderModule shaderModule )
const WGPUProcShaderModuleReference = Ptr{Cvoid}

# typedef void ( * WGPUProcShaderModuleRelease ) ( WGPUShaderModule shaderModule )
const WGPUProcShaderModuleRelease = Ptr{Cvoid}

# typedef WGPUTextureFormat ( * WGPUProcSurfaceGetPreferredFormat ) ( WGPUSurface surface , WGPUAdapter adapter )
const WGPUProcSurfaceGetPreferredFormat = Ptr{Cvoid}

# typedef void ( * WGPUProcSurfaceReference ) ( WGPUSurface surface )
const WGPUProcSurfaceReference = Ptr{Cvoid}

# typedef void ( * WGPUProcSurfaceRelease ) ( WGPUSurface surface )
const WGPUProcSurfaceRelease = Ptr{Cvoid}

# typedef WGPUTextureView ( * WGPUProcSwapChainGetCurrentTextureView ) ( WGPUSwapChain swapChain )
const WGPUProcSwapChainGetCurrentTextureView = Ptr{Cvoid}

# typedef void ( * WGPUProcSwapChainPresent ) ( WGPUSwapChain swapChain )
const WGPUProcSwapChainPresent = Ptr{Cvoid}

# typedef void ( * WGPUProcSwapChainReference ) ( WGPUSwapChain swapChain )
const WGPUProcSwapChainReference = Ptr{Cvoid}

# typedef void ( * WGPUProcSwapChainRelease ) ( WGPUSwapChain swapChain )
const WGPUProcSwapChainRelease = Ptr{Cvoid}

# typedef WGPUTextureView ( * WGPUProcTextureCreateView ) ( WGPUTexture texture , WGPU_NULLABLE WGPUTextureViewDescriptor const * descriptor )
const WGPUProcTextureCreateView = Ptr{Cvoid}

# typedef void ( * WGPUProcTextureDestroy ) ( WGPUTexture texture )
const WGPUProcTextureDestroy = Ptr{Cvoid}

# typedef uint32_t ( * WGPUProcTextureGetDepthOrArrayLayers ) ( WGPUTexture texture )
const WGPUProcTextureGetDepthOrArrayLayers = Ptr{Cvoid}

# typedef WGPUTextureDimension ( * WGPUProcTextureGetDimension ) ( WGPUTexture texture )
const WGPUProcTextureGetDimension = Ptr{Cvoid}

# typedef WGPUTextureFormat ( * WGPUProcTextureGetFormat ) ( WGPUTexture texture )
const WGPUProcTextureGetFormat = Ptr{Cvoid}

# typedef uint32_t ( * WGPUProcTextureGetHeight ) ( WGPUTexture texture )
const WGPUProcTextureGetHeight = Ptr{Cvoid}

# typedef uint32_t ( * WGPUProcTextureGetMipLevelCount ) ( WGPUTexture texture )
const WGPUProcTextureGetMipLevelCount = Ptr{Cvoid}

# typedef uint32_t ( * WGPUProcTextureGetSampleCount ) ( WGPUTexture texture )
const WGPUProcTextureGetSampleCount = Ptr{Cvoid}

# typedef WGPUTextureUsageFlags ( * WGPUProcTextureGetUsage ) ( WGPUTexture texture )
const WGPUProcTextureGetUsage = Ptr{Cvoid}

# typedef uint32_t ( * WGPUProcTextureGetWidth ) ( WGPUTexture texture )
const WGPUProcTextureGetWidth = Ptr{Cvoid}

# typedef void ( * WGPUProcTextureSetLabel ) ( WGPUTexture texture , char const * label )
const WGPUProcTextureSetLabel = Ptr{Cvoid}

# typedef void ( * WGPUProcTextureReference ) ( WGPUTexture texture )
const WGPUProcTextureReference = Ptr{Cvoid}

# typedef void ( * WGPUProcTextureRelease ) ( WGPUTexture texture )
const WGPUProcTextureRelease = Ptr{Cvoid}

# typedef void ( * WGPUProcTextureViewSetLabel ) ( WGPUTextureView textureView , char const * label )
const WGPUProcTextureViewSetLabel = Ptr{Cvoid}

# typedef void ( * WGPUProcTextureViewReference ) ( WGPUTextureView textureView )
const WGPUProcTextureViewReference = Ptr{Cvoid}

# typedef void ( * WGPUProcTextureViewRelease ) ( WGPUTextureView textureView )
const WGPUProcTextureViewRelease = Ptr{Cvoid}

function wgpuCreateInstance(descriptor)
    ccall((:wgpuCreateInstance, libWGPU), WGPUInstance, (Ptr{WGPUInstanceDescriptor},), descriptor)
end

function wgpuGetProcAddress(device, procName)
    ccall((:wgpuGetProcAddress, libWGPU), WGPUProc, (WGPUDevice, Ptr{Cchar}), device, procName)
end

function wgpuAdapterEnumerateFeatures(adapter, features)
    ccall((:wgpuAdapterEnumerateFeatures, libWGPU), Csize_t, (WGPUAdapter, Ptr{WGPUFeatureName}), adapter, features)
end

function wgpuAdapterGetLimits(adapter, limits)
    ccall((:wgpuAdapterGetLimits, libWGPU), Bool, (WGPUAdapter, Ptr{WGPUSupportedLimits}), adapter, limits)
end

function wgpuAdapterGetProperties(adapter, properties)
    ccall((:wgpuAdapterGetProperties, libWGPU), Cvoid, (WGPUAdapter, Ptr{WGPUAdapterProperties}), adapter, properties)
end

function wgpuAdapterHasFeature(adapter, feature)
    ccall((:wgpuAdapterHasFeature, libWGPU), Bool, (WGPUAdapter, WGPUFeatureName), adapter, feature)
end

function wgpuAdapterRequestDevice(adapter, descriptor, callback, userdata)
    ccall((:wgpuAdapterRequestDevice, libWGPU), Cvoid, (WGPUAdapter, Ptr{WGPUDeviceDescriptor}, WGPURequestDeviceCallback, Ptr{Cvoid}), adapter, descriptor, callback, userdata)
end

function wgpuAdapterReference(adapter)
    ccall((:wgpuAdapterReference, libWGPU), Cvoid, (WGPUAdapter,), adapter)
end

function wgpuAdapterRelease(adapter)
    ccall((:wgpuAdapterRelease, libWGPU), Cvoid, (WGPUAdapter,), adapter)
end

function wgpuBindGroupSetLabel(bindGroup, label)
    ccall((:wgpuBindGroupSetLabel, libWGPU), Cvoid, (WGPUBindGroup, Ptr{Cchar}), bindGroup, label)
end

function wgpuBindGroupReference(bindGroup)
    ccall((:wgpuBindGroupReference, libWGPU), Cvoid, (WGPUBindGroup,), bindGroup)
end

function wgpuBindGroupRelease(bindGroup)
    ccall((:wgpuBindGroupRelease, libWGPU), Cvoid, (WGPUBindGroup,), bindGroup)
end

function wgpuBindGroupLayoutSetLabel(bindGroupLayout, label)
    ccall((:wgpuBindGroupLayoutSetLabel, libWGPU), Cvoid, (WGPUBindGroupLayout, Ptr{Cchar}), bindGroupLayout, label)
end

function wgpuBindGroupLayoutReference(bindGroupLayout)
    ccall((:wgpuBindGroupLayoutReference, libWGPU), Cvoid, (WGPUBindGroupLayout,), bindGroupLayout)
end

function wgpuBindGroupLayoutRelease(bindGroupLayout)
    ccall((:wgpuBindGroupLayoutRelease, libWGPU), Cvoid, (WGPUBindGroupLayout,), bindGroupLayout)
end

function wgpuBufferDestroy(buffer)
    ccall((:wgpuBufferDestroy, libWGPU), Cvoid, (WGPUBuffer,), buffer)
end

function wgpuBufferGetConstMappedRange(buffer, offset, size)
    ccall((:wgpuBufferGetConstMappedRange, libWGPU), Ptr{Cvoid}, (WGPUBuffer, Csize_t, Csize_t), buffer, offset, size)
end

function wgpuBufferGetMapState(buffer)
    ccall((:wgpuBufferGetMapState, libWGPU), WGPUBufferMapState, (WGPUBuffer,), buffer)
end

function wgpuBufferGetMappedRange(buffer, offset, size)
    ccall((:wgpuBufferGetMappedRange, libWGPU), Ptr{Cvoid}, (WGPUBuffer, Csize_t, Csize_t), buffer, offset, size)
end

function wgpuBufferGetSize(buffer)
    ccall((:wgpuBufferGetSize, libWGPU), UInt64, (WGPUBuffer,), buffer)
end

function wgpuBufferGetUsage(buffer)
    ccall((:wgpuBufferGetUsage, libWGPU), WGPUBufferUsageFlags, (WGPUBuffer,), buffer)
end

function wgpuBufferMapAsync(buffer, mode, offset, size, callback, userdata)
    ccall((:wgpuBufferMapAsync, libWGPU), Cvoid, (WGPUBuffer, WGPUMapModeFlags, Csize_t, Csize_t, WGPUBufferMapCallback, Ptr{Cvoid}), buffer, mode, offset, size, callback, userdata)
end

function wgpuBufferSetLabel(buffer, label)
    ccall((:wgpuBufferSetLabel, libWGPU), Cvoid, (WGPUBuffer, Ptr{Cchar}), buffer, label)
end

function wgpuBufferUnmap(buffer)
    ccall((:wgpuBufferUnmap, libWGPU), Cvoid, (WGPUBuffer,), buffer)
end

function wgpuBufferReference(buffer)
    ccall((:wgpuBufferReference, libWGPU), Cvoid, (WGPUBuffer,), buffer)
end

function wgpuBufferRelease(buffer)
    ccall((:wgpuBufferRelease, libWGPU), Cvoid, (WGPUBuffer,), buffer)
end

function wgpuCommandBufferSetLabel(commandBuffer, label)
    ccall((:wgpuCommandBufferSetLabel, libWGPU), Cvoid, (WGPUCommandBuffer, Ptr{Cchar}), commandBuffer, label)
end

function wgpuCommandBufferReference(commandBuffer)
    ccall((:wgpuCommandBufferReference, libWGPU), Cvoid, (WGPUCommandBuffer,), commandBuffer)
end

function wgpuCommandBufferRelease(commandBuffer)
    ccall((:wgpuCommandBufferRelease, libWGPU), Cvoid, (WGPUCommandBuffer,), commandBuffer)
end

function wgpuCommandEncoderBeginComputePass(commandEncoder, descriptor)
    ccall((:wgpuCommandEncoderBeginComputePass, libWGPU), WGPUComputePassEncoder, (WGPUCommandEncoder, Ptr{WGPUComputePassDescriptor}), commandEncoder, descriptor)
end

function wgpuCommandEncoderBeginRenderPass(commandEncoder, descriptor)
    ccall((:wgpuCommandEncoderBeginRenderPass, libWGPU), WGPURenderPassEncoder, (WGPUCommandEncoder, Ptr{WGPURenderPassDescriptor}), commandEncoder, descriptor)
end

function wgpuCommandEncoderClearBuffer(commandEncoder, buffer, offset, size)
    ccall((:wgpuCommandEncoderClearBuffer, libWGPU), Cvoid, (WGPUCommandEncoder, WGPUBuffer, UInt64, UInt64), commandEncoder, buffer, offset, size)
end

function wgpuCommandEncoderCopyBufferToBuffer(commandEncoder, source, sourceOffset, destination, destinationOffset, size)
    ccall((:wgpuCommandEncoderCopyBufferToBuffer, libWGPU), Cvoid, (WGPUCommandEncoder, WGPUBuffer, UInt64, WGPUBuffer, UInt64, UInt64), commandEncoder, source, sourceOffset, destination, destinationOffset, size)
end

function wgpuCommandEncoderCopyBufferToTexture(commandEncoder, source, destination, copySize)
    ccall((:wgpuCommandEncoderCopyBufferToTexture, libWGPU), Cvoid, (WGPUCommandEncoder, Ptr{WGPUImageCopyBuffer}, Ptr{WGPUImageCopyTexture}, Ptr{WGPUExtent3D}), commandEncoder, source, destination, copySize)
end

function wgpuCommandEncoderCopyTextureToBuffer(commandEncoder, source, destination, copySize)
    ccall((:wgpuCommandEncoderCopyTextureToBuffer, libWGPU), Cvoid, (WGPUCommandEncoder, Ptr{WGPUImageCopyTexture}, Ptr{WGPUImageCopyBuffer}, Ptr{WGPUExtent3D}), commandEncoder, source, destination, copySize)
end

function wgpuCommandEncoderCopyTextureToTexture(commandEncoder, source, destination, copySize)
    ccall((:wgpuCommandEncoderCopyTextureToTexture, libWGPU), Cvoid, (WGPUCommandEncoder, Ptr{WGPUImageCopyTexture}, Ptr{WGPUImageCopyTexture}, Ptr{WGPUExtent3D}), commandEncoder, source, destination, copySize)
end

function wgpuCommandEncoderFinish(commandEncoder, descriptor)
    ccall((:wgpuCommandEncoderFinish, libWGPU), WGPUCommandBuffer, (WGPUCommandEncoder, Ptr{WGPUCommandBufferDescriptor}), commandEncoder, descriptor)
end

function wgpuCommandEncoderInsertDebugMarker(commandEncoder, markerLabel)
    ccall((:wgpuCommandEncoderInsertDebugMarker, libWGPU), Cvoid, (WGPUCommandEncoder, Ptr{Cchar}), commandEncoder, markerLabel)
end

function wgpuCommandEncoderPopDebugGroup(commandEncoder)
    ccall((:wgpuCommandEncoderPopDebugGroup, libWGPU), Cvoid, (WGPUCommandEncoder,), commandEncoder)
end

function wgpuCommandEncoderPushDebugGroup(commandEncoder, groupLabel)
    ccall((:wgpuCommandEncoderPushDebugGroup, libWGPU), Cvoid, (WGPUCommandEncoder, Ptr{Cchar}), commandEncoder, groupLabel)
end

function wgpuCommandEncoderResolveQuerySet(commandEncoder, querySet, firstQuery, queryCount, destination, destinationOffset)
    ccall((:wgpuCommandEncoderResolveQuerySet, libWGPU), Cvoid, (WGPUCommandEncoder, WGPUQuerySet, UInt32, UInt32, WGPUBuffer, UInt64), commandEncoder, querySet, firstQuery, queryCount, destination, destinationOffset)
end

function wgpuCommandEncoderSetLabel(commandEncoder, label)
    ccall((:wgpuCommandEncoderSetLabel, libWGPU), Cvoid, (WGPUCommandEncoder, Ptr{Cchar}), commandEncoder, label)
end

function wgpuCommandEncoderWriteTimestamp(commandEncoder, querySet, queryIndex)
    ccall((:wgpuCommandEncoderWriteTimestamp, libWGPU), Cvoid, (WGPUCommandEncoder, WGPUQuerySet, UInt32), commandEncoder, querySet, queryIndex)
end

function wgpuCommandEncoderReference(commandEncoder)
    ccall((:wgpuCommandEncoderReference, libWGPU), Cvoid, (WGPUCommandEncoder,), commandEncoder)
end

function wgpuCommandEncoderRelease(commandEncoder)
    ccall((:wgpuCommandEncoderRelease, libWGPU), Cvoid, (WGPUCommandEncoder,), commandEncoder)
end

function wgpuComputePassEncoderBeginPipelineStatisticsQuery(computePassEncoder, querySet, queryIndex)
    ccall((:wgpuComputePassEncoderBeginPipelineStatisticsQuery, libWGPU), Cvoid, (WGPUComputePassEncoder, WGPUQuerySet, UInt32), computePassEncoder, querySet, queryIndex)
end

function wgpuComputePassEncoderDispatchWorkgroups(computePassEncoder, workgroupCountX, workgroupCountY, workgroupCountZ)
    ccall((:wgpuComputePassEncoderDispatchWorkgroups, libWGPU), Cvoid, (WGPUComputePassEncoder, UInt32, UInt32, UInt32), computePassEncoder, workgroupCountX, workgroupCountY, workgroupCountZ)
end

function wgpuComputePassEncoderDispatchWorkgroupsIndirect(computePassEncoder, indirectBuffer, indirectOffset)
    ccall((:wgpuComputePassEncoderDispatchWorkgroupsIndirect, libWGPU), Cvoid, (WGPUComputePassEncoder, WGPUBuffer, UInt64), computePassEncoder, indirectBuffer, indirectOffset)
end

function wgpuComputePassEncoderEnd(computePassEncoder)
    ccall((:wgpuComputePassEncoderEnd, libWGPU), Cvoid, (WGPUComputePassEncoder,), computePassEncoder)
end

function wgpuComputePassEncoderEndPipelineStatisticsQuery(computePassEncoder)
    ccall((:wgpuComputePassEncoderEndPipelineStatisticsQuery, libWGPU), Cvoid, (WGPUComputePassEncoder,), computePassEncoder)
end

function wgpuComputePassEncoderInsertDebugMarker(computePassEncoder, markerLabel)
    ccall((:wgpuComputePassEncoderInsertDebugMarker, libWGPU), Cvoid, (WGPUComputePassEncoder, Ptr{Cchar}), computePassEncoder, markerLabel)
end

function wgpuComputePassEncoderPopDebugGroup(computePassEncoder)
    ccall((:wgpuComputePassEncoderPopDebugGroup, libWGPU), Cvoid, (WGPUComputePassEncoder,), computePassEncoder)
end

function wgpuComputePassEncoderPushDebugGroup(computePassEncoder, groupLabel)
    ccall((:wgpuComputePassEncoderPushDebugGroup, libWGPU), Cvoid, (WGPUComputePassEncoder, Ptr{Cchar}), computePassEncoder, groupLabel)
end

function wgpuComputePassEncoderSetBindGroup(computePassEncoder, groupIndex, group, dynamicOffsetCount, dynamicOffsets)
    ccall((:wgpuComputePassEncoderSetBindGroup, libWGPU), Cvoid, (WGPUComputePassEncoder, UInt32, WGPUBindGroup, Csize_t, Ptr{UInt32}), computePassEncoder, groupIndex, group, dynamicOffsetCount, dynamicOffsets)
end

function wgpuComputePassEncoderSetLabel(computePassEncoder, label)
    ccall((:wgpuComputePassEncoderSetLabel, libWGPU), Cvoid, (WGPUComputePassEncoder, Ptr{Cchar}), computePassEncoder, label)
end

function wgpuComputePassEncoderSetPipeline(computePassEncoder, pipeline)
    ccall((:wgpuComputePassEncoderSetPipeline, libWGPU), Cvoid, (WGPUComputePassEncoder, WGPUComputePipeline), computePassEncoder, pipeline)
end

function wgpuComputePassEncoderReference(computePassEncoder)
    ccall((:wgpuComputePassEncoderReference, libWGPU), Cvoid, (WGPUComputePassEncoder,), computePassEncoder)
end

function wgpuComputePassEncoderRelease(computePassEncoder)
    ccall((:wgpuComputePassEncoderRelease, libWGPU), Cvoid, (WGPUComputePassEncoder,), computePassEncoder)
end

function wgpuComputePipelineGetBindGroupLayout(computePipeline, groupIndex)
    ccall((:wgpuComputePipelineGetBindGroupLayout, libWGPU), WGPUBindGroupLayout, (WGPUComputePipeline, UInt32), computePipeline, groupIndex)
end

function wgpuComputePipelineSetLabel(computePipeline, label)
    ccall((:wgpuComputePipelineSetLabel, libWGPU), Cvoid, (WGPUComputePipeline, Ptr{Cchar}), computePipeline, label)
end

function wgpuComputePipelineReference(computePipeline)
    ccall((:wgpuComputePipelineReference, libWGPU), Cvoid, (WGPUComputePipeline,), computePipeline)
end

function wgpuComputePipelineRelease(computePipeline)
    ccall((:wgpuComputePipelineRelease, libWGPU), Cvoid, (WGPUComputePipeline,), computePipeline)
end

function wgpuDeviceCreateBindGroup(device, descriptor)
    ccall((:wgpuDeviceCreateBindGroup, libWGPU), WGPUBindGroup, (WGPUDevice, Ptr{WGPUBindGroupDescriptor}), device, descriptor)
end

function wgpuDeviceCreateBindGroupLayout(device, descriptor)
    ccall((:wgpuDeviceCreateBindGroupLayout, libWGPU), WGPUBindGroupLayout, (WGPUDevice, Ptr{WGPUBindGroupLayoutDescriptor}), device, descriptor)
end

function wgpuDeviceCreateBuffer(device, descriptor)
    ccall((:wgpuDeviceCreateBuffer, libWGPU), WGPUBuffer, (WGPUDevice, Ptr{WGPUBufferDescriptor}), device, descriptor)
end

function wgpuDeviceCreateCommandEncoder(device, descriptor)
    ccall((:wgpuDeviceCreateCommandEncoder, libWGPU), WGPUCommandEncoder, (WGPUDevice, Ptr{WGPUCommandEncoderDescriptor}), device, descriptor)
end

function wgpuDeviceCreateComputePipeline(device, descriptor)
    ccall((:wgpuDeviceCreateComputePipeline, libWGPU), WGPUComputePipeline, (WGPUDevice, Ptr{WGPUComputePipelineDescriptor}), device, descriptor)
end

function wgpuDeviceCreateComputePipelineAsync(device, descriptor, callback, userdata)
    ccall((:wgpuDeviceCreateComputePipelineAsync, libWGPU), Cvoid, (WGPUDevice, Ptr{WGPUComputePipelineDescriptor}, WGPUCreateComputePipelineAsyncCallback, Ptr{Cvoid}), device, descriptor, callback, userdata)
end

function wgpuDeviceCreatePipelineLayout(device, descriptor)
    ccall((:wgpuDeviceCreatePipelineLayout, libWGPU), WGPUPipelineLayout, (WGPUDevice, Ptr{WGPUPipelineLayoutDescriptor}), device, descriptor)
end

function wgpuDeviceCreateQuerySet(device, descriptor)
    ccall((:wgpuDeviceCreateQuerySet, libWGPU), WGPUQuerySet, (WGPUDevice, Ptr{WGPUQuerySetDescriptor}), device, descriptor)
end

function wgpuDeviceCreateRenderBundleEncoder(device, descriptor)
    ccall((:wgpuDeviceCreateRenderBundleEncoder, libWGPU), WGPURenderBundleEncoder, (WGPUDevice, Ptr{WGPURenderBundleEncoderDescriptor}), device, descriptor)
end

function wgpuDeviceCreateRenderPipeline(device, descriptor)
    ccall((:wgpuDeviceCreateRenderPipeline, libWGPU), WGPURenderPipeline, (WGPUDevice, Ptr{WGPURenderPipelineDescriptor}), device, descriptor)
end

function wgpuDeviceCreateRenderPipelineAsync(device, descriptor, callback, userdata)
    ccall((:wgpuDeviceCreateRenderPipelineAsync, libWGPU), Cvoid, (WGPUDevice, Ptr{WGPURenderPipelineDescriptor}, WGPUCreateRenderPipelineAsyncCallback, Ptr{Cvoid}), device, descriptor, callback, userdata)
end

function wgpuDeviceCreateSampler(device, descriptor)
    ccall((:wgpuDeviceCreateSampler, libWGPU), WGPUSampler, (WGPUDevice, Ptr{WGPUSamplerDescriptor}), device, descriptor)
end

function wgpuDeviceCreateShaderModule(device, descriptor)
    ccall((:wgpuDeviceCreateShaderModule, libWGPU), WGPUShaderModule, (WGPUDevice, Ptr{WGPUShaderModuleDescriptor}), device, descriptor)
end

function wgpuDeviceCreateSwapChain(device, surface, descriptor)
    ccall((:wgpuDeviceCreateSwapChain, libWGPU), WGPUSwapChain, (WGPUDevice, WGPUSurface, Ptr{WGPUSwapChainDescriptor}), device, surface, descriptor)
end

function wgpuDeviceCreateTexture(device, descriptor)
    ccall((:wgpuDeviceCreateTexture, libWGPU), WGPUTexture, (WGPUDevice, Ptr{WGPUTextureDescriptor}), device, descriptor)
end

function wgpuDeviceDestroy(device)
    ccall((:wgpuDeviceDestroy, libWGPU), Cvoid, (WGPUDevice,), device)
end

function wgpuDeviceEnumerateFeatures(device, features)
    ccall((:wgpuDeviceEnumerateFeatures, libWGPU), Csize_t, (WGPUDevice, Ptr{WGPUFeatureName}), device, features)
end

function wgpuDeviceGetLimits(device, limits)
    ccall((:wgpuDeviceGetLimits, libWGPU), Bool, (WGPUDevice, Ptr{WGPUSupportedLimits}), device, limits)
end

function wgpuDeviceGetQueue(device)
    ccall((:wgpuDeviceGetQueue, libWGPU), WGPUQueue, (WGPUDevice,), device)
end

function wgpuDeviceHasFeature(device, feature)
    ccall((:wgpuDeviceHasFeature, libWGPU), Bool, (WGPUDevice, WGPUFeatureName), device, feature)
end

function wgpuDevicePopErrorScope(device, callback, userdata)
    ccall((:wgpuDevicePopErrorScope, libWGPU), Cvoid, (WGPUDevice, WGPUErrorCallback, Ptr{Cvoid}), device, callback, userdata)
end

function wgpuDevicePushErrorScope(device, filter)
    ccall((:wgpuDevicePushErrorScope, libWGPU), Cvoid, (WGPUDevice, WGPUErrorFilter), device, filter)
end

function wgpuDeviceSetLabel(device, label)
    ccall((:wgpuDeviceSetLabel, libWGPU), Cvoid, (WGPUDevice, Ptr{Cchar}), device, label)
end

function wgpuDeviceSetUncapturedErrorCallback(device, callback, userdata)
    ccall((:wgpuDeviceSetUncapturedErrorCallback, libWGPU), Cvoid, (WGPUDevice, WGPUErrorCallback, Ptr{Cvoid}), device, callback, userdata)
end

function wgpuDeviceReference(device)
    ccall((:wgpuDeviceReference, libWGPU), Cvoid, (WGPUDevice,), device)
end

function wgpuDeviceRelease(device)
    ccall((:wgpuDeviceRelease, libWGPU), Cvoid, (WGPUDevice,), device)
end

function wgpuInstanceCreateSurface(instance, descriptor)
    ccall((:wgpuInstanceCreateSurface, libWGPU), WGPUSurface, (WGPUInstance, Ptr{WGPUSurfaceDescriptor}), instance, descriptor)
end

function wgpuInstanceProcessEvents(instance)
    ccall((:wgpuInstanceProcessEvents, libWGPU), Cvoid, (WGPUInstance,), instance)
end

function wgpuInstanceRequestAdapter(instance, options, callback, userdata)
    ccall((:wgpuInstanceRequestAdapter, libWGPU), Cvoid, (WGPUInstance, Ptr{WGPURequestAdapterOptions}, WGPURequestAdapterCallback, Ptr{Cvoid}), instance, options, callback, userdata)
end

function wgpuInstanceReference(instance)
    ccall((:wgpuInstanceReference, libWGPU), Cvoid, (WGPUInstance,), instance)
end

function wgpuInstanceRelease(instance)
    ccall((:wgpuInstanceRelease, libWGPU), Cvoid, (WGPUInstance,), instance)
end

function wgpuPipelineLayoutSetLabel(pipelineLayout, label)
    ccall((:wgpuPipelineLayoutSetLabel, libWGPU), Cvoid, (WGPUPipelineLayout, Ptr{Cchar}), pipelineLayout, label)
end

function wgpuPipelineLayoutReference(pipelineLayout)
    ccall((:wgpuPipelineLayoutReference, libWGPU), Cvoid, (WGPUPipelineLayout,), pipelineLayout)
end

function wgpuPipelineLayoutRelease(pipelineLayout)
    ccall((:wgpuPipelineLayoutRelease, libWGPU), Cvoid, (WGPUPipelineLayout,), pipelineLayout)
end

function wgpuQuerySetDestroy(querySet)
    ccall((:wgpuQuerySetDestroy, libWGPU), Cvoid, (WGPUQuerySet,), querySet)
end

function wgpuQuerySetGetCount(querySet)
    ccall((:wgpuQuerySetGetCount, libWGPU), UInt32, (WGPUQuerySet,), querySet)
end

function wgpuQuerySetGetType(querySet)
    ccall((:wgpuQuerySetGetType, libWGPU), WGPUQueryType, (WGPUQuerySet,), querySet)
end

function wgpuQuerySetSetLabel(querySet, label)
    ccall((:wgpuQuerySetSetLabel, libWGPU), Cvoid, (WGPUQuerySet, Ptr{Cchar}), querySet, label)
end

function wgpuQuerySetReference(querySet)
    ccall((:wgpuQuerySetReference, libWGPU), Cvoid, (WGPUQuerySet,), querySet)
end

function wgpuQuerySetRelease(querySet)
    ccall((:wgpuQuerySetRelease, libWGPU), Cvoid, (WGPUQuerySet,), querySet)
end

function wgpuQueueOnSubmittedWorkDone(queue, callback, userdata)
    ccall((:wgpuQueueOnSubmittedWorkDone, libWGPU), Cvoid, (WGPUQueue, WGPUQueueWorkDoneCallback, Ptr{Cvoid}), queue, callback, userdata)
end

function wgpuQueueSetLabel(queue, label)
    ccall((:wgpuQueueSetLabel, libWGPU), Cvoid, (WGPUQueue, Ptr{Cchar}), queue, label)
end

function wgpuQueueSubmit(queue, commandCount, commands)
    ccall((:wgpuQueueSubmit, libWGPU), Cvoid, (WGPUQueue, Csize_t, Ptr{WGPUCommandBuffer}), queue, commandCount, commands)
end

function wgpuQueueWriteBuffer(queue, buffer, bufferOffset, data, size)
    ccall((:wgpuQueueWriteBuffer, libWGPU), Cvoid, (WGPUQueue, WGPUBuffer, UInt64, Ptr{Cvoid}, Csize_t), queue, buffer, bufferOffset, data, size)
end

function wgpuQueueWriteTexture(queue, destination, data, dataSize, dataLayout, writeSize)
    ccall((:wgpuQueueWriteTexture, libWGPU), Cvoid, (WGPUQueue, Ptr{WGPUImageCopyTexture}, Ptr{Cvoid}, Csize_t, Ptr{WGPUTextureDataLayout}, Ptr{WGPUExtent3D}), queue, destination, data, dataSize, dataLayout, writeSize)
end

function wgpuQueueReference(queue)
    ccall((:wgpuQueueReference, libWGPU), Cvoid, (WGPUQueue,), queue)
end

function wgpuQueueRelease(queue)
    ccall((:wgpuQueueRelease, libWGPU), Cvoid, (WGPUQueue,), queue)
end

function wgpuRenderBundleSetLabel(renderBundle, label)
    ccall((:wgpuRenderBundleSetLabel, libWGPU), Cvoid, (WGPURenderBundle, Ptr{Cchar}), renderBundle, label)
end

function wgpuRenderBundleReference(renderBundle)
    ccall((:wgpuRenderBundleReference, libWGPU), Cvoid, (WGPURenderBundle,), renderBundle)
end

function wgpuRenderBundleRelease(renderBundle)
    ccall((:wgpuRenderBundleRelease, libWGPU), Cvoid, (WGPURenderBundle,), renderBundle)
end

function wgpuRenderBundleEncoderDraw(renderBundleEncoder, vertexCount, instanceCount, firstVertex, firstInstance)
    ccall((:wgpuRenderBundleEncoderDraw, libWGPU), Cvoid, (WGPURenderBundleEncoder, UInt32, UInt32, UInt32, UInt32), renderBundleEncoder, vertexCount, instanceCount, firstVertex, firstInstance)
end

function wgpuRenderBundleEncoderDrawIndexed(renderBundleEncoder, indexCount, instanceCount, firstIndex, baseVertex, firstInstance)
    ccall((:wgpuRenderBundleEncoderDrawIndexed, libWGPU), Cvoid, (WGPURenderBundleEncoder, UInt32, UInt32, UInt32, Int32, UInt32), renderBundleEncoder, indexCount, instanceCount, firstIndex, baseVertex, firstInstance)
end

function wgpuRenderBundleEncoderDrawIndexedIndirect(renderBundleEncoder, indirectBuffer, indirectOffset)
    ccall((:wgpuRenderBundleEncoderDrawIndexedIndirect, libWGPU), Cvoid, (WGPURenderBundleEncoder, WGPUBuffer, UInt64), renderBundleEncoder, indirectBuffer, indirectOffset)
end

function wgpuRenderBundleEncoderDrawIndirect(renderBundleEncoder, indirectBuffer, indirectOffset)
    ccall((:wgpuRenderBundleEncoderDrawIndirect, libWGPU), Cvoid, (WGPURenderBundleEncoder, WGPUBuffer, UInt64), renderBundleEncoder, indirectBuffer, indirectOffset)
end

function wgpuRenderBundleEncoderFinish(renderBundleEncoder, descriptor)
    ccall((:wgpuRenderBundleEncoderFinish, libWGPU), WGPURenderBundle, (WGPURenderBundleEncoder, Ptr{WGPURenderBundleDescriptor}), renderBundleEncoder, descriptor)
end

function wgpuRenderBundleEncoderInsertDebugMarker(renderBundleEncoder, markerLabel)
    ccall((:wgpuRenderBundleEncoderInsertDebugMarker, libWGPU), Cvoid, (WGPURenderBundleEncoder, Ptr{Cchar}), renderBundleEncoder, markerLabel)
end

function wgpuRenderBundleEncoderPopDebugGroup(renderBundleEncoder)
    ccall((:wgpuRenderBundleEncoderPopDebugGroup, libWGPU), Cvoid, (WGPURenderBundleEncoder,), renderBundleEncoder)
end

function wgpuRenderBundleEncoderPushDebugGroup(renderBundleEncoder, groupLabel)
    ccall((:wgpuRenderBundleEncoderPushDebugGroup, libWGPU), Cvoid, (WGPURenderBundleEncoder, Ptr{Cchar}), renderBundleEncoder, groupLabel)
end

function wgpuRenderBundleEncoderSetBindGroup(renderBundleEncoder, groupIndex, group, dynamicOffsetCount, dynamicOffsets)
    ccall((:wgpuRenderBundleEncoderSetBindGroup, libWGPU), Cvoid, (WGPURenderBundleEncoder, UInt32, WGPUBindGroup, Csize_t, Ptr{UInt32}), renderBundleEncoder, groupIndex, group, dynamicOffsetCount, dynamicOffsets)
end

function wgpuRenderBundleEncoderSetIndexBuffer(renderBundleEncoder, buffer, format, offset, size)
    ccall((:wgpuRenderBundleEncoderSetIndexBuffer, libWGPU), Cvoid, (WGPURenderBundleEncoder, WGPUBuffer, WGPUIndexFormat, UInt64, UInt64), renderBundleEncoder, buffer, format, offset, size)
end

function wgpuRenderBundleEncoderSetLabel(renderBundleEncoder, label)
    ccall((:wgpuRenderBundleEncoderSetLabel, libWGPU), Cvoid, (WGPURenderBundleEncoder, Ptr{Cchar}), renderBundleEncoder, label)
end

function wgpuRenderBundleEncoderSetPipeline(renderBundleEncoder, pipeline)
    ccall((:wgpuRenderBundleEncoderSetPipeline, libWGPU), Cvoid, (WGPURenderBundleEncoder, WGPURenderPipeline), renderBundleEncoder, pipeline)
end

function wgpuRenderBundleEncoderSetVertexBuffer(renderBundleEncoder, slot, buffer, offset, size)
    ccall((:wgpuRenderBundleEncoderSetVertexBuffer, libWGPU), Cvoid, (WGPURenderBundleEncoder, UInt32, WGPUBuffer, UInt64, UInt64), renderBundleEncoder, slot, buffer, offset, size)
end

function wgpuRenderBundleEncoderReference(renderBundleEncoder)
    ccall((:wgpuRenderBundleEncoderReference, libWGPU), Cvoid, (WGPURenderBundleEncoder,), renderBundleEncoder)
end

function wgpuRenderBundleEncoderRelease(renderBundleEncoder)
    ccall((:wgpuRenderBundleEncoderRelease, libWGPU), Cvoid, (WGPURenderBundleEncoder,), renderBundleEncoder)
end

function wgpuRenderPassEncoderBeginOcclusionQuery(renderPassEncoder, queryIndex)
    ccall((:wgpuRenderPassEncoderBeginOcclusionQuery, libWGPU), Cvoid, (WGPURenderPassEncoder, UInt32), renderPassEncoder, queryIndex)
end

function wgpuRenderPassEncoderBeginPipelineStatisticsQuery(renderPassEncoder, querySet, queryIndex)
    ccall((:wgpuRenderPassEncoderBeginPipelineStatisticsQuery, libWGPU), Cvoid, (WGPURenderPassEncoder, WGPUQuerySet, UInt32), renderPassEncoder, querySet, queryIndex)
end

function wgpuRenderPassEncoderDraw(renderPassEncoder, vertexCount, instanceCount, firstVertex, firstInstance)
    ccall((:wgpuRenderPassEncoderDraw, libWGPU), Cvoid, (WGPURenderPassEncoder, UInt32, UInt32, UInt32, UInt32), renderPassEncoder, vertexCount, instanceCount, firstVertex, firstInstance)
end

function wgpuRenderPassEncoderDrawIndexed(renderPassEncoder, indexCount, instanceCount, firstIndex, baseVertex, firstInstance)
    ccall((:wgpuRenderPassEncoderDrawIndexed, libWGPU), Cvoid, (WGPURenderPassEncoder, UInt32, UInt32, UInt32, Int32, UInt32), renderPassEncoder, indexCount, instanceCount, firstIndex, baseVertex, firstInstance)
end

function wgpuRenderPassEncoderDrawIndexedIndirect(renderPassEncoder, indirectBuffer, indirectOffset)
    ccall((:wgpuRenderPassEncoderDrawIndexedIndirect, libWGPU), Cvoid, (WGPURenderPassEncoder, WGPUBuffer, UInt64), renderPassEncoder, indirectBuffer, indirectOffset)
end

function wgpuRenderPassEncoderDrawIndirect(renderPassEncoder, indirectBuffer, indirectOffset)
    ccall((:wgpuRenderPassEncoderDrawIndirect, libWGPU), Cvoid, (WGPURenderPassEncoder, WGPUBuffer, UInt64), renderPassEncoder, indirectBuffer, indirectOffset)
end

function wgpuRenderPassEncoderEnd(renderPassEncoder)
    ccall((:wgpuRenderPassEncoderEnd, libWGPU), Cvoid, (WGPURenderPassEncoder,), renderPassEncoder)
end

function wgpuRenderPassEncoderEndOcclusionQuery(renderPassEncoder)
    ccall((:wgpuRenderPassEncoderEndOcclusionQuery, libWGPU), Cvoid, (WGPURenderPassEncoder,), renderPassEncoder)
end

function wgpuRenderPassEncoderEndPipelineStatisticsQuery(renderPassEncoder)
    ccall((:wgpuRenderPassEncoderEndPipelineStatisticsQuery, libWGPU), Cvoid, (WGPURenderPassEncoder,), renderPassEncoder)
end

function wgpuRenderPassEncoderExecuteBundles(renderPassEncoder, bundleCount, bundles)
    ccall((:wgpuRenderPassEncoderExecuteBundles, libWGPU), Cvoid, (WGPURenderPassEncoder, Csize_t, Ptr{WGPURenderBundle}), renderPassEncoder, bundleCount, bundles)
end

function wgpuRenderPassEncoderInsertDebugMarker(renderPassEncoder, markerLabel)
    ccall((:wgpuRenderPassEncoderInsertDebugMarker, libWGPU), Cvoid, (WGPURenderPassEncoder, Ptr{Cchar}), renderPassEncoder, markerLabel)
end

function wgpuRenderPassEncoderPopDebugGroup(renderPassEncoder)
    ccall((:wgpuRenderPassEncoderPopDebugGroup, libWGPU), Cvoid, (WGPURenderPassEncoder,), renderPassEncoder)
end

function wgpuRenderPassEncoderPushDebugGroup(renderPassEncoder, groupLabel)
    ccall((:wgpuRenderPassEncoderPushDebugGroup, libWGPU), Cvoid, (WGPURenderPassEncoder, Ptr{Cchar}), renderPassEncoder, groupLabel)
end

function wgpuRenderPassEncoderSetBindGroup(renderPassEncoder, groupIndex, group, dynamicOffsetCount, dynamicOffsets)
    ccall((:wgpuRenderPassEncoderSetBindGroup, libWGPU), Cvoid, (WGPURenderPassEncoder, UInt32, WGPUBindGroup, Csize_t, Ptr{UInt32}), renderPassEncoder, groupIndex, group, dynamicOffsetCount, dynamicOffsets)
end

function wgpuRenderPassEncoderSetBlendConstant(renderPassEncoder, color)
    ccall((:wgpuRenderPassEncoderSetBlendConstant, libWGPU), Cvoid, (WGPURenderPassEncoder, Ptr{WGPUColor}), renderPassEncoder, color)
end

function wgpuRenderPassEncoderSetIndexBuffer(renderPassEncoder, buffer, format, offset, size)
    ccall((:wgpuRenderPassEncoderSetIndexBuffer, libWGPU), Cvoid, (WGPURenderPassEncoder, WGPUBuffer, WGPUIndexFormat, UInt64, UInt64), renderPassEncoder, buffer, format, offset, size)
end

function wgpuRenderPassEncoderSetLabel(renderPassEncoder, label)
    ccall((:wgpuRenderPassEncoderSetLabel, libWGPU), Cvoid, (WGPURenderPassEncoder, Ptr{Cchar}), renderPassEncoder, label)
end

function wgpuRenderPassEncoderSetPipeline(renderPassEncoder, pipeline)
    ccall((:wgpuRenderPassEncoderSetPipeline, libWGPU), Cvoid, (WGPURenderPassEncoder, WGPURenderPipeline), renderPassEncoder, pipeline)
end

function wgpuRenderPassEncoderSetScissorRect(renderPassEncoder, x, y, width, height)
    ccall((:wgpuRenderPassEncoderSetScissorRect, libWGPU), Cvoid, (WGPURenderPassEncoder, UInt32, UInt32, UInt32, UInt32), renderPassEncoder, x, y, width, height)
end

function wgpuRenderPassEncoderSetStencilReference(renderPassEncoder, reference)
    ccall((:wgpuRenderPassEncoderSetStencilReference, libWGPU), Cvoid, (WGPURenderPassEncoder, UInt32), renderPassEncoder, reference)
end

function wgpuRenderPassEncoderSetVertexBuffer(renderPassEncoder, slot, buffer, offset, size)
    ccall((:wgpuRenderPassEncoderSetVertexBuffer, libWGPU), Cvoid, (WGPURenderPassEncoder, UInt32, WGPUBuffer, UInt64, UInt64), renderPassEncoder, slot, buffer, offset, size)
end

function wgpuRenderPassEncoderSetViewport(renderPassEncoder, x, y, width, height, minDepth, maxDepth)
    ccall((:wgpuRenderPassEncoderSetViewport, libWGPU), Cvoid, (WGPURenderPassEncoder, Cfloat, Cfloat, Cfloat, Cfloat, Cfloat, Cfloat), renderPassEncoder, x, y, width, height, minDepth, maxDepth)
end

function wgpuRenderPassEncoderReference(renderPassEncoder)
    ccall((:wgpuRenderPassEncoderReference, libWGPU), Cvoid, (WGPURenderPassEncoder,), renderPassEncoder)
end

function wgpuRenderPassEncoderRelease(renderPassEncoder)
    ccall((:wgpuRenderPassEncoderRelease, libWGPU), Cvoid, (WGPURenderPassEncoder,), renderPassEncoder)
end

function wgpuRenderPipelineGetBindGroupLayout(renderPipeline, groupIndex)
    ccall((:wgpuRenderPipelineGetBindGroupLayout, libWGPU), WGPUBindGroupLayout, (WGPURenderPipeline, UInt32), renderPipeline, groupIndex)
end

function wgpuRenderPipelineSetLabel(renderPipeline, label)
    ccall((:wgpuRenderPipelineSetLabel, libWGPU), Cvoid, (WGPURenderPipeline, Ptr{Cchar}), renderPipeline, label)
end

function wgpuRenderPipelineReference(renderPipeline)
    ccall((:wgpuRenderPipelineReference, libWGPU), Cvoid, (WGPURenderPipeline,), renderPipeline)
end

function wgpuRenderPipelineRelease(renderPipeline)
    ccall((:wgpuRenderPipelineRelease, libWGPU), Cvoid, (WGPURenderPipeline,), renderPipeline)
end

function wgpuSamplerSetLabel(sampler, label)
    ccall((:wgpuSamplerSetLabel, libWGPU), Cvoid, (WGPUSampler, Ptr{Cchar}), sampler, label)
end

function wgpuSamplerReference(sampler)
    ccall((:wgpuSamplerReference, libWGPU), Cvoid, (WGPUSampler,), sampler)
end

function wgpuSamplerRelease(sampler)
    ccall((:wgpuSamplerRelease, libWGPU), Cvoid, (WGPUSampler,), sampler)
end

function wgpuShaderModuleGetCompilationInfo(shaderModule, callback, userdata)
    ccall((:wgpuShaderModuleGetCompilationInfo, libWGPU), Cvoid, (WGPUShaderModule, WGPUCompilationInfoCallback, Ptr{Cvoid}), shaderModule, callback, userdata)
end

function wgpuShaderModuleSetLabel(shaderModule, label)
    ccall((:wgpuShaderModuleSetLabel, libWGPU), Cvoid, (WGPUShaderModule, Ptr{Cchar}), shaderModule, label)
end

function wgpuShaderModuleReference(shaderModule)
    ccall((:wgpuShaderModuleReference, libWGPU), Cvoid, (WGPUShaderModule,), shaderModule)
end

function wgpuShaderModuleRelease(shaderModule)
    ccall((:wgpuShaderModuleRelease, libWGPU), Cvoid, (WGPUShaderModule,), shaderModule)
end

function wgpuSurfaceGetPreferredFormat(surface, adapter)
    ccall((:wgpuSurfaceGetPreferredFormat, libWGPU), WGPUTextureFormat, (WGPUSurface, WGPUAdapter), surface, adapter)
end

function wgpuSurfaceReference(surface)
    ccall((:wgpuSurfaceReference, libWGPU), Cvoid, (WGPUSurface,), surface)
end

function wgpuSurfaceRelease(surface)
    ccall((:wgpuSurfaceRelease, libWGPU), Cvoid, (WGPUSurface,), surface)
end

function wgpuSwapChainGetCurrentTextureView(swapChain)
    ccall((:wgpuSwapChainGetCurrentTextureView, libWGPU), WGPUTextureView, (WGPUSwapChain,), swapChain)
end

function wgpuSwapChainPresent(swapChain)
    ccall((:wgpuSwapChainPresent, libWGPU), Cvoid, (WGPUSwapChain,), swapChain)
end

function wgpuSwapChainReference(swapChain)
    ccall((:wgpuSwapChainReference, libWGPU), Cvoid, (WGPUSwapChain,), swapChain)
end

function wgpuSwapChainRelease(swapChain)
    ccall((:wgpuSwapChainRelease, libWGPU), Cvoid, (WGPUSwapChain,), swapChain)
end

function wgpuTextureCreateView(texture, descriptor)
    ccall((:wgpuTextureCreateView, libWGPU), WGPUTextureView, (WGPUTexture, Ptr{WGPUTextureViewDescriptor}), texture, descriptor)
end

function wgpuTextureDestroy(texture)
    ccall((:wgpuTextureDestroy, libWGPU), Cvoid, (WGPUTexture,), texture)
end

function wgpuTextureGetDepthOrArrayLayers(texture)
    ccall((:wgpuTextureGetDepthOrArrayLayers, libWGPU), UInt32, (WGPUTexture,), texture)
end

function wgpuTextureGetDimension(texture)
    ccall((:wgpuTextureGetDimension, libWGPU), WGPUTextureDimension, (WGPUTexture,), texture)
end

function wgpuTextureGetFormat(texture)
    ccall((:wgpuTextureGetFormat, libWGPU), WGPUTextureFormat, (WGPUTexture,), texture)
end

function wgpuTextureGetHeight(texture)
    ccall((:wgpuTextureGetHeight, libWGPU), UInt32, (WGPUTexture,), texture)
end

function wgpuTextureGetMipLevelCount(texture)
    ccall((:wgpuTextureGetMipLevelCount, libWGPU), UInt32, (WGPUTexture,), texture)
end

function wgpuTextureGetSampleCount(texture)
    ccall((:wgpuTextureGetSampleCount, libWGPU), UInt32, (WGPUTexture,), texture)
end

function wgpuTextureGetUsage(texture)
    ccall((:wgpuTextureGetUsage, libWGPU), WGPUTextureUsageFlags, (WGPUTexture,), texture)
end

function wgpuTextureGetWidth(texture)
    ccall((:wgpuTextureGetWidth, libWGPU), UInt32, (WGPUTexture,), texture)
end

function wgpuTextureSetLabel(texture, label)
    ccall((:wgpuTextureSetLabel, libWGPU), Cvoid, (WGPUTexture, Ptr{Cchar}), texture, label)
end

function wgpuTextureReference(texture)
    ccall((:wgpuTextureReference, libWGPU), Cvoid, (WGPUTexture,), texture)
end

function wgpuTextureRelease(texture)
    ccall((:wgpuTextureRelease, libWGPU), Cvoid, (WGPUTexture,), texture)
end

function wgpuTextureViewSetLabel(textureView, label)
    ccall((:wgpuTextureViewSetLabel, libWGPU), Cvoid, (WGPUTextureView, Ptr{Cchar}), textureView, label)
end

function wgpuTextureViewReference(textureView)
    ccall((:wgpuTextureViewReference, libWGPU), Cvoid, (WGPUTextureView,), textureView)
end

function wgpuTextureViewRelease(textureView)
    ccall((:wgpuTextureViewRelease, libWGPU), Cvoid, (WGPUTextureView,), textureView)
end

@cenum WGPUNativeSType::UInt32 begin
    WGPUSType_DeviceExtras = 1610612737
    WGPUSType_AdapterExtras = 1610612738
    WGPUSType_RequiredLimitsExtras = 1610612739
    WGPUSType_PipelineLayoutExtras = 1610612740
    WGPUSType_ShaderModuleGLSLDescriptor = 1610612741
    WGPUSType_SupportedLimitsExtras = 1610612739
    WGPUSType_InstanceExtras = 1610612742
    WGPUSType_SwapChainDescriptorExtras = 1610612743
    WGPUNativeSType_Force32 = 2147483647
end

@cenum WGPUNativeFeature::UInt32 begin
    WGPUNativeFeature_PushConstants = 1610612737
    WGPUNativeFeature_TextureAdapterSpecificFormatFeatures = 1610612738
    WGPUNativeFeature_MultiDrawIndirect = 1610612739
    WGPUNativeFeature_MultiDrawIndirectCount = 1610612740
    WGPUNativeFeature_VertexWritableStorage = 1610612741
    WGPUNativeFeature_Force32 = 2147483647
end

@cenum WGPULogLevel::UInt32 begin
    WGPULogLevel_Off = 0
    WGPULogLevel_Error = 1
    WGPULogLevel_Warn = 2
    WGPULogLevel_Info = 3
    WGPULogLevel_Debug = 4
    WGPULogLevel_Trace = 5
    WGPULogLevel_Force32 = 2147483647
end

@cenum WGPUInstanceBackend::UInt32 begin
    WGPUInstanceBackend_Vulkan = 2
    WGPUInstanceBackend_GL = 32
    WGPUInstanceBackend_Metal = 4
    WGPUInstanceBackend_DX12 = 8
    WGPUInstanceBackend_DX11 = 16
    WGPUInstanceBackend_BrowserWebGPU = 64
    WGPUInstanceBackend_Primary = 78
    WGPUInstanceBackend_Secondary = 48
    WGPUInstanceBackend_None = 0
    WGPUInstanceBackend_Force32 = 2147483647
end

const WGPUInstanceBackendFlags = WGPUFlags

@cenum WGPUDx12Compiler::UInt32 begin
    WGPUDx12Compiler_Undefined = 0
    WGPUDx12Compiler_Fxc = 1
    WGPUDx12Compiler_Dxc = 2
    WGPUDx12Compiler_Force32 = 2147483647
end

@cenum WGPUCompositeAlphaMode::UInt32 begin
    WGPUCompositeAlphaMode_Auto = 0
    WGPUCompositeAlphaMode_Opaque = 1
    WGPUCompositeAlphaMode_PreMultiplied = 2
    WGPUCompositeAlphaMode_PostMultiplied = 3
    WGPUCompositeAlphaMode_Inherit = 4
    WGPUCompositeAlphaMode_Force32 = 2147483647
end

struct WGPUInstanceExtras
    chain::WGPUChainedStruct
    backends::WGPUInstanceBackendFlags
    dx12ShaderCompiler::WGPUDx12Compiler
    dxilPath::Ptr{Cchar}
    dxcPath::Ptr{Cchar}
end

struct WGPUDeviceExtras
    chain::WGPUChainedStruct
    tracePath::Ptr{Cchar}
end

struct WGPURequiredLimitsExtras
    chain::WGPUChainedStruct
    maxPushConstantSize::UInt32
end

struct WGPUSupportedLimitsExtras
    chain::WGPUChainedStructOut
    maxPushConstantSize::UInt32
end

struct WGPUPushConstantRange
    stages::WGPUShaderStageFlags
    start::UInt32
    _end::UInt32
end

struct WGPUPipelineLayoutExtras
    chain::WGPUChainedStruct
    pushConstantRangeCount::UInt32
    pushConstantRanges::Ptr{WGPUPushConstantRange}
end

const WGPUSubmissionIndex = UInt64

struct WGPUWrappedSubmissionIndex
    queue::WGPUQueue
    submissionIndex::WGPUSubmissionIndex
end

struct WGPUShaderDefine
    name::Ptr{Cchar}
    value::Ptr{Cchar}
end

struct WGPUShaderModuleGLSLDescriptor
    chain::WGPUChainedStruct
    stage::WGPUShaderStage
    code::Ptr{Cchar}
    defineCount::UInt32
    defines::Ptr{WGPUShaderDefine}
end

struct WGPUStorageReport
    numOccupied::Csize_t
    numVacant::Csize_t
    numError::Csize_t
    elementSize::Csize_t
end

struct WGPUHubReport
    adapters::WGPUStorageReport
    devices::WGPUStorageReport
    pipelineLayouts::WGPUStorageReport
    shaderModules::WGPUStorageReport
    bindGroupLayouts::WGPUStorageReport
    bindGroups::WGPUStorageReport
    commandBuffers::WGPUStorageReport
    renderBundles::WGPUStorageReport
    renderPipelines::WGPUStorageReport
    computePipelines::WGPUStorageReport
    querySets::WGPUStorageReport
    buffers::WGPUStorageReport
    textures::WGPUStorageReport
    textureViews::WGPUStorageReport
    samplers::WGPUStorageReport
end

struct WGPUGlobalReport
    surfaces::WGPUStorageReport
    backendType::WGPUBackendType
    vulkan::WGPUHubReport
    metal::WGPUHubReport
    dx12::WGPUHubReport
    dx11::WGPUHubReport
    gl::WGPUHubReport
end

struct WGPUSurfaceCapabilities
    formatCount::Csize_t
    formats::Ptr{WGPUTextureFormat}
    presentModeCount::Csize_t
    presentModes::Ptr{WGPUPresentMode}
    alphaModeCount::Csize_t
    alphaModes::Ptr{WGPUCompositeAlphaMode}
end

struct WGPUSwapChainDescriptorExtras
    chain::WGPUChainedStruct
    alphaMode::WGPUCompositeAlphaMode
    viewFormatCount::Csize_t
    viewFormats::Ptr{WGPUTextureFormat}
end

struct WGPUInstanceEnumerateAdapterOptions
    nextInChain::Ptr{WGPUChainedStruct}
    backends::WGPUInstanceBackendFlags
end

# typedef void ( * WGPULogCallback ) ( WGPULogLevel level , char const * message , void * userdata )
const WGPULogCallback = Ptr{Cvoid}

function wgpuGenerateReport(instance, report)
    ccall((:wgpuGenerateReport, libWGPU), Cvoid, (WGPUInstance, Ptr{WGPUGlobalReport}), instance, report)
end

function wgpuInstanceEnumerateAdapters(instance, options, adapters)
    ccall((:wgpuInstanceEnumerateAdapters, libWGPU), Csize_t, (WGPUInstance, Ptr{WGPUInstanceEnumerateAdapterOptions}, Ptr{WGPUAdapter}), instance, options, adapters)
end

function wgpuQueueSubmitForIndex(queue, commandCount, commands)
    ccall((:wgpuQueueSubmitForIndex, libWGPU), WGPUSubmissionIndex, (WGPUQueue, Csize_t, Ptr{WGPUCommandBuffer}), queue, commandCount, commands)
end

function wgpuDevicePoll(device, wait, wrappedSubmissionIndex)
    ccall((:wgpuDevicePoll, libWGPU), Bool, (WGPUDevice, Bool, Ptr{WGPUWrappedSubmissionIndex}), device, wait, wrappedSubmissionIndex)
end

function wgpuSetLogCallback(callback, userdata)
    ccall((:wgpuSetLogCallback, libWGPU), Cvoid, (WGPULogCallback, Ptr{Cvoid}), callback, userdata)
end

function wgpuSetLogLevel(level)
    ccall((:wgpuSetLogLevel, libWGPU), Cvoid, (WGPULogLevel,), level)
end

function wgpuGetVersion()
    ccall((:wgpuGetVersion, libWGPU), UInt32, ())
end

function wgpuSurfaceGetCapabilities(surface, adapter, capabilities)
    ccall((:wgpuSurfaceGetCapabilities, libWGPU), Cvoid, (WGPUSurface, WGPUAdapter, Ptr{WGPUSurfaceCapabilities}), surface, adapter, capabilities)
end

function wgpuRenderPassEncoderSetPushConstants(encoder, stages, offset, sizeBytes, data)
    ccall((:wgpuRenderPassEncoderSetPushConstants, libWGPU), Cvoid, (WGPURenderPassEncoder, WGPUShaderStageFlags, UInt32, UInt32, Ptr{Cvoid}), encoder, stages, offset, sizeBytes, data)
end

function wgpuRenderPassEncoderMultiDrawIndirect(encoder, buffer, offset, count)
    ccall((:wgpuRenderPassEncoderMultiDrawIndirect, libWGPU), Cvoid, (WGPURenderPassEncoder, WGPUBuffer, UInt64, UInt32), encoder, buffer, offset, count)
end

function wgpuRenderPassEncoderMultiDrawIndexedIndirect(encoder, buffer, offset, count)
    ccall((:wgpuRenderPassEncoderMultiDrawIndexedIndirect, libWGPU), Cvoid, (WGPURenderPassEncoder, WGPUBuffer, UInt64, UInt32), encoder, buffer, offset, count)
end

function wgpuRenderPassEncoderMultiDrawIndirectCount(encoder, buffer, offset, count_buffer, count_buffer_offset, max_count)
    ccall((:wgpuRenderPassEncoderMultiDrawIndirectCount, libWGPU), Cvoid, (WGPURenderPassEncoder, WGPUBuffer, UInt64, WGPUBuffer, UInt64, UInt32), encoder, buffer, offset, count_buffer, count_buffer_offset, max_count)
end

function wgpuRenderPassEncoderMultiDrawIndexedIndirectCount(encoder, buffer, offset, count_buffer, count_buffer_offset, max_count)
    ccall((:wgpuRenderPassEncoderMultiDrawIndexedIndirectCount, libWGPU), Cvoid, (WGPURenderPassEncoder, WGPUBuffer, UInt64, WGPUBuffer, UInt64, UInt32), encoder, buffer, offset, count_buffer, count_buffer_offset, max_count)
end

const WGPU_ARRAY_LAYER_COUNT_UNDEFINED = Culong(0xffffffff)

const WGPU_COPY_STRIDE_UNDEFINED = Culong(0xffffffff)

const WGPU_LIMIT_U32_UNDEFINED = Culong(0xffffffff)

const WGPU_LIMIT_U64_UNDEFINED = Culonglong(0xffffffffffffffff)

const WGPU_MIP_LEVEL_COUNT_UNDEFINED = Culong(0xffffffff)

const WGPU_WHOLE_MAP_SIZE = SIZE_MAX

const WGPU_WHOLE_SIZE = Culonglong(0xffffffffffffffff)

# exports
const PREFIXES = ["WGPU", "wgpu"]
for name in names(@__MODULE__; all=true), prefix in PREFIXES
    if startswith(string(name), prefix)
        @eval export $name
    end
end

end # module
