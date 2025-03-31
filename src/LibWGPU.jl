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
const libWGPU = "$wgpulibpath/lib/$resourceName.$(Libdl.dlext)" |> normpath



struct WGPUStringView
    data::Ptr{Cchar}
    length::Csize_t
end

const WGPUFlags = UInt64

const WGPUBool = UInt32

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

mutable struct WGPUTextureImpl end

const WGPUTexture = Ptr{WGPUTextureImpl}

mutable struct WGPUTextureViewImpl end

const WGPUTextureView = Ptr{WGPUTextureViewImpl}

@cenum WGPUAdapterType::UInt32 begin
    WGPUAdapterType_DiscreteGPU = 1
    WGPUAdapterType_IntegratedGPU = 2
    WGPUAdapterType_CPU = 3
    WGPUAdapterType_Unknown = 4
    WGPUAdapterType_Force32 = 2147483647
end

@cenum WGPUAddressMode::UInt32 begin
    WGPUAddressMode_Undefined = 0
    WGPUAddressMode_ClampToEdge = 1
    WGPUAddressMode_Repeat = 2
    WGPUAddressMode_MirrorRepeat = 3
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
    WGPUBlendFactor_Undefined = 0
    WGPUBlendFactor_Zero = 1
    WGPUBlendFactor_One = 2
    WGPUBlendFactor_Src = 3
    WGPUBlendFactor_OneMinusSrc = 4
    WGPUBlendFactor_SrcAlpha = 5
    WGPUBlendFactor_OneMinusSrcAlpha = 6
    WGPUBlendFactor_Dst = 7
    WGPUBlendFactor_OneMinusDst = 8
    WGPUBlendFactor_DstAlpha = 9
    WGPUBlendFactor_OneMinusDstAlpha = 10
    WGPUBlendFactor_SrcAlphaSaturated = 11
    WGPUBlendFactor_Constant = 12
    WGPUBlendFactor_OneMinusConstant = 13
    WGPUBlendFactor_Src1 = 14
    WGPUBlendFactor_OneMinusSrc1 = 15
    WGPUBlendFactor_Src1Alpha = 16
    WGPUBlendFactor_OneMinusSrc1Alpha = 17
    WGPUBlendFactor_Force32 = 2147483647
end

@cenum WGPUBlendOperation::UInt32 begin
    WGPUBlendOperation_Undefined = 0
    WGPUBlendOperation_Add = 1
    WGPUBlendOperation_Subtract = 2
    WGPUBlendOperation_ReverseSubtract = 3
    WGPUBlendOperation_Min = 4
    WGPUBlendOperation_Max = 5
    WGPUBlendOperation_Force32 = 2147483647
end

@cenum WGPUBufferBindingType::UInt32 begin
    WGPUBufferBindingType_BindingNotUsed = 0
    WGPUBufferBindingType_Undefined = 1
    WGPUBufferBindingType_Uniform = 2
    WGPUBufferBindingType_Storage = 3
    WGPUBufferBindingType_ReadOnlyStorage = 4
    WGPUBufferBindingType_Force32 = 2147483647
end

@cenum WGPUBufferMapState::UInt32 begin
    WGPUBufferMapState_Unmapped = 1
    WGPUBufferMapState_Pending = 2
    WGPUBufferMapState_Mapped = 3
    WGPUBufferMapState_Force32 = 2147483647
end

@cenum WGPUCallbackMode::UInt32 begin
    WGPUCallbackMode_WaitAnyOnly = 1
    WGPUCallbackMode_AllowProcessEvents = 2
    WGPUCallbackMode_AllowSpontaneous = 3
    WGPUCallbackMode_Force32 = 2147483647
end

@cenum WGPUCompareFunction::UInt32 begin
    WGPUCompareFunction_Undefined = 0
    WGPUCompareFunction_Never = 1
    WGPUCompareFunction_Less = 2
    WGPUCompareFunction_Equal = 3
    WGPUCompareFunction_LessEqual = 4
    WGPUCompareFunction_Greater = 5
    WGPUCompareFunction_NotEqual = 6
    WGPUCompareFunction_GreaterEqual = 7
    WGPUCompareFunction_Always = 8
    WGPUCompareFunction_Force32 = 2147483647
end

@cenum WGPUCompilationInfoRequestStatus::UInt32 begin
    WGPUCompilationInfoRequestStatus_Success = 1
    WGPUCompilationInfoRequestStatus_InstanceDropped = 2
    WGPUCompilationInfoRequestStatus_Error = 3
    WGPUCompilationInfoRequestStatus_Unknown = 4
    WGPUCompilationInfoRequestStatus_Force32 = 2147483647
end

@cenum WGPUCompilationMessageType::UInt32 begin
    WGPUCompilationMessageType_Error = 1
    WGPUCompilationMessageType_Warning = 2
    WGPUCompilationMessageType_Info = 3
    WGPUCompilationMessageType_Force32 = 2147483647
end

@cenum WGPUCompositeAlphaMode::UInt32 begin
    WGPUCompositeAlphaMode_Auto = 0
    WGPUCompositeAlphaMode_Opaque = 1
    WGPUCompositeAlphaMode_Premultiplied = 2
    WGPUCompositeAlphaMode_Unpremultiplied = 3
    WGPUCompositeAlphaMode_Inherit = 4
    WGPUCompositeAlphaMode_Force32 = 2147483647
end

@cenum WGPUCreatePipelineAsyncStatus::UInt32 begin
    WGPUCreatePipelineAsyncStatus_Success = 1
    WGPUCreatePipelineAsyncStatus_InstanceDropped = 2
    WGPUCreatePipelineAsyncStatus_ValidationError = 3
    WGPUCreatePipelineAsyncStatus_InternalError = 4
    WGPUCreatePipelineAsyncStatus_Unknown = 5
    WGPUCreatePipelineAsyncStatus_Force32 = 2147483647
end

@cenum WGPUCullMode::UInt32 begin
    WGPUCullMode_Undefined = 0
    WGPUCullMode_None = 1
    WGPUCullMode_Front = 2
    WGPUCullMode_Back = 3
    WGPUCullMode_Force32 = 2147483647
end

@cenum WGPUDeviceLostReason::UInt32 begin
    WGPUDeviceLostReason_Unknown = 1
    WGPUDeviceLostReason_Destroyed = 2
    WGPUDeviceLostReason_InstanceDropped = 3
    WGPUDeviceLostReason_FailedCreation = 4
    WGPUDeviceLostReason_Force32 = 2147483647
end

@cenum WGPUErrorFilter::UInt32 begin
    WGPUErrorFilter_Validation = 1
    WGPUErrorFilter_OutOfMemory = 2
    WGPUErrorFilter_Internal = 3
    WGPUErrorFilter_Force32 = 2147483647
end

@cenum WGPUErrorType::UInt32 begin
    WGPUErrorType_NoError = 1
    WGPUErrorType_Validation = 2
    WGPUErrorType_OutOfMemory = 3
    WGPUErrorType_Internal = 4
    WGPUErrorType_Unknown = 5
    WGPUErrorType_Force32 = 2147483647
end

@cenum WGPUFeatureLevel::UInt32 begin
    WGPUFeatureLevel_Compatibility = 1
    WGPUFeatureLevel_Core = 2
    WGPUFeatureLevel_Force32 = 2147483647
end

@cenum WGPUFeatureName::UInt32 begin
    WGPUFeatureName_Undefined = 0
    WGPUFeatureName_DepthClipControl = 1
    WGPUFeatureName_Depth32FloatStencil8 = 2
    WGPUFeatureName_TimestampQuery = 3
    WGPUFeatureName_TextureCompressionBC = 4
    WGPUFeatureName_TextureCompressionBCSliced3D = 5
    WGPUFeatureName_TextureCompressionETC2 = 6
    WGPUFeatureName_TextureCompressionASTC = 7
    WGPUFeatureName_TextureCompressionASTCSliced3D = 8
    WGPUFeatureName_IndirectFirstInstance = 9
    WGPUFeatureName_ShaderF16 = 10
    WGPUFeatureName_RG11B10UfloatRenderable = 11
    WGPUFeatureName_BGRA8UnormStorage = 12
    WGPUFeatureName_Float32Filterable = 13
    WGPUFeatureName_Float32Blendable = 14
    WGPUFeatureName_ClipDistances = 15
    WGPUFeatureName_DualSourceBlending = 16
    WGPUFeatureName_Force32 = 2147483647
end

@cenum WGPUFilterMode::UInt32 begin
    WGPUFilterMode_Undefined = 0
    WGPUFilterMode_Nearest = 1
    WGPUFilterMode_Linear = 2
    WGPUFilterMode_Force32 = 2147483647
end

@cenum WGPUFrontFace::UInt32 begin
    WGPUFrontFace_Undefined = 0
    WGPUFrontFace_CCW = 1
    WGPUFrontFace_CW = 2
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
    WGPULoadOp_Load = 1
    WGPULoadOp_Clear = 2
    WGPULoadOp_Force32 = 2147483647
end

@cenum WGPUMapAsyncStatus::UInt32 begin
    WGPUMapAsyncStatus_Success = 1
    WGPUMapAsyncStatus_InstanceDropped = 2
    WGPUMapAsyncStatus_Error = 3
    WGPUMapAsyncStatus_Aborted = 4
    WGPUMapAsyncStatus_Unknown = 5
    WGPUMapAsyncStatus_Force32 = 2147483647
end

@cenum WGPUMipmapFilterMode::UInt32 begin
    WGPUMipmapFilterMode_Undefined = 0
    WGPUMipmapFilterMode_Nearest = 1
    WGPUMipmapFilterMode_Linear = 2
    WGPUMipmapFilterMode_Force32 = 2147483647
end

@cenum WGPUOptionalBool::UInt32 begin
    WGPUOptionalBool_False = 0
    WGPUOptionalBool_True = 1
    WGPUOptionalBool_Undefined = 2
    WGPUOptionalBool_Force32 = 2147483647
end

@cenum WGPUPopErrorScopeStatus::UInt32 begin
    WGPUPopErrorScopeStatus_Success = 1
    WGPUPopErrorScopeStatus_InstanceDropped = 2
    WGPUPopErrorScopeStatus_EmptyStack = 3
    WGPUPopErrorScopeStatus_Force32 = 2147483647
end

@cenum WGPUPowerPreference::UInt32 begin
    WGPUPowerPreference_Undefined = 0
    WGPUPowerPreference_LowPower = 1
    WGPUPowerPreference_HighPerformance = 2
    WGPUPowerPreference_Force32 = 2147483647
end

@cenum WGPUPresentMode::UInt32 begin
    WGPUPresentMode_Undefined = 0
    WGPUPresentMode_Fifo = 1
    WGPUPresentMode_FifoRelaxed = 2
    WGPUPresentMode_Immediate = 3
    WGPUPresentMode_Mailbox = 4
    WGPUPresentMode_Force32 = 2147483647
end

@cenum WGPUPrimitiveTopology::UInt32 begin
    WGPUPrimitiveTopology_Undefined = 0
    WGPUPrimitiveTopology_PointList = 1
    WGPUPrimitiveTopology_LineList = 2
    WGPUPrimitiveTopology_LineStrip = 3
    WGPUPrimitiveTopology_TriangleList = 4
    WGPUPrimitiveTopology_TriangleStrip = 5
    WGPUPrimitiveTopology_Force32 = 2147483647
end

@cenum WGPUQueryType::UInt32 begin
    WGPUQueryType_Occlusion = 1
    WGPUQueryType_Timestamp = 2
    WGPUQueryType_Force32 = 2147483647
end

@cenum WGPUQueueWorkDoneStatus::UInt32 begin
    WGPUQueueWorkDoneStatus_Success = 1
    WGPUQueueWorkDoneStatus_InstanceDropped = 2
    WGPUQueueWorkDoneStatus_Error = 3
    WGPUQueueWorkDoneStatus_Unknown = 4
    WGPUQueueWorkDoneStatus_Force32 = 2147483647
end

@cenum WGPURequestAdapterStatus::UInt32 begin
    WGPURequestAdapterStatus_Success = 1
    WGPURequestAdapterStatus_InstanceDropped = 2
    WGPURequestAdapterStatus_Unavailable = 3
    WGPURequestAdapterStatus_Error = 4
    WGPURequestAdapterStatus_Unknown = 5
    WGPURequestAdapterStatus_Force32 = 2147483647
end

@cenum WGPURequestDeviceStatus::UInt32 begin
    WGPURequestDeviceStatus_Success = 1
    WGPURequestDeviceStatus_InstanceDropped = 2
    WGPURequestDeviceStatus_Error = 3
    WGPURequestDeviceStatus_Unknown = 4
    WGPURequestDeviceStatus_Force32 = 2147483647
end

@cenum WGPUSType::UInt32 begin
    WGPUSType_ShaderSourceSPIRV = 1
    WGPUSType_ShaderSourceWGSL = 2
    WGPUSType_RenderPassMaxDrawCount = 3
    WGPUSType_SurfaceSourceMetalLayer = 4
    WGPUSType_SurfaceSourceWindowsHWND = 5
    WGPUSType_SurfaceSourceXlibWindow = 6
    WGPUSType_SurfaceSourceWaylandSurface = 7
    WGPUSType_SurfaceSourceAndroidNativeWindow = 8
    WGPUSType_SurfaceSourceXCBWindow = 9
    WGPUSType_Force32 = 2147483647
end

@cenum WGPUSamplerBindingType::UInt32 begin
    WGPUSamplerBindingType_BindingNotUsed = 0
    WGPUSamplerBindingType_Undefined = 1
    WGPUSamplerBindingType_Filtering = 2
    WGPUSamplerBindingType_NonFiltering = 3
    WGPUSamplerBindingType_Comparison = 4
    WGPUSamplerBindingType_Force32 = 2147483647
end

@cenum WGPUStatus::UInt32 begin
    WGPUStatus_Success = 1
    WGPUStatus_Error = 2
    WGPUStatus_Force32 = 2147483647
end

@cenum WGPUStencilOperation::UInt32 begin
    WGPUStencilOperation_Undefined = 0
    WGPUStencilOperation_Keep = 1
    WGPUStencilOperation_Zero = 2
    WGPUStencilOperation_Replace = 3
    WGPUStencilOperation_Invert = 4
    WGPUStencilOperation_IncrementClamp = 5
    WGPUStencilOperation_DecrementClamp = 6
    WGPUStencilOperation_IncrementWrap = 7
    WGPUStencilOperation_DecrementWrap = 8
    WGPUStencilOperation_Force32 = 2147483647
end

@cenum WGPUStorageTextureAccess::UInt32 begin
    WGPUStorageTextureAccess_BindingNotUsed = 0
    WGPUStorageTextureAccess_Undefined = 1
    WGPUStorageTextureAccess_WriteOnly = 2
    WGPUStorageTextureAccess_ReadOnly = 3
    WGPUStorageTextureAccess_ReadWrite = 4
    WGPUStorageTextureAccess_Force32 = 2147483647
end

@cenum WGPUStoreOp::UInt32 begin
    WGPUStoreOp_Undefined = 0
    WGPUStoreOp_Store = 1
    WGPUStoreOp_Discard = 2
    WGPUStoreOp_Force32 = 2147483647
end

@cenum WGPUSurfaceGetCurrentTextureStatus::UInt32 begin
    WGPUSurfaceGetCurrentTextureStatus_SuccessOptimal = 1
    WGPUSurfaceGetCurrentTextureStatus_SuccessSuboptimal = 2
    WGPUSurfaceGetCurrentTextureStatus_Timeout = 3
    WGPUSurfaceGetCurrentTextureStatus_Outdated = 4
    WGPUSurfaceGetCurrentTextureStatus_Lost = 5
    WGPUSurfaceGetCurrentTextureStatus_OutOfMemory = 6
    WGPUSurfaceGetCurrentTextureStatus_DeviceLost = 7
    WGPUSurfaceGetCurrentTextureStatus_Error = 8
    WGPUSurfaceGetCurrentTextureStatus_Force32 = 2147483647
end

@cenum WGPUTextureAspect::UInt32 begin
    WGPUTextureAspect_Undefined = 0
    WGPUTextureAspect_All = 1
    WGPUTextureAspect_StencilOnly = 2
    WGPUTextureAspect_DepthOnly = 3
    WGPUTextureAspect_Force32 = 2147483647
end

@cenum WGPUTextureDimension::UInt32 begin
    WGPUTextureDimension_Undefined = 0
    WGPUTextureDimension_1D = 1
    WGPUTextureDimension_2D = 2
    WGPUTextureDimension_3D = 3
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
    WGPUTextureFormat_RGB10A2Uint = 25
    WGPUTextureFormat_RGB10A2Unorm = 26
    WGPUTextureFormat_RG11B10Ufloat = 27
    WGPUTextureFormat_RGB9E5Ufloat = 28
    WGPUTextureFormat_RG32Float = 29
    WGPUTextureFormat_RG32Uint = 30
    WGPUTextureFormat_RG32Sint = 31
    WGPUTextureFormat_RGBA16Uint = 32
    WGPUTextureFormat_RGBA16Sint = 33
    WGPUTextureFormat_RGBA16Float = 34
    WGPUTextureFormat_RGBA32Float = 35
    WGPUTextureFormat_RGBA32Uint = 36
    WGPUTextureFormat_RGBA32Sint = 37
    WGPUTextureFormat_Stencil8 = 38
    WGPUTextureFormat_Depth16Unorm = 39
    WGPUTextureFormat_Depth24Plus = 40
    WGPUTextureFormat_Depth24PlusStencil8 = 41
    WGPUTextureFormat_Depth32Float = 42
    WGPUTextureFormat_Depth32FloatStencil8 = 43
    WGPUTextureFormat_BC1RGBAUnorm = 44
    WGPUTextureFormat_BC1RGBAUnormSrgb = 45
    WGPUTextureFormat_BC2RGBAUnorm = 46
    WGPUTextureFormat_BC2RGBAUnormSrgb = 47
    WGPUTextureFormat_BC3RGBAUnorm = 48
    WGPUTextureFormat_BC3RGBAUnormSrgb = 49
    WGPUTextureFormat_BC4RUnorm = 50
    WGPUTextureFormat_BC4RSnorm = 51
    WGPUTextureFormat_BC5RGUnorm = 52
    WGPUTextureFormat_BC5RGSnorm = 53
    WGPUTextureFormat_BC6HRGBUfloat = 54
    WGPUTextureFormat_BC6HRGBFloat = 55
    WGPUTextureFormat_BC7RGBAUnorm = 56
    WGPUTextureFormat_BC7RGBAUnormSrgb = 57
    WGPUTextureFormat_ETC2RGB8Unorm = 58
    WGPUTextureFormat_ETC2RGB8UnormSrgb = 59
    WGPUTextureFormat_ETC2RGB8A1Unorm = 60
    WGPUTextureFormat_ETC2RGB8A1UnormSrgb = 61
    WGPUTextureFormat_ETC2RGBA8Unorm = 62
    WGPUTextureFormat_ETC2RGBA8UnormSrgb = 63
    WGPUTextureFormat_EACR11Unorm = 64
    WGPUTextureFormat_EACR11Snorm = 65
    WGPUTextureFormat_EACRG11Unorm = 66
    WGPUTextureFormat_EACRG11Snorm = 67
    WGPUTextureFormat_ASTC4x4Unorm = 68
    WGPUTextureFormat_ASTC4x4UnormSrgb = 69
    WGPUTextureFormat_ASTC5x4Unorm = 70
    WGPUTextureFormat_ASTC5x4UnormSrgb = 71
    WGPUTextureFormat_ASTC5x5Unorm = 72
    WGPUTextureFormat_ASTC5x5UnormSrgb = 73
    WGPUTextureFormat_ASTC6x5Unorm = 74
    WGPUTextureFormat_ASTC6x5UnormSrgb = 75
    WGPUTextureFormat_ASTC6x6Unorm = 76
    WGPUTextureFormat_ASTC6x6UnormSrgb = 77
    WGPUTextureFormat_ASTC8x5Unorm = 78
    WGPUTextureFormat_ASTC8x5UnormSrgb = 79
    WGPUTextureFormat_ASTC8x6Unorm = 80
    WGPUTextureFormat_ASTC8x6UnormSrgb = 81
    WGPUTextureFormat_ASTC8x8Unorm = 82
    WGPUTextureFormat_ASTC8x8UnormSrgb = 83
    WGPUTextureFormat_ASTC10x5Unorm = 84
    WGPUTextureFormat_ASTC10x5UnormSrgb = 85
    WGPUTextureFormat_ASTC10x6Unorm = 86
    WGPUTextureFormat_ASTC10x6UnormSrgb = 87
    WGPUTextureFormat_ASTC10x8Unorm = 88
    WGPUTextureFormat_ASTC10x8UnormSrgb = 89
    WGPUTextureFormat_ASTC10x10Unorm = 90
    WGPUTextureFormat_ASTC10x10UnormSrgb = 91
    WGPUTextureFormat_ASTC12x10Unorm = 92
    WGPUTextureFormat_ASTC12x10UnormSrgb = 93
    WGPUTextureFormat_ASTC12x12Unorm = 94
    WGPUTextureFormat_ASTC12x12UnormSrgb = 95
    WGPUTextureFormat_Force32 = 2147483647
end

@cenum WGPUTextureSampleType::UInt32 begin
    WGPUTextureSampleType_BindingNotUsed = 0
    WGPUTextureSampleType_Undefined = 1
    WGPUTextureSampleType_Float = 2
    WGPUTextureSampleType_UnfilterableFloat = 3
    WGPUTextureSampleType_Depth = 4
    WGPUTextureSampleType_Sint = 5
    WGPUTextureSampleType_Uint = 6
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
    WGPUVertexFormat_Uint8 = 1
    WGPUVertexFormat_Uint8x2 = 2
    WGPUVertexFormat_Uint8x4 = 3
    WGPUVertexFormat_Sint8 = 4
    WGPUVertexFormat_Sint8x2 = 5
    WGPUVertexFormat_Sint8x4 = 6
    WGPUVertexFormat_Unorm8 = 7
    WGPUVertexFormat_Unorm8x2 = 8
    WGPUVertexFormat_Unorm8x4 = 9
    WGPUVertexFormat_Snorm8 = 10
    WGPUVertexFormat_Snorm8x2 = 11
    WGPUVertexFormat_Snorm8x4 = 12
    WGPUVertexFormat_Uint16 = 13
    WGPUVertexFormat_Uint16x2 = 14
    WGPUVertexFormat_Uint16x4 = 15
    WGPUVertexFormat_Sint16 = 16
    WGPUVertexFormat_Sint16x2 = 17
    WGPUVertexFormat_Sint16x4 = 18
    WGPUVertexFormat_Unorm16 = 19
    WGPUVertexFormat_Unorm16x2 = 20
    WGPUVertexFormat_Unorm16x4 = 21
    WGPUVertexFormat_Snorm16 = 22
    WGPUVertexFormat_Snorm16x2 = 23
    WGPUVertexFormat_Snorm16x4 = 24
    WGPUVertexFormat_Float16 = 25
    WGPUVertexFormat_Float16x2 = 26
    WGPUVertexFormat_Float16x4 = 27
    WGPUVertexFormat_Float32 = 28
    WGPUVertexFormat_Float32x2 = 29
    WGPUVertexFormat_Float32x3 = 30
    WGPUVertexFormat_Float32x4 = 31
    WGPUVertexFormat_Uint32 = 32
    WGPUVertexFormat_Uint32x2 = 33
    WGPUVertexFormat_Uint32x3 = 34
    WGPUVertexFormat_Uint32x4 = 35
    WGPUVertexFormat_Sint32 = 36
    WGPUVertexFormat_Sint32x2 = 37
    WGPUVertexFormat_Sint32x3 = 38
    WGPUVertexFormat_Sint32x4 = 39
    WGPUVertexFormat_Unorm10_10_10_2 = 40
    WGPUVertexFormat_Unorm8x4BGRA = 41
    WGPUVertexFormat_Force32 = 2147483647
end

@cenum WGPUVertexStepMode::UInt32 begin
    WGPUVertexStepMode_VertexBufferNotUsed = 0
    WGPUVertexStepMode_Undefined = 1
    WGPUVertexStepMode_Vertex = 2
    WGPUVertexStepMode_Instance = 3
    WGPUVertexStepMode_Force32 = 2147483647
end

@cenum WGPUWGSLLanguageFeatureName::UInt32 begin
    WGPUWGSLLanguageFeatureName_ReadonlyAndReadwriteStorageTextures = 1
    WGPUWGSLLanguageFeatureName_Packed4x8IntegerDotProduct = 2
    WGPUWGSLLanguageFeatureName_UnrestrictedPointerParameters = 3
    WGPUWGSLLanguageFeatureName_PointerCompositeAccess = 4
    WGPUWGSLLanguageFeatureName_Force32 = 2147483647
end

@cenum WGPUWaitStatus::UInt32 begin
    WGPUWaitStatus_Success = 1
    WGPUWaitStatus_TimedOut = 2
    WGPUWaitStatus_UnsupportedTimeout = 3
    WGPUWaitStatus_UnsupportedCount = 4
    WGPUWaitStatus_UnsupportedMixedSources = 5
    WGPUWaitStatus_Force32 = 2147483647
end

const WGPUBufferUsage = WGPUFlags

const WGPUColorWriteMask = WGPUFlags

const WGPUMapMode = WGPUFlags

const WGPUShaderStage = WGPUFlags

const WGPUTextureUsage = WGPUFlags

# typedef void ( * WGPUProc ) ( void )
const WGPUProc = Ptr{Cvoid}

# typedef void ( * WGPUBufferMapCallback ) ( WGPUMapAsyncStatus status , WGPUStringView message , WGPU_NULLABLE void * userdata1 , WGPU_NULLABLE void * userdata2 )
const WGPUBufferMapCallback = Ptr{Cvoid}

# typedef void ( * WGPUCompilationInfoCallback ) ( WGPUCompilationInfoRequestStatus status , struct WGPUCompilationInfo const * compilationInfo , WGPU_NULLABLE void * userdata1 , WGPU_NULLABLE void * userdata2 )
const WGPUCompilationInfoCallback = Ptr{Cvoid}

# typedef void ( * WGPUCreateComputePipelineAsyncCallback ) ( WGPUCreatePipelineAsyncStatus status , WGPUComputePipeline pipeline , WGPUStringView message , WGPU_NULLABLE void * userdata1 , WGPU_NULLABLE void * userdata2 )
const WGPUCreateComputePipelineAsyncCallback = Ptr{Cvoid}

# typedef void ( * WGPUCreateRenderPipelineAsyncCallback ) ( WGPUCreatePipelineAsyncStatus status , WGPURenderPipeline pipeline , WGPUStringView message , WGPU_NULLABLE void * userdata1 , WGPU_NULLABLE void * userdata2 )
const WGPUCreateRenderPipelineAsyncCallback = Ptr{Cvoid}

# typedef void ( * WGPUDeviceLostCallback ) ( WGPUDevice const * device , WGPUDeviceLostReason reason , WGPUStringView message , WGPU_NULLABLE void * userdata1 , WGPU_NULLABLE void * userdata2 )
const WGPUDeviceLostCallback = Ptr{Cvoid}

# typedef void ( * WGPUPopErrorScopeCallback ) ( WGPUPopErrorScopeStatus status , WGPUErrorType type , WGPUStringView message , WGPU_NULLABLE void * userdata1 , WGPU_NULLABLE void * userdata2 )
const WGPUPopErrorScopeCallback = Ptr{Cvoid}

# typedef void ( * WGPUQueueWorkDoneCallback ) ( WGPUQueueWorkDoneStatus status , WGPU_NULLABLE void * userdata1 , WGPU_NULLABLE void * userdata2 )
const WGPUQueueWorkDoneCallback = Ptr{Cvoid}

# typedef void ( * WGPURequestAdapterCallback ) ( WGPURequestAdapterStatus status , WGPUAdapter adapter , WGPUStringView message , WGPU_NULLABLE void * userdata1 , WGPU_NULLABLE void * userdata2 )
const WGPURequestAdapterCallback = Ptr{Cvoid}

# typedef void ( * WGPURequestDeviceCallback ) ( WGPURequestDeviceStatus status , WGPUDevice device , WGPUStringView message , WGPU_NULLABLE void * userdata1 , WGPU_NULLABLE void * userdata2 )
const WGPURequestDeviceCallback = Ptr{Cvoid}

# typedef void ( * WGPUUncapturedErrorCallback ) ( WGPUDevice const * device , WGPUErrorType type , WGPUStringView message , WGPU_NULLABLE void * userdata1 , WGPU_NULLABLE void * userdata2 )
const WGPUUncapturedErrorCallback = Ptr{Cvoid}

struct WGPUChainedStruct
    next::Ptr{WGPUChainedStruct}
    sType::WGPUSType
end

struct WGPUChainedStructOut
    next::Ptr{WGPUChainedStructOut}
    sType::WGPUSType
end

mutable struct WGPUBufferMapCallbackInfo
    nextInChain::Ptr{WGPUChainedStruct}
    mode::WGPUCallbackMode
    callback::WGPUBufferMapCallback
    userdata1::Ptr{Cvoid}
    userdata2::Ptr{Cvoid}
    WGPUBufferMapCallbackInfo() = new()
end

mutable struct WGPUCompilationInfoCallbackInfo
    nextInChain::Ptr{WGPUChainedStruct}
    mode::WGPUCallbackMode
    callback::WGPUCompilationInfoCallback
    userdata1::Ptr{Cvoid}
    userdata2::Ptr{Cvoid}
    WGPUCompilationInfoCallbackInfo() = new()
end

mutable struct WGPUCreateComputePipelineAsyncCallbackInfo
    nextInChain::Ptr{WGPUChainedStruct}
    mode::WGPUCallbackMode
    callback::WGPUCreateComputePipelineAsyncCallback
    userdata1::Ptr{Cvoid}
    userdata2::Ptr{Cvoid}
    WGPUCreateComputePipelineAsyncCallbackInfo() = new()
end

mutable struct WGPUCreateRenderPipelineAsyncCallbackInfo
    nextInChain::Ptr{WGPUChainedStruct}
    mode::WGPUCallbackMode
    callback::WGPUCreateRenderPipelineAsyncCallback
    userdata1::Ptr{Cvoid}
    userdata2::Ptr{Cvoid}
    WGPUCreateRenderPipelineAsyncCallbackInfo() = new()
end

struct WGPUDeviceLostCallbackInfo
    nextInChain::Ptr{WGPUChainedStruct}
    mode::WGPUCallbackMode
    callback::WGPUDeviceLostCallback
    userdata1::Ptr{Cvoid}
    userdata2::Ptr{Cvoid}
end

mutable struct WGPUPopErrorScopeCallbackInfo
    nextInChain::Ptr{WGPUChainedStruct}
    mode::WGPUCallbackMode
    callback::WGPUPopErrorScopeCallback
    userdata1::Ptr{Cvoid}
    userdata2::Ptr{Cvoid}
    WGPUPopErrorScopeCallbackInfo() = new()
end

mutable struct WGPUQueueWorkDoneCallbackInfo
    nextInChain::Ptr{WGPUChainedStruct}
    mode::WGPUCallbackMode
    callback::WGPUQueueWorkDoneCallback
    userdata1::Ptr{Cvoid}
    userdata2::Ptr{Cvoid}
    WGPUQueueWorkDoneCallbackInfo() = new()
end

mutable struct WGPURequestAdapterCallbackInfo
    nextInChain::Ptr{WGPUChainedStruct}
    mode::WGPUCallbackMode
    callback::WGPURequestAdapterCallback
    userdata1::Ptr{Cvoid}
    userdata2::Ptr{Cvoid}
    WGPURequestAdapterCallbackInfo() = new()
end

mutable struct WGPURequestDeviceCallbackInfo
    nextInChain::Ptr{WGPUChainedStruct}
    mode::WGPUCallbackMode
    callback::WGPURequestDeviceCallback
    userdata1::Ptr{Cvoid}
    userdata2::Ptr{Cvoid}
    WGPURequestDeviceCallbackInfo() = new()
end

struct WGPUUncapturedErrorCallbackInfo
    nextInChain::Ptr{WGPUChainedStruct}
    callback::WGPUUncapturedErrorCallback
    userdata1::Ptr{Cvoid}
    userdata2::Ptr{Cvoid}
end

mutable struct WGPUAdapterInfo
    nextInChain::Ptr{WGPUChainedStructOut}
    vendor::WGPUStringView
    architecture::WGPUStringView
    device::WGPUStringView
    description::WGPUStringView
    backendType::WGPUBackendType
    adapterType::WGPUAdapterType
    vendorID::UInt32
    deviceID::UInt32
    WGPUAdapterInfo() = new()
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
    hasDynamicOffset::WGPUBool
    minBindingSize::UInt64
end

mutable struct WGPUBufferDescriptor
    nextInChain::Ptr{WGPUChainedStruct}
    label::WGPUStringView
    usage::WGPUBufferUsage
    size::UInt64
    mappedAtCreation::WGPUBool
    WGPUBufferDescriptor() = new()
end

struct WGPUColor
    r::Cdouble
    g::Cdouble
    b::Cdouble
    a::Cdouble
end

mutable struct WGPUCommandBufferDescriptor
    nextInChain::Ptr{WGPUChainedStruct}
    label::WGPUStringView
    WGPUCommandBufferDescriptor() = new()
end

mutable struct WGPUCommandEncoderDescriptor
    nextInChain::Ptr{WGPUChainedStruct}
    label::WGPUStringView
    WGPUCommandEncoderDescriptor() = new()
end

struct WGPUCompilationMessage
    nextInChain::Ptr{WGPUChainedStruct}
    message::WGPUStringView
    type::WGPUCompilationMessageType
    lineNum::UInt64
    linePos::UInt64
    offset::UInt64
    length::UInt64
end

struct WGPUComputePassTimestampWrites
    querySet::WGPUQuerySet
    beginningOfPassWriteIndex::UInt32
    endOfPassWriteIndex::UInt32
end

struct WGPUConstantEntry
    nextInChain::Ptr{WGPUChainedStruct}
    key::WGPUStringView
    value::Cdouble
end

struct WGPUExtent3D
    width::UInt32
    height::UInt32
    depthOrArrayLayers::UInt32
end

struct WGPUFuture
    id::UInt64
end

struct WGPUInstanceCapabilities
    nextInChain::Ptr{WGPUChainedStructOut}
    timedWaitAnyEnable::WGPUBool
    timedWaitAnyMaxCount::Csize_t
end

struct WGPULimits
    nextInChain::Ptr{WGPUChainedStructOut}
    maxTextureDimension1D::UInt32
    maxTextureDimension2D::UInt32
    maxTextureDimension3D::UInt32
    maxTextureArrayLayers::UInt32
    maxBindGroups::UInt32
    maxBindGroupsPlusVertexBuffers::UInt32
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
    alphaToCoverageEnabled::WGPUBool
end

struct WGPUOrigin3D
    x::UInt32
    y::UInt32
    z::UInt32
end

mutable struct WGPUPipelineLayoutDescriptor
    nextInChain::Ptr{WGPUChainedStruct}
    label::WGPUStringView
    bindGroupLayoutCount::Csize_t
    bindGroupLayouts::Ptr{WGPUBindGroupLayout}
    WGPUPipelineLayoutDescriptor() = new()
end

struct WGPUPrimitiveState
    nextInChain::Ptr{WGPUChainedStruct}
    topology::WGPUPrimitiveTopology
    stripIndexFormat::WGPUIndexFormat
    frontFace::WGPUFrontFace
    cullMode::WGPUCullMode
    unclippedDepth::WGPUBool
end

mutable struct WGPUQuerySetDescriptor
    nextInChain::Ptr{WGPUChainedStruct}
    label::WGPUStringView
    type::WGPUQueryType
    count::UInt32
    WGPUQuerySetDescriptor() = new()
end

struct WGPUQueueDescriptor
    nextInChain::Ptr{WGPUChainedStruct}
    label::WGPUStringView
end

mutable struct WGPURenderBundleDescriptor
    nextInChain::Ptr{WGPUChainedStruct}
    label::WGPUStringView
    WGPURenderBundleDescriptor() = new()
end

mutable struct WGPURenderBundleEncoderDescriptor
    nextInChain::Ptr{WGPUChainedStruct}
    label::WGPUStringView
    colorFormatCount::Csize_t
    colorFormats::Ptr{WGPUTextureFormat}
    depthStencilFormat::WGPUTextureFormat
    sampleCount::UInt32
    depthReadOnly::WGPUBool
    stencilReadOnly::WGPUBool
    WGPURenderBundleEncoderDescriptor() = new()
end

struct WGPURenderPassDepthStencilAttachment
    view::WGPUTextureView
    depthLoadOp::WGPULoadOp
    depthStoreOp::WGPUStoreOp
    depthClearValue::Cfloat
    depthReadOnly::WGPUBool
    stencilLoadOp::WGPULoadOp
    stencilStoreOp::WGPUStoreOp
    stencilClearValue::UInt32
    stencilReadOnly::WGPUBool
end

mutable struct WGPURenderPassMaxDrawCount
    chain::WGPUChainedStruct
    maxDrawCount::UInt64
    WGPURenderPassMaxDrawCount() = new()
end

struct WGPURenderPassTimestampWrites
    querySet::WGPUQuerySet
    beginningOfPassWriteIndex::UInt32
    endOfPassWriteIndex::UInt32
end

mutable struct WGPURequestAdapterOptions
    nextInChain::Ptr{WGPUChainedStruct}
    featureLevel::WGPUFeatureLevel
    powerPreference::WGPUPowerPreference
    forceFallbackAdapter::WGPUBool
    backendType::WGPUBackendType
    compatibleSurface::WGPUSurface
    WGPURequestAdapterOptions() = new()
end

struct WGPUSamplerBindingLayout
    nextInChain::Ptr{WGPUChainedStruct}
    type::WGPUSamplerBindingType
end

mutable struct WGPUSamplerDescriptor
    nextInChain::Ptr{WGPUChainedStruct}
    label::WGPUStringView
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
    WGPUSamplerDescriptor() = new()
end

mutable struct WGPUShaderModuleDescriptor
    nextInChain::Ptr{WGPUChainedStruct}
    label::WGPUStringView
    WGPUShaderModuleDescriptor() = new()
end

mutable struct WGPUShaderSourceSPIRV
    chain::WGPUChainedStruct
    codeSize::UInt32
    code::Ptr{UInt32}
    WGPUShaderSourceSPIRV() = new()
end

mutable struct WGPUShaderSourceWGSL
    chain::WGPUChainedStruct
    code::WGPUStringView
    WGPUShaderSourceWGSL() = new()
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

mutable struct WGPUSupportedFeatures
    featureCount::Csize_t
    features::Ptr{WGPUFeatureName}
    WGPUSupportedFeatures() = new()
end

mutable struct WGPUSupportedWGSLLanguageFeatures
    featureCount::Csize_t
    features::Ptr{WGPUWGSLLanguageFeatureName}
    WGPUSupportedWGSLLanguageFeatures() = new()
end

mutable struct WGPUSurfaceCapabilities
    nextInChain::Ptr{WGPUChainedStructOut}
    usages::WGPUTextureUsage
    formatCount::Csize_t
    formats::Ptr{WGPUTextureFormat}
    presentModeCount::Csize_t
    presentModes::Ptr{WGPUPresentMode}
    alphaModeCount::Csize_t
    alphaModes::Ptr{WGPUCompositeAlphaMode}
    WGPUSurfaceCapabilities() = new()
end

mutable struct WGPUSurfaceConfiguration
    nextInChain::Ptr{WGPUChainedStruct}
    device::WGPUDevice
    format::WGPUTextureFormat
    usage::WGPUTextureUsage
    width::UInt32
    height::UInt32
    viewFormatCount::Csize_t
    viewFormats::Ptr{WGPUTextureFormat}
    alphaMode::WGPUCompositeAlphaMode
    presentMode::WGPUPresentMode
    WGPUSurfaceConfiguration() = new()
end

mutable struct WGPUSurfaceDescriptor
    nextInChain::Ptr{WGPUChainedStruct}
    label::WGPUStringView
    WGPUSurfaceDescriptor() = new()
end

mutable struct WGPUSurfaceSourceAndroidNativeWindow
    chain::WGPUChainedStruct
    window::Ptr{Cvoid}
    WGPUSurfaceSourceAndroidNativeWindow() = new()
end

mutable struct WGPUSurfaceSourceMetalLayer
    chain::WGPUChainedStruct
    layer::Ptr{Cvoid}
    WGPUSurfaceSourceMetalLayer() = new()
end

mutable struct WGPUSurfaceSourceWaylandSurface
    chain::WGPUChainedStruct
    display::Ptr{Cvoid}
    surface::Ptr{Cvoid}
    WGPUSurfaceSourceWaylandSurface() = new()
end

mutable struct WGPUSurfaceSourceWindowsHWND
    chain::WGPUChainedStruct
    hinstance::Ptr{Cvoid}
    hwnd::Ptr{Cvoid}
    WGPUSurfaceSourceWindowsHWND() = new()
end

mutable struct WGPUSurfaceSourceXCBWindow
    chain::WGPUChainedStruct
    connection::Ptr{Cvoid}
    window::UInt32
    WGPUSurfaceSourceXCBWindow() = new()
end

mutable struct WGPUSurfaceSourceXlibWindow
    chain::WGPUChainedStruct
    display::Ptr{Cvoid}
    window::UInt64
    WGPUSurfaceSourceXlibWindow() = new()
end

mutable struct WGPUSurfaceTexture
    nextInChain::Ptr{WGPUChainedStructOut}
    texture::WGPUTexture
    status::WGPUSurfaceGetCurrentTextureStatus
    WGPUSurfaceTexture() = new()
end

struct WGPUTexelCopyBufferLayout
    offset::UInt64
    bytesPerRow::UInt32
    rowsPerImage::UInt32
end

struct WGPUTextureBindingLayout
    nextInChain::Ptr{WGPUChainedStruct}
    sampleType::WGPUTextureSampleType
    viewDimension::WGPUTextureViewDimension
    multisampled::WGPUBool
end

mutable struct WGPUTextureViewDescriptor
    nextInChain::Ptr{WGPUChainedStruct}
    label::WGPUStringView
    format::WGPUTextureFormat
    dimension::WGPUTextureViewDimension
    baseMipLevel::UInt32
    mipLevelCount::UInt32
    baseArrayLayer::UInt32
    arrayLayerCount::UInt32
    aspect::WGPUTextureAspect
    usage::WGPUTextureUsage
    WGPUTextureViewDescriptor() = new()
end

struct WGPUVertexAttribute
    format::WGPUVertexFormat
    offset::UInt64
    shaderLocation::UInt32
end

mutable struct WGPUBindGroupDescriptor
    nextInChain::Ptr{WGPUChainedStruct}
    label::WGPUStringView
    layout::WGPUBindGroupLayout
    entryCount::Csize_t
    entries::Ptr{WGPUBindGroupEntry}
    WGPUBindGroupDescriptor() = new()
end

struct WGPUBindGroupLayoutEntry
    nextInChain::Ptr{WGPUChainedStruct}
    binding::UInt32
    visibility::WGPUShaderStage
    buffer::WGPUBufferBindingLayout
    sampler::WGPUSamplerBindingLayout
    texture::WGPUTextureBindingLayout
    storageTexture::WGPUStorageTextureBindingLayout
end

struct WGPUBlendState
    color::WGPUBlendComponent
    alpha::WGPUBlendComponent
end

mutable struct WGPUCompilationInfo
    nextInChain::Ptr{WGPUChainedStruct}
    messageCount::Csize_t
    messages::Ptr{WGPUCompilationMessage}
    WGPUCompilationInfo() = new()
end

mutable struct WGPUComputePassDescriptor
    nextInChain::Ptr{WGPUChainedStruct}
    label::WGPUStringView
    timestampWrites::Ptr{WGPUComputePassTimestampWrites}
    WGPUComputePassDescriptor() = new()
end

struct WGPUDepthStencilState
    nextInChain::Ptr{WGPUChainedStruct}
    format::WGPUTextureFormat
    depthWriteEnabled::WGPUOptionalBool
    depthCompare::WGPUCompareFunction
    stencilFront::WGPUStencilFaceState
    stencilBack::WGPUStencilFaceState
    stencilReadMask::UInt32
    stencilWriteMask::UInt32
    depthBias::Int32
    depthBiasSlopeScale::Cfloat
    depthBiasClamp::Cfloat
end

mutable struct WGPUDeviceDescriptor
    nextInChain::Ptr{WGPUChainedStruct}
    label::WGPUStringView
    requiredFeatureCount::Csize_t
    requiredFeatures::Ptr{WGPUFeatureName}
    requiredLimits::Ptr{WGPULimits}
    defaultQueue::WGPUQueueDescriptor
    deviceLostCallbackInfo::WGPUDeviceLostCallbackInfo
    uncapturedErrorCallbackInfo::WGPUUncapturedErrorCallbackInfo
    WGPUDeviceDescriptor() = new()
end

struct WGPUFutureWaitInfo
    future::WGPUFuture
    completed::WGPUBool
end

mutable struct WGPUInstanceDescriptor
    nextInChain::Ptr{WGPUChainedStruct}
    features::WGPUInstanceCapabilities
    WGPUInstanceDescriptor() = new()
end

struct WGPUProgrammableStageDescriptor
    nextInChain::Ptr{WGPUChainedStruct}
    _module::WGPUShaderModule
    entryPoint::WGPUStringView
    constantCount::Csize_t
    constants::Ptr{WGPUConstantEntry}
end

struct WGPURenderPassColorAttachment
    nextInChain::Ptr{WGPUChainedStruct}
    view::WGPUTextureView
    depthSlice::UInt32
    resolveTarget::WGPUTextureView
    loadOp::WGPULoadOp
    storeOp::WGPUStoreOp
    clearValue::WGPUColor
end

mutable struct WGPUTexelCopyBufferInfo
    layout::WGPUTexelCopyBufferLayout
    buffer::WGPUBuffer
    WGPUTexelCopyBufferInfo() = new()
end

struct WGPUTexelCopyTextureInfo
    texture::WGPUTexture
    mipLevel::UInt32
    origin::WGPUOrigin3D
    aspect::WGPUTextureAspect
end

mutable struct WGPUTextureDescriptor
    nextInChain::Ptr{WGPUChainedStruct}
    label::WGPUStringView
    usage::WGPUTextureUsage
    dimension::WGPUTextureDimension
    size::WGPUExtent3D
    format::WGPUTextureFormat
    mipLevelCount::UInt32
    sampleCount::UInt32
    viewFormatCount::Csize_t
    viewFormats::Ptr{WGPUTextureFormat}
    WGPUTextureDescriptor() = new()
end

struct WGPUVertexBufferLayout
    stepMode::WGPUVertexStepMode
    arrayStride::UInt64
    attributeCount::Csize_t
    attributes::Ptr{WGPUVertexAttribute}
end

mutable struct WGPUBindGroupLayoutDescriptor
    nextInChain::Ptr{WGPUChainedStruct}
    label::WGPUStringView
    entryCount::Csize_t
    entries::Ptr{WGPUBindGroupLayoutEntry}
    WGPUBindGroupLayoutDescriptor() = new()
end

struct WGPUColorTargetState
    nextInChain::Ptr{WGPUChainedStruct}
    format::WGPUTextureFormat
    blend::Ptr{WGPUBlendState}
    writeMask::WGPUColorWriteMask
end

mutable struct WGPUComputePipelineDescriptor
    nextInChain::Ptr{WGPUChainedStruct}
    label::WGPUStringView
    layout::WGPUPipelineLayout
    compute::WGPUProgrammableStageDescriptor
    WGPUComputePipelineDescriptor() = new()
end

mutable struct WGPURenderPassDescriptor
    nextInChain::Ptr{WGPUChainedStruct}
    label::WGPUStringView
    colorAttachmentCount::Csize_t
    colorAttachments::Ptr{WGPURenderPassColorAttachment}
    depthStencilAttachment::Ptr{WGPURenderPassDepthStencilAttachment}
    occlusionQuerySet::WGPUQuerySet
    timestampWrites::Ptr{WGPURenderPassTimestampWrites}
    WGPURenderPassDescriptor() = new()
end

struct WGPUVertexState
    nextInChain::Ptr{WGPUChainedStruct}
    _module::WGPUShaderModule
    entryPoint::WGPUStringView
    constantCount::Csize_t
    constants::Ptr{WGPUConstantEntry}
    bufferCount::Csize_t
    buffers::Ptr{WGPUVertexBufferLayout}
end

struct WGPUFragmentState
    nextInChain::Ptr{WGPUChainedStruct}
    _module::WGPUShaderModule
    entryPoint::WGPUStringView
    constantCount::Csize_t
    constants::Ptr{WGPUConstantEntry}
    targetCount::Csize_t
    targets::Ptr{WGPUColorTargetState}
end

mutable struct WGPURenderPipelineDescriptor
    nextInChain::Ptr{WGPUChainedStruct}
    label::WGPUStringView
    layout::WGPUPipelineLayout
    vertex::WGPUVertexState
    primitive::WGPUPrimitiveState
    depthStencil::Ptr{WGPUDepthStencilState}
    multisample::WGPUMultisampleState
    fragment::Ptr{WGPUFragmentState}
    WGPURenderPipelineDescriptor() = new()
end

# typedef WGPUInstance ( * WGPUProcCreateInstance ) ( WGPU_NULLABLE WGPUInstanceDescriptor const * descriptor )
const WGPUProcCreateInstance = Ptr{Cvoid}

# typedef WGPUStatus ( * WGPUProcGetInstanceCapabilities ) ( WGPUInstanceCapabilities * capabilities )
const WGPUProcGetInstanceCapabilities = Ptr{Cvoid}

# typedef WGPUProc ( * WGPUProcGetProcAddress ) ( WGPUStringView procName )
const WGPUProcGetProcAddress = Ptr{Cvoid}

# typedef void ( * WGPUProcAdapterGetFeatures ) ( WGPUAdapter adapter , WGPUSupportedFeatures * features )
const WGPUProcAdapterGetFeatures = Ptr{Cvoid}

# typedef WGPUStatus ( * WGPUProcAdapterGetInfo ) ( WGPUAdapter adapter , WGPUAdapterInfo * info )
const WGPUProcAdapterGetInfo = Ptr{Cvoid}

# typedef WGPUStatus ( * WGPUProcAdapterGetLimits ) ( WGPUAdapter adapter , WGPULimits * limits )
const WGPUProcAdapterGetLimits = Ptr{Cvoid}

# typedef WGPUBool ( * WGPUProcAdapterHasFeature ) ( WGPUAdapter adapter , WGPUFeatureName feature )
const WGPUProcAdapterHasFeature = Ptr{Cvoid}

# typedef WGPUFuture ( * WGPUProcAdapterRequestDevice ) ( WGPUAdapter adapter , WGPU_NULLABLE WGPUDeviceDescriptor const * descriptor , WGPURequestDeviceCallbackInfo callbackInfo )
const WGPUProcAdapterRequestDevice = Ptr{Cvoid}

# typedef void ( * WGPUProcAdapterAddRef ) ( WGPUAdapter adapter )
const WGPUProcAdapterAddRef = Ptr{Cvoid}

# typedef void ( * WGPUProcAdapterRelease ) ( WGPUAdapter adapter )
const WGPUProcAdapterRelease = Ptr{Cvoid}

# typedef void ( * WGPUProcAdapterInfoFreeMembers ) ( WGPUAdapterInfo adapterInfo )
const WGPUProcAdapterInfoFreeMembers = Ptr{Cvoid}

# typedef void ( * WGPUProcBindGroupSetLabel ) ( WGPUBindGroup bindGroup , WGPUStringView label )
const WGPUProcBindGroupSetLabel = Ptr{Cvoid}

# typedef void ( * WGPUProcBindGroupAddRef ) ( WGPUBindGroup bindGroup )
const WGPUProcBindGroupAddRef = Ptr{Cvoid}

# typedef void ( * WGPUProcBindGroupRelease ) ( WGPUBindGroup bindGroup )
const WGPUProcBindGroupRelease = Ptr{Cvoid}

# typedef void ( * WGPUProcBindGroupLayoutSetLabel ) ( WGPUBindGroupLayout bindGroupLayout , WGPUStringView label )
const WGPUProcBindGroupLayoutSetLabel = Ptr{Cvoid}

# typedef void ( * WGPUProcBindGroupLayoutAddRef ) ( WGPUBindGroupLayout bindGroupLayout )
const WGPUProcBindGroupLayoutAddRef = Ptr{Cvoid}

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

# typedef WGPUBufferUsage ( * WGPUProcBufferGetUsage ) ( WGPUBuffer buffer )
const WGPUProcBufferGetUsage = Ptr{Cvoid}

# typedef WGPUFuture ( * WGPUProcBufferMapAsync ) ( WGPUBuffer buffer , WGPUMapMode mode , size_t offset , size_t size , WGPUBufferMapCallbackInfo callbackInfo )
const WGPUProcBufferMapAsync = Ptr{Cvoid}

# typedef void ( * WGPUProcBufferSetLabel ) ( WGPUBuffer buffer , WGPUStringView label )
const WGPUProcBufferSetLabel = Ptr{Cvoid}

# typedef void ( * WGPUProcBufferUnmap ) ( WGPUBuffer buffer )
const WGPUProcBufferUnmap = Ptr{Cvoid}

# typedef void ( * WGPUProcBufferAddRef ) ( WGPUBuffer buffer )
const WGPUProcBufferAddRef = Ptr{Cvoid}

# typedef void ( * WGPUProcBufferRelease ) ( WGPUBuffer buffer )
const WGPUProcBufferRelease = Ptr{Cvoid}

# typedef void ( * WGPUProcCommandBufferSetLabel ) ( WGPUCommandBuffer commandBuffer , WGPUStringView label )
const WGPUProcCommandBufferSetLabel = Ptr{Cvoid}

# typedef void ( * WGPUProcCommandBufferAddRef ) ( WGPUCommandBuffer commandBuffer )
const WGPUProcCommandBufferAddRef = Ptr{Cvoid}

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

# typedef void ( * WGPUProcCommandEncoderCopyBufferToTexture ) ( WGPUCommandEncoder commandEncoder , WGPUTexelCopyBufferInfo const * source , WGPUTexelCopyTextureInfo const * destination , WGPUExtent3D const * copySize )
const WGPUProcCommandEncoderCopyBufferToTexture = Ptr{Cvoid}

# typedef void ( * WGPUProcCommandEncoderCopyTextureToBuffer ) ( WGPUCommandEncoder commandEncoder , WGPUTexelCopyTextureInfo const * source , WGPUTexelCopyBufferInfo const * destination , WGPUExtent3D const * copySize )
const WGPUProcCommandEncoderCopyTextureToBuffer = Ptr{Cvoid}

# typedef void ( * WGPUProcCommandEncoderCopyTextureToTexture ) ( WGPUCommandEncoder commandEncoder , WGPUTexelCopyTextureInfo const * source , WGPUTexelCopyTextureInfo const * destination , WGPUExtent3D const * copySize )
const WGPUProcCommandEncoderCopyTextureToTexture = Ptr{Cvoid}

# typedef WGPUCommandBuffer ( * WGPUProcCommandEncoderFinish ) ( WGPUCommandEncoder commandEncoder , WGPU_NULLABLE WGPUCommandBufferDescriptor const * descriptor )
const WGPUProcCommandEncoderFinish = Ptr{Cvoid}

# typedef void ( * WGPUProcCommandEncoderInsertDebugMarker ) ( WGPUCommandEncoder commandEncoder , WGPUStringView markerLabel )
const WGPUProcCommandEncoderInsertDebugMarker = Ptr{Cvoid}

# typedef void ( * WGPUProcCommandEncoderPopDebugGroup ) ( WGPUCommandEncoder commandEncoder )
const WGPUProcCommandEncoderPopDebugGroup = Ptr{Cvoid}

# typedef void ( * WGPUProcCommandEncoderPushDebugGroup ) ( WGPUCommandEncoder commandEncoder , WGPUStringView groupLabel )
const WGPUProcCommandEncoderPushDebugGroup = Ptr{Cvoid}

# typedef void ( * WGPUProcCommandEncoderResolveQuerySet ) ( WGPUCommandEncoder commandEncoder , WGPUQuerySet querySet , uint32_t firstQuery , uint32_t queryCount , WGPUBuffer destination , uint64_t destinationOffset )
const WGPUProcCommandEncoderResolveQuerySet = Ptr{Cvoid}

# typedef void ( * WGPUProcCommandEncoderSetLabel ) ( WGPUCommandEncoder commandEncoder , WGPUStringView label )
const WGPUProcCommandEncoderSetLabel = Ptr{Cvoid}

# typedef void ( * WGPUProcCommandEncoderWriteTimestamp ) ( WGPUCommandEncoder commandEncoder , WGPUQuerySet querySet , uint32_t queryIndex )
const WGPUProcCommandEncoderWriteTimestamp = Ptr{Cvoid}

# typedef void ( * WGPUProcCommandEncoderAddRef ) ( WGPUCommandEncoder commandEncoder )
const WGPUProcCommandEncoderAddRef = Ptr{Cvoid}

# typedef void ( * WGPUProcCommandEncoderRelease ) ( WGPUCommandEncoder commandEncoder )
const WGPUProcCommandEncoderRelease = Ptr{Cvoid}

# typedef void ( * WGPUProcComputePassEncoderDispatchWorkgroups ) ( WGPUComputePassEncoder computePassEncoder , uint32_t workgroupCountX , uint32_t workgroupCountY , uint32_t workgroupCountZ )
const WGPUProcComputePassEncoderDispatchWorkgroups = Ptr{Cvoid}

# typedef void ( * WGPUProcComputePassEncoderDispatchWorkgroupsIndirect ) ( WGPUComputePassEncoder computePassEncoder , WGPUBuffer indirectBuffer , uint64_t indirectOffset )
const WGPUProcComputePassEncoderDispatchWorkgroupsIndirect = Ptr{Cvoid}

# typedef void ( * WGPUProcComputePassEncoderEnd ) ( WGPUComputePassEncoder computePassEncoder )
const WGPUProcComputePassEncoderEnd = Ptr{Cvoid}

# typedef void ( * WGPUProcComputePassEncoderInsertDebugMarker ) ( WGPUComputePassEncoder computePassEncoder , WGPUStringView markerLabel )
const WGPUProcComputePassEncoderInsertDebugMarker = Ptr{Cvoid}

# typedef void ( * WGPUProcComputePassEncoderPopDebugGroup ) ( WGPUComputePassEncoder computePassEncoder )
const WGPUProcComputePassEncoderPopDebugGroup = Ptr{Cvoid}

# typedef void ( * WGPUProcComputePassEncoderPushDebugGroup ) ( WGPUComputePassEncoder computePassEncoder , WGPUStringView groupLabel )
const WGPUProcComputePassEncoderPushDebugGroup = Ptr{Cvoid}

# typedef void ( * WGPUProcComputePassEncoderSetBindGroup ) ( WGPUComputePassEncoder computePassEncoder , uint32_t groupIndex , WGPU_NULLABLE WGPUBindGroup group , size_t dynamicOffsetCount , uint32_t const * dynamicOffsets )
const WGPUProcComputePassEncoderSetBindGroup = Ptr{Cvoid}

# typedef void ( * WGPUProcComputePassEncoderSetLabel ) ( WGPUComputePassEncoder computePassEncoder , WGPUStringView label )
const WGPUProcComputePassEncoderSetLabel = Ptr{Cvoid}

# typedef void ( * WGPUProcComputePassEncoderSetPipeline ) ( WGPUComputePassEncoder computePassEncoder , WGPUComputePipeline pipeline )
const WGPUProcComputePassEncoderSetPipeline = Ptr{Cvoid}

# typedef void ( * WGPUProcComputePassEncoderAddRef ) ( WGPUComputePassEncoder computePassEncoder )
const WGPUProcComputePassEncoderAddRef = Ptr{Cvoid}

# typedef void ( * WGPUProcComputePassEncoderRelease ) ( WGPUComputePassEncoder computePassEncoder )
const WGPUProcComputePassEncoderRelease = Ptr{Cvoid}

# typedef WGPUBindGroupLayout ( * WGPUProcComputePipelineGetBindGroupLayout ) ( WGPUComputePipeline computePipeline , uint32_t groupIndex )
const WGPUProcComputePipelineGetBindGroupLayout = Ptr{Cvoid}

# typedef void ( * WGPUProcComputePipelineSetLabel ) ( WGPUComputePipeline computePipeline , WGPUStringView label )
const WGPUProcComputePipelineSetLabel = Ptr{Cvoid}

# typedef void ( * WGPUProcComputePipelineAddRef ) ( WGPUComputePipeline computePipeline )
const WGPUProcComputePipelineAddRef = Ptr{Cvoid}

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

# typedef WGPUFuture ( * WGPUProcDeviceCreateComputePipelineAsync ) ( WGPUDevice device , WGPUComputePipelineDescriptor const * descriptor , WGPUCreateComputePipelineAsyncCallbackInfo callbackInfo )
const WGPUProcDeviceCreateComputePipelineAsync = Ptr{Cvoid}

# typedef WGPUPipelineLayout ( * WGPUProcDeviceCreatePipelineLayout ) ( WGPUDevice device , WGPUPipelineLayoutDescriptor const * descriptor )
const WGPUProcDeviceCreatePipelineLayout = Ptr{Cvoid}

# typedef WGPUQuerySet ( * WGPUProcDeviceCreateQuerySet ) ( WGPUDevice device , WGPUQuerySetDescriptor const * descriptor )
const WGPUProcDeviceCreateQuerySet = Ptr{Cvoid}

# typedef WGPURenderBundleEncoder ( * WGPUProcDeviceCreateRenderBundleEncoder ) ( WGPUDevice device , WGPURenderBundleEncoderDescriptor const * descriptor )
const WGPUProcDeviceCreateRenderBundleEncoder = Ptr{Cvoid}

# typedef WGPURenderPipeline ( * WGPUProcDeviceCreateRenderPipeline ) ( WGPUDevice device , WGPURenderPipelineDescriptor const * descriptor )
const WGPUProcDeviceCreateRenderPipeline = Ptr{Cvoid}

# typedef WGPUFuture ( * WGPUProcDeviceCreateRenderPipelineAsync ) ( WGPUDevice device , WGPURenderPipelineDescriptor const * descriptor , WGPUCreateRenderPipelineAsyncCallbackInfo callbackInfo )
const WGPUProcDeviceCreateRenderPipelineAsync = Ptr{Cvoid}

# typedef WGPUSampler ( * WGPUProcDeviceCreateSampler ) ( WGPUDevice device , WGPU_NULLABLE WGPUSamplerDescriptor const * descriptor )
const WGPUProcDeviceCreateSampler = Ptr{Cvoid}

# typedef WGPUShaderModule ( * WGPUProcDeviceCreateShaderModule ) ( WGPUDevice device , WGPUShaderModuleDescriptor const * descriptor )
const WGPUProcDeviceCreateShaderModule = Ptr{Cvoid}

# typedef WGPUTexture ( * WGPUProcDeviceCreateTexture ) ( WGPUDevice device , WGPUTextureDescriptor const * descriptor )
const WGPUProcDeviceCreateTexture = Ptr{Cvoid}

# typedef void ( * WGPUProcDeviceDestroy ) ( WGPUDevice device )
const WGPUProcDeviceDestroy = Ptr{Cvoid}

# typedef WGPUAdapterInfo ( * WGPUProcDeviceGetAdapterInfo ) ( WGPUDevice device )
const WGPUProcDeviceGetAdapterInfo = Ptr{Cvoid}

# typedef void ( * WGPUProcDeviceGetFeatures ) ( WGPUDevice device , WGPUSupportedFeatures * features )
const WGPUProcDeviceGetFeatures = Ptr{Cvoid}

# typedef WGPUStatus ( * WGPUProcDeviceGetLimits ) ( WGPUDevice device , WGPULimits * limits )
const WGPUProcDeviceGetLimits = Ptr{Cvoid}

# typedef WGPUFuture ( * WGPUProcDeviceGetLostFuture ) ( WGPUDevice device )
const WGPUProcDeviceGetLostFuture = Ptr{Cvoid}

# typedef WGPUQueue ( * WGPUProcDeviceGetQueue ) ( WGPUDevice device )
const WGPUProcDeviceGetQueue = Ptr{Cvoid}

# typedef WGPUBool ( * WGPUProcDeviceHasFeature ) ( WGPUDevice device , WGPUFeatureName feature )
const WGPUProcDeviceHasFeature = Ptr{Cvoid}

# typedef WGPUFuture ( * WGPUProcDevicePopErrorScope ) ( WGPUDevice device , WGPUPopErrorScopeCallbackInfo callbackInfo )
const WGPUProcDevicePopErrorScope = Ptr{Cvoid}

# typedef void ( * WGPUProcDevicePushErrorScope ) ( WGPUDevice device , WGPUErrorFilter filter )
const WGPUProcDevicePushErrorScope = Ptr{Cvoid}

# typedef void ( * WGPUProcDeviceSetLabel ) ( WGPUDevice device , WGPUStringView label )
const WGPUProcDeviceSetLabel = Ptr{Cvoid}

# typedef void ( * WGPUProcDeviceAddRef ) ( WGPUDevice device )
const WGPUProcDeviceAddRef = Ptr{Cvoid}

# typedef void ( * WGPUProcDeviceRelease ) ( WGPUDevice device )
const WGPUProcDeviceRelease = Ptr{Cvoid}

# typedef WGPUSurface ( * WGPUProcInstanceCreateSurface ) ( WGPUInstance instance , WGPUSurfaceDescriptor const * descriptor )
const WGPUProcInstanceCreateSurface = Ptr{Cvoid}

# typedef WGPUStatus ( * WGPUProcInstanceGetWGSLLanguageFeatures ) ( WGPUInstance instance , WGPUSupportedWGSLLanguageFeatures * features )
const WGPUProcInstanceGetWGSLLanguageFeatures = Ptr{Cvoid}

# typedef WGPUBool ( * WGPUProcInstanceHasWGSLLanguageFeature ) ( WGPUInstance instance , WGPUWGSLLanguageFeatureName feature )
const WGPUProcInstanceHasWGSLLanguageFeature = Ptr{Cvoid}

# typedef void ( * WGPUProcInstanceProcessEvents ) ( WGPUInstance instance )
const WGPUProcInstanceProcessEvents = Ptr{Cvoid}

# typedef WGPUFuture ( * WGPUProcInstanceRequestAdapter ) ( WGPUInstance instance , WGPU_NULLABLE WGPURequestAdapterOptions const * options , WGPURequestAdapterCallbackInfo callbackInfo )
const WGPUProcInstanceRequestAdapter = Ptr{Cvoid}

# typedef WGPUWaitStatus ( * WGPUProcInstanceWaitAny ) ( WGPUInstance instance , size_t futureCount , WGPU_NULLABLE WGPUFutureWaitInfo * futures , uint64_t timeoutNS )
const WGPUProcInstanceWaitAny = Ptr{Cvoid}

# typedef void ( * WGPUProcInstanceAddRef ) ( WGPUInstance instance )
const WGPUProcInstanceAddRef = Ptr{Cvoid}

# typedef void ( * WGPUProcInstanceRelease ) ( WGPUInstance instance )
const WGPUProcInstanceRelease = Ptr{Cvoid}

# typedef void ( * WGPUProcPipelineLayoutSetLabel ) ( WGPUPipelineLayout pipelineLayout , WGPUStringView label )
const WGPUProcPipelineLayoutSetLabel = Ptr{Cvoid}

# typedef void ( * WGPUProcPipelineLayoutAddRef ) ( WGPUPipelineLayout pipelineLayout )
const WGPUProcPipelineLayoutAddRef = Ptr{Cvoid}

# typedef void ( * WGPUProcPipelineLayoutRelease ) ( WGPUPipelineLayout pipelineLayout )
const WGPUProcPipelineLayoutRelease = Ptr{Cvoid}

# typedef void ( * WGPUProcQuerySetDestroy ) ( WGPUQuerySet querySet )
const WGPUProcQuerySetDestroy = Ptr{Cvoid}

# typedef uint32_t ( * WGPUProcQuerySetGetCount ) ( WGPUQuerySet querySet )
const WGPUProcQuerySetGetCount = Ptr{Cvoid}

# typedef WGPUQueryType ( * WGPUProcQuerySetGetType ) ( WGPUQuerySet querySet )
const WGPUProcQuerySetGetType = Ptr{Cvoid}

# typedef void ( * WGPUProcQuerySetSetLabel ) ( WGPUQuerySet querySet , WGPUStringView label )
const WGPUProcQuerySetSetLabel = Ptr{Cvoid}

# typedef void ( * WGPUProcQuerySetAddRef ) ( WGPUQuerySet querySet )
const WGPUProcQuerySetAddRef = Ptr{Cvoid}

# typedef void ( * WGPUProcQuerySetRelease ) ( WGPUQuerySet querySet )
const WGPUProcQuerySetRelease = Ptr{Cvoid}

# typedef WGPUFuture ( * WGPUProcQueueOnSubmittedWorkDone ) ( WGPUQueue queue , WGPUQueueWorkDoneCallbackInfo callbackInfo )
const WGPUProcQueueOnSubmittedWorkDone = Ptr{Cvoid}

# typedef void ( * WGPUProcQueueSetLabel ) ( WGPUQueue queue , WGPUStringView label )
const WGPUProcQueueSetLabel = Ptr{Cvoid}

# typedef void ( * WGPUProcQueueSubmit ) ( WGPUQueue queue , size_t commandCount , WGPUCommandBuffer const * commands )
const WGPUProcQueueSubmit = Ptr{Cvoid}

# typedef void ( * WGPUProcQueueWriteBuffer ) ( WGPUQueue queue , WGPUBuffer buffer , uint64_t bufferOffset , void const * data , size_t size )
const WGPUProcQueueWriteBuffer = Ptr{Cvoid}

# typedef void ( * WGPUProcQueueWriteTexture ) ( WGPUQueue queue , WGPUTexelCopyTextureInfo const * destination , void const * data , size_t dataSize , WGPUTexelCopyBufferLayout const * dataLayout , WGPUExtent3D const * writeSize )
const WGPUProcQueueWriteTexture = Ptr{Cvoid}

# typedef void ( * WGPUProcQueueAddRef ) ( WGPUQueue queue )
const WGPUProcQueueAddRef = Ptr{Cvoid}

# typedef void ( * WGPUProcQueueRelease ) ( WGPUQueue queue )
const WGPUProcQueueRelease = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderBundleSetLabel ) ( WGPURenderBundle renderBundle , WGPUStringView label )
const WGPUProcRenderBundleSetLabel = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderBundleAddRef ) ( WGPURenderBundle renderBundle )
const WGPUProcRenderBundleAddRef = Ptr{Cvoid}

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

# typedef void ( * WGPUProcRenderBundleEncoderInsertDebugMarker ) ( WGPURenderBundleEncoder renderBundleEncoder , WGPUStringView markerLabel )
const WGPUProcRenderBundleEncoderInsertDebugMarker = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderBundleEncoderPopDebugGroup ) ( WGPURenderBundleEncoder renderBundleEncoder )
const WGPUProcRenderBundleEncoderPopDebugGroup = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderBundleEncoderPushDebugGroup ) ( WGPURenderBundleEncoder renderBundleEncoder , WGPUStringView groupLabel )
const WGPUProcRenderBundleEncoderPushDebugGroup = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderBundleEncoderSetBindGroup ) ( WGPURenderBundleEncoder renderBundleEncoder , uint32_t groupIndex , WGPU_NULLABLE WGPUBindGroup group , size_t dynamicOffsetCount , uint32_t const * dynamicOffsets )
const WGPUProcRenderBundleEncoderSetBindGroup = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderBundleEncoderSetIndexBuffer ) ( WGPURenderBundleEncoder renderBundleEncoder , WGPUBuffer buffer , WGPUIndexFormat format , uint64_t offset , uint64_t size )
const WGPUProcRenderBundleEncoderSetIndexBuffer = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderBundleEncoderSetLabel ) ( WGPURenderBundleEncoder renderBundleEncoder , WGPUStringView label )
const WGPUProcRenderBundleEncoderSetLabel = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderBundleEncoderSetPipeline ) ( WGPURenderBundleEncoder renderBundleEncoder , WGPURenderPipeline pipeline )
const WGPUProcRenderBundleEncoderSetPipeline = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderBundleEncoderSetVertexBuffer ) ( WGPURenderBundleEncoder renderBundleEncoder , uint32_t slot , WGPU_NULLABLE WGPUBuffer buffer , uint64_t offset , uint64_t size )
const WGPUProcRenderBundleEncoderSetVertexBuffer = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderBundleEncoderAddRef ) ( WGPURenderBundleEncoder renderBundleEncoder )
const WGPUProcRenderBundleEncoderAddRef = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderBundleEncoderRelease ) ( WGPURenderBundleEncoder renderBundleEncoder )
const WGPUProcRenderBundleEncoderRelease = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderPassEncoderBeginOcclusionQuery ) ( WGPURenderPassEncoder renderPassEncoder , uint32_t queryIndex )
const WGPUProcRenderPassEncoderBeginOcclusionQuery = Ptr{Cvoid}

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

# typedef void ( * WGPUProcRenderPassEncoderExecuteBundles ) ( WGPURenderPassEncoder renderPassEncoder , size_t bundleCount , WGPURenderBundle const * bundles )
const WGPUProcRenderPassEncoderExecuteBundles = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderPassEncoderInsertDebugMarker ) ( WGPURenderPassEncoder renderPassEncoder , WGPUStringView markerLabel )
const WGPUProcRenderPassEncoderInsertDebugMarker = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderPassEncoderPopDebugGroup ) ( WGPURenderPassEncoder renderPassEncoder )
const WGPUProcRenderPassEncoderPopDebugGroup = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderPassEncoderPushDebugGroup ) ( WGPURenderPassEncoder renderPassEncoder , WGPUStringView groupLabel )
const WGPUProcRenderPassEncoderPushDebugGroup = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderPassEncoderSetBindGroup ) ( WGPURenderPassEncoder renderPassEncoder , uint32_t groupIndex , WGPU_NULLABLE WGPUBindGroup group , size_t dynamicOffsetCount , uint32_t const * dynamicOffsets )
const WGPUProcRenderPassEncoderSetBindGroup = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderPassEncoderSetBlendConstant ) ( WGPURenderPassEncoder renderPassEncoder , WGPUColor const * color )
const WGPUProcRenderPassEncoderSetBlendConstant = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderPassEncoderSetIndexBuffer ) ( WGPURenderPassEncoder renderPassEncoder , WGPUBuffer buffer , WGPUIndexFormat format , uint64_t offset , uint64_t size )
const WGPUProcRenderPassEncoderSetIndexBuffer = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderPassEncoderSetLabel ) ( WGPURenderPassEncoder renderPassEncoder , WGPUStringView label )
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

# typedef void ( * WGPUProcRenderPassEncoderAddRef ) ( WGPURenderPassEncoder renderPassEncoder )
const WGPUProcRenderPassEncoderAddRef = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderPassEncoderRelease ) ( WGPURenderPassEncoder renderPassEncoder )
const WGPUProcRenderPassEncoderRelease = Ptr{Cvoid}

# typedef WGPUBindGroupLayout ( * WGPUProcRenderPipelineGetBindGroupLayout ) ( WGPURenderPipeline renderPipeline , uint32_t groupIndex )
const WGPUProcRenderPipelineGetBindGroupLayout = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderPipelineSetLabel ) ( WGPURenderPipeline renderPipeline , WGPUStringView label )
const WGPUProcRenderPipelineSetLabel = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderPipelineAddRef ) ( WGPURenderPipeline renderPipeline )
const WGPUProcRenderPipelineAddRef = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderPipelineRelease ) ( WGPURenderPipeline renderPipeline )
const WGPUProcRenderPipelineRelease = Ptr{Cvoid}

# typedef void ( * WGPUProcSamplerSetLabel ) ( WGPUSampler sampler , WGPUStringView label )
const WGPUProcSamplerSetLabel = Ptr{Cvoid}

# typedef void ( * WGPUProcSamplerAddRef ) ( WGPUSampler sampler )
const WGPUProcSamplerAddRef = Ptr{Cvoid}

# typedef void ( * WGPUProcSamplerRelease ) ( WGPUSampler sampler )
const WGPUProcSamplerRelease = Ptr{Cvoid}

# typedef WGPUFuture ( * WGPUProcShaderModuleGetCompilationInfo ) ( WGPUShaderModule shaderModule , WGPUCompilationInfoCallbackInfo callbackInfo )
const WGPUProcShaderModuleGetCompilationInfo = Ptr{Cvoid}

# typedef void ( * WGPUProcShaderModuleSetLabel ) ( WGPUShaderModule shaderModule , WGPUStringView label )
const WGPUProcShaderModuleSetLabel = Ptr{Cvoid}

# typedef void ( * WGPUProcShaderModuleAddRef ) ( WGPUShaderModule shaderModule )
const WGPUProcShaderModuleAddRef = Ptr{Cvoid}

# typedef void ( * WGPUProcShaderModuleRelease ) ( WGPUShaderModule shaderModule )
const WGPUProcShaderModuleRelease = Ptr{Cvoid}

# typedef void ( * WGPUProcSupportedFeaturesFreeMembers ) ( WGPUSupportedFeatures supportedFeatures )
const WGPUProcSupportedFeaturesFreeMembers = Ptr{Cvoid}

# typedef void ( * WGPUProcSupportedWGSLLanguageFeaturesFreeMembers ) ( WGPUSupportedWGSLLanguageFeatures supportedWGSLLanguageFeatures )
const WGPUProcSupportedWGSLLanguageFeaturesFreeMembers = Ptr{Cvoid}

# typedef void ( * WGPUProcSurfaceConfigure ) ( WGPUSurface surface , WGPUSurfaceConfiguration const * config )
const WGPUProcSurfaceConfigure = Ptr{Cvoid}

# typedef WGPUStatus ( * WGPUProcSurfaceGetCapabilities ) ( WGPUSurface surface , WGPUAdapter adapter , WGPUSurfaceCapabilities * capabilities )
const WGPUProcSurfaceGetCapabilities = Ptr{Cvoid}

# typedef void ( * WGPUProcSurfaceGetCurrentTexture ) ( WGPUSurface surface , WGPUSurfaceTexture * surfaceTexture )
const WGPUProcSurfaceGetCurrentTexture = Ptr{Cvoid}

# typedef WGPUStatus ( * WGPUProcSurfacePresent ) ( WGPUSurface surface )
const WGPUProcSurfacePresent = Ptr{Cvoid}

# typedef void ( * WGPUProcSurfaceSetLabel ) ( WGPUSurface surface , WGPUStringView label )
const WGPUProcSurfaceSetLabel = Ptr{Cvoid}

# typedef void ( * WGPUProcSurfaceUnconfigure ) ( WGPUSurface surface )
const WGPUProcSurfaceUnconfigure = Ptr{Cvoid}

# typedef void ( * WGPUProcSurfaceAddRef ) ( WGPUSurface surface )
const WGPUProcSurfaceAddRef = Ptr{Cvoid}

# typedef void ( * WGPUProcSurfaceRelease ) ( WGPUSurface surface )
const WGPUProcSurfaceRelease = Ptr{Cvoid}

# typedef void ( * WGPUProcSurfaceCapabilitiesFreeMembers ) ( WGPUSurfaceCapabilities surfaceCapabilities )
const WGPUProcSurfaceCapabilitiesFreeMembers = Ptr{Cvoid}

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

# typedef WGPUTextureUsage ( * WGPUProcTextureGetUsage ) ( WGPUTexture texture )
const WGPUProcTextureGetUsage = Ptr{Cvoid}

# typedef uint32_t ( * WGPUProcTextureGetWidth ) ( WGPUTexture texture )
const WGPUProcTextureGetWidth = Ptr{Cvoid}

# typedef void ( * WGPUProcTextureSetLabel ) ( WGPUTexture texture , WGPUStringView label )
const WGPUProcTextureSetLabel = Ptr{Cvoid}

# typedef void ( * WGPUProcTextureAddRef ) ( WGPUTexture texture )
const WGPUProcTextureAddRef = Ptr{Cvoid}

# typedef void ( * WGPUProcTextureRelease ) ( WGPUTexture texture )
const WGPUProcTextureRelease = Ptr{Cvoid}

# typedef void ( * WGPUProcTextureViewSetLabel ) ( WGPUTextureView textureView , WGPUStringView label )
const WGPUProcTextureViewSetLabel = Ptr{Cvoid}

# typedef void ( * WGPUProcTextureViewAddRef ) ( WGPUTextureView textureView )
const WGPUProcTextureViewAddRef = Ptr{Cvoid}

# typedef void ( * WGPUProcTextureViewRelease ) ( WGPUTextureView textureView )
const WGPUProcTextureViewRelease = Ptr{Cvoid}

function wgpuCreateInstance(descriptor)
    @ccall libWGPU.wgpuCreateInstance(descriptor::Ptr{WGPUInstanceDescriptor})::WGPUInstance
end

function wgpuGetInstanceCapabilities(capabilities)
    @ccall libWGPU.wgpuGetInstanceCapabilities(capabilities::Ptr{WGPUInstanceCapabilities})::WGPUStatus
end

function wgpuGetProcAddress(procName)
    @ccall libWGPU.wgpuGetProcAddress(procName::WGPUStringView)::WGPUProc
end

function wgpuAdapterGetFeatures(adapter, features)
    @ccall libWGPU.wgpuAdapterGetFeatures(adapter::WGPUAdapter, features::Ptr{WGPUSupportedFeatures})::Cvoid
end

function wgpuAdapterGetInfo(adapter, info)
    @ccall libWGPU.wgpuAdapterGetInfo(adapter::WGPUAdapter, info::Ptr{WGPUAdapterInfo})::WGPUStatus
end

function wgpuAdapterGetLimits(adapter, limits)
    @ccall libWGPU.wgpuAdapterGetLimits(adapter::WGPUAdapter, limits::Ptr{WGPULimits})::WGPUStatus
end

function wgpuAdapterHasFeature(adapter, feature)
    @ccall libWGPU.wgpuAdapterHasFeature(adapter::WGPUAdapter, feature::WGPUFeatureName)::WGPUBool
end

function wgpuAdapterRequestDevice(adapter, descriptor, callbackInfo)
    @ccall libWGPU.wgpuAdapterRequestDevice(adapter::WGPUAdapter, descriptor::Ptr{WGPUDeviceDescriptor}, callbackInfo::WGPURequestDeviceCallbackInfo)::WGPUFuture
end

function wgpuAdapterAddRef(adapter)
    @ccall libWGPU.wgpuAdapterAddRef(adapter::WGPUAdapter)::Cvoid
end

function wgpuAdapterRelease(adapter)
    @ccall libWGPU.wgpuAdapterRelease(adapter::WGPUAdapter)::Cvoid
end

function wgpuAdapterInfoFreeMembers(adapterInfo)
    @ccall libWGPU.wgpuAdapterInfoFreeMembers(adapterInfo::WGPUAdapterInfo)::Cvoid
end

function wgpuBindGroupSetLabel(bindGroup, label)
    @ccall libWGPU.wgpuBindGroupSetLabel(bindGroup::WGPUBindGroup, label::WGPUStringView)::Cvoid
end

function wgpuBindGroupAddRef(bindGroup)
    @ccall libWGPU.wgpuBindGroupAddRef(bindGroup::WGPUBindGroup)::Cvoid
end

function wgpuBindGroupRelease(bindGroup)
    @ccall libWGPU.wgpuBindGroupRelease(bindGroup::WGPUBindGroup)::Cvoid
end

function wgpuBindGroupLayoutSetLabel(bindGroupLayout, label)
    @ccall libWGPU.wgpuBindGroupLayoutSetLabel(bindGroupLayout::WGPUBindGroupLayout, label::WGPUStringView)::Cvoid
end

function wgpuBindGroupLayoutAddRef(bindGroupLayout)
    @ccall libWGPU.wgpuBindGroupLayoutAddRef(bindGroupLayout::WGPUBindGroupLayout)::Cvoid
end

function wgpuBindGroupLayoutRelease(bindGroupLayout)
    @ccall libWGPU.wgpuBindGroupLayoutRelease(bindGroupLayout::WGPUBindGroupLayout)::Cvoid
end

function wgpuBufferDestroy(buffer)
    @ccall libWGPU.wgpuBufferDestroy(buffer::WGPUBuffer)::Cvoid
end

function wgpuBufferGetConstMappedRange(buffer, offset, size)
    @ccall libWGPU.wgpuBufferGetConstMappedRange(buffer::WGPUBuffer, offset::Csize_t, size::Csize_t)::Ptr{Cvoid}
end

function wgpuBufferGetMapState(buffer)
    @ccall libWGPU.wgpuBufferGetMapState(buffer::WGPUBuffer)::WGPUBufferMapState
end

function wgpuBufferGetMappedRange(buffer, offset, size)
    @ccall libWGPU.wgpuBufferGetMappedRange(buffer::WGPUBuffer, offset::Csize_t, size::Csize_t)::Ptr{Cvoid}
end

function wgpuBufferGetSize(buffer)
    @ccall libWGPU.wgpuBufferGetSize(buffer::WGPUBuffer)::UInt64
end

function wgpuBufferGetUsage(buffer)
    @ccall libWGPU.wgpuBufferGetUsage(buffer::WGPUBuffer)::WGPUBufferUsage
end

function wgpuBufferMapAsync(buffer, mode, offset, size, callbackInfo)
    @ccall libWGPU.wgpuBufferMapAsync(buffer::WGPUBuffer, mode::WGPUMapMode, offset::Csize_t, size::Csize_t, callbackInfo::WGPUBufferMapCallbackInfo)::WGPUFuture
end

function wgpuBufferSetLabel(buffer, label)
    @ccall libWGPU.wgpuBufferSetLabel(buffer::WGPUBuffer, label::WGPUStringView)::Cvoid
end

function wgpuBufferUnmap(buffer)
    @ccall libWGPU.wgpuBufferUnmap(buffer::WGPUBuffer)::Cvoid
end

function wgpuBufferAddRef(buffer)
    @ccall libWGPU.wgpuBufferAddRef(buffer::WGPUBuffer)::Cvoid
end

function wgpuBufferRelease(buffer)
    @ccall libWGPU.wgpuBufferRelease(buffer::WGPUBuffer)::Cvoid
end

function wgpuCommandBufferSetLabel(commandBuffer, label)
    @ccall libWGPU.wgpuCommandBufferSetLabel(commandBuffer::WGPUCommandBuffer, label::WGPUStringView)::Cvoid
end

function wgpuCommandBufferAddRef(commandBuffer)
    @ccall libWGPU.wgpuCommandBufferAddRef(commandBuffer::WGPUCommandBuffer)::Cvoid
end

function wgpuCommandBufferRelease(commandBuffer)
    @ccall libWGPU.wgpuCommandBufferRelease(commandBuffer::WGPUCommandBuffer)::Cvoid
end

function wgpuCommandEncoderBeginComputePass(commandEncoder, descriptor)
    @ccall libWGPU.wgpuCommandEncoderBeginComputePass(commandEncoder::WGPUCommandEncoder, descriptor::Ptr{WGPUComputePassDescriptor})::WGPUComputePassEncoder
end

function wgpuCommandEncoderBeginRenderPass(commandEncoder, descriptor)
    @ccall libWGPU.wgpuCommandEncoderBeginRenderPass(commandEncoder::WGPUCommandEncoder, descriptor::Ptr{WGPURenderPassDescriptor})::WGPURenderPassEncoder
end

function wgpuCommandEncoderClearBuffer(commandEncoder, buffer, offset, size)
    @ccall libWGPU.wgpuCommandEncoderClearBuffer(commandEncoder::WGPUCommandEncoder, buffer::WGPUBuffer, offset::UInt64, size::UInt64)::Cvoid
end

function wgpuCommandEncoderCopyBufferToBuffer(commandEncoder, source, sourceOffset, destination, destinationOffset, size)
    @ccall libWGPU.wgpuCommandEncoderCopyBufferToBuffer(commandEncoder::WGPUCommandEncoder, source::WGPUBuffer, sourceOffset::UInt64, destination::WGPUBuffer, destinationOffset::UInt64, size::UInt64)::Cvoid
end

function wgpuCommandEncoderCopyBufferToTexture(commandEncoder, source, destination, copySize)
    @ccall libWGPU.wgpuCommandEncoderCopyBufferToTexture(commandEncoder::WGPUCommandEncoder, source::Ptr{WGPUTexelCopyBufferInfo}, destination::Ptr{WGPUTexelCopyTextureInfo}, copySize::Ptr{WGPUExtent3D})::Cvoid
end

function wgpuCommandEncoderCopyTextureToBuffer(commandEncoder, source, destination, copySize)
    @ccall libWGPU.wgpuCommandEncoderCopyTextureToBuffer(commandEncoder::WGPUCommandEncoder, source::Ptr{WGPUTexelCopyTextureInfo}, destination::Ptr{WGPUTexelCopyBufferInfo}, copySize::Ptr{WGPUExtent3D})::Cvoid
end

function wgpuCommandEncoderCopyTextureToTexture(commandEncoder, source, destination, copySize)
    @ccall libWGPU.wgpuCommandEncoderCopyTextureToTexture(commandEncoder::WGPUCommandEncoder, source::Ptr{WGPUTexelCopyTextureInfo}, destination::Ptr{WGPUTexelCopyTextureInfo}, copySize::Ptr{WGPUExtent3D})::Cvoid
end

function wgpuCommandEncoderFinish(commandEncoder, descriptor)
    @ccall libWGPU.wgpuCommandEncoderFinish(commandEncoder::WGPUCommandEncoder, descriptor::Ptr{WGPUCommandBufferDescriptor})::WGPUCommandBuffer
end

function wgpuCommandEncoderInsertDebugMarker(commandEncoder, markerLabel)
    @ccall libWGPU.wgpuCommandEncoderInsertDebugMarker(commandEncoder::WGPUCommandEncoder, markerLabel::WGPUStringView)::Cvoid
end

function wgpuCommandEncoderPopDebugGroup(commandEncoder)
    @ccall libWGPU.wgpuCommandEncoderPopDebugGroup(commandEncoder::WGPUCommandEncoder)::Cvoid
end

function wgpuCommandEncoderPushDebugGroup(commandEncoder, groupLabel)
    @ccall libWGPU.wgpuCommandEncoderPushDebugGroup(commandEncoder::WGPUCommandEncoder, groupLabel::WGPUStringView)::Cvoid
end

function wgpuCommandEncoderResolveQuerySet(commandEncoder, querySet, firstQuery, queryCount, destination, destinationOffset)
    @ccall libWGPU.wgpuCommandEncoderResolveQuerySet(commandEncoder::WGPUCommandEncoder, querySet::WGPUQuerySet, firstQuery::UInt32, queryCount::UInt32, destination::WGPUBuffer, destinationOffset::UInt64)::Cvoid
end

function wgpuCommandEncoderSetLabel(commandEncoder, label)
    @ccall libWGPU.wgpuCommandEncoderSetLabel(commandEncoder::WGPUCommandEncoder, label::WGPUStringView)::Cvoid
end

function wgpuCommandEncoderWriteTimestamp(commandEncoder, querySet, queryIndex)
    @ccall libWGPU.wgpuCommandEncoderWriteTimestamp(commandEncoder::WGPUCommandEncoder, querySet::WGPUQuerySet, queryIndex::UInt32)::Cvoid
end

function wgpuCommandEncoderAddRef(commandEncoder)
    @ccall libWGPU.wgpuCommandEncoderAddRef(commandEncoder::WGPUCommandEncoder)::Cvoid
end

function wgpuCommandEncoderRelease(commandEncoder)
    @ccall libWGPU.wgpuCommandEncoderRelease(commandEncoder::WGPUCommandEncoder)::Cvoid
end

function wgpuComputePassEncoderDispatchWorkgroups(computePassEncoder, workgroupCountX, workgroupCountY, workgroupCountZ)
    @ccall libWGPU.wgpuComputePassEncoderDispatchWorkgroups(computePassEncoder::WGPUComputePassEncoder, workgroupCountX::UInt32, workgroupCountY::UInt32, workgroupCountZ::UInt32)::Cvoid
end

function wgpuComputePassEncoderDispatchWorkgroupsIndirect(computePassEncoder, indirectBuffer, indirectOffset)
    @ccall libWGPU.wgpuComputePassEncoderDispatchWorkgroupsIndirect(computePassEncoder::WGPUComputePassEncoder, indirectBuffer::WGPUBuffer, indirectOffset::UInt64)::Cvoid
end

function wgpuComputePassEncoderEnd(computePassEncoder)
    @ccall libWGPU.wgpuComputePassEncoderEnd(computePassEncoder::WGPUComputePassEncoder)::Cvoid
end

function wgpuComputePassEncoderInsertDebugMarker(computePassEncoder, markerLabel)
    @ccall libWGPU.wgpuComputePassEncoderInsertDebugMarker(computePassEncoder::WGPUComputePassEncoder, markerLabel::WGPUStringView)::Cvoid
end

function wgpuComputePassEncoderPopDebugGroup(computePassEncoder)
    @ccall libWGPU.wgpuComputePassEncoderPopDebugGroup(computePassEncoder::WGPUComputePassEncoder)::Cvoid
end

function wgpuComputePassEncoderPushDebugGroup(computePassEncoder, groupLabel)
    @ccall libWGPU.wgpuComputePassEncoderPushDebugGroup(computePassEncoder::WGPUComputePassEncoder, groupLabel::WGPUStringView)::Cvoid
end

function wgpuComputePassEncoderSetBindGroup(computePassEncoder, groupIndex, group, dynamicOffsetCount, dynamicOffsets)
    @ccall libWGPU.wgpuComputePassEncoderSetBindGroup(computePassEncoder::WGPUComputePassEncoder, groupIndex::UInt32, group::WGPUBindGroup, dynamicOffsetCount::Csize_t, dynamicOffsets::Ptr{UInt32})::Cvoid
end

function wgpuComputePassEncoderSetLabel(computePassEncoder, label)
    @ccall libWGPU.wgpuComputePassEncoderSetLabel(computePassEncoder::WGPUComputePassEncoder, label::WGPUStringView)::Cvoid
end

function wgpuComputePassEncoderSetPipeline(computePassEncoder, pipeline)
    @ccall libWGPU.wgpuComputePassEncoderSetPipeline(computePassEncoder::WGPUComputePassEncoder, pipeline::WGPUComputePipeline)::Cvoid
end

function wgpuComputePassEncoderAddRef(computePassEncoder)
    @ccall libWGPU.wgpuComputePassEncoderAddRef(computePassEncoder::WGPUComputePassEncoder)::Cvoid
end

function wgpuComputePassEncoderRelease(computePassEncoder)
    @ccall libWGPU.wgpuComputePassEncoderRelease(computePassEncoder::WGPUComputePassEncoder)::Cvoid
end

function wgpuComputePipelineGetBindGroupLayout(computePipeline, groupIndex)
    @ccall libWGPU.wgpuComputePipelineGetBindGroupLayout(computePipeline::WGPUComputePipeline, groupIndex::UInt32)::WGPUBindGroupLayout
end

function wgpuComputePipelineSetLabel(computePipeline, label)
    @ccall libWGPU.wgpuComputePipelineSetLabel(computePipeline::WGPUComputePipeline, label::WGPUStringView)::Cvoid
end

function wgpuComputePipelineAddRef(computePipeline)
    @ccall libWGPU.wgpuComputePipelineAddRef(computePipeline::WGPUComputePipeline)::Cvoid
end

function wgpuComputePipelineRelease(computePipeline)
    @ccall libWGPU.wgpuComputePipelineRelease(computePipeline::WGPUComputePipeline)::Cvoid
end

function wgpuDeviceCreateBindGroup(device, descriptor)
    @ccall libWGPU.wgpuDeviceCreateBindGroup(device::WGPUDevice, descriptor::Ptr{WGPUBindGroupDescriptor})::WGPUBindGroup
end

function wgpuDeviceCreateBindGroupLayout(device, descriptor)
    @ccall libWGPU.wgpuDeviceCreateBindGroupLayout(device::WGPUDevice, descriptor::Ptr{WGPUBindGroupLayoutDescriptor})::WGPUBindGroupLayout
end

function wgpuDeviceCreateBuffer(device, descriptor)
    @ccall libWGPU.wgpuDeviceCreateBuffer(device::WGPUDevice, descriptor::Ptr{WGPUBufferDescriptor})::WGPUBuffer
end

function wgpuDeviceCreateCommandEncoder(device, descriptor)
    @ccall libWGPU.wgpuDeviceCreateCommandEncoder(device::WGPUDevice, descriptor::Ptr{WGPUCommandEncoderDescriptor})::WGPUCommandEncoder
end

function wgpuDeviceCreateComputePipeline(device, descriptor)
    @ccall libWGPU.wgpuDeviceCreateComputePipeline(device::WGPUDevice, descriptor::Ptr{WGPUComputePipelineDescriptor})::WGPUComputePipeline
end

function wgpuDeviceCreateComputePipelineAsync(device, descriptor, callbackInfo)
    @ccall libWGPU.wgpuDeviceCreateComputePipelineAsync(device::WGPUDevice, descriptor::Ptr{WGPUComputePipelineDescriptor}, callbackInfo::WGPUCreateComputePipelineAsyncCallbackInfo)::WGPUFuture
end

function wgpuDeviceCreatePipelineLayout(device, descriptor)
    @ccall libWGPU.wgpuDeviceCreatePipelineLayout(device::WGPUDevice, descriptor::Ptr{WGPUPipelineLayoutDescriptor})::WGPUPipelineLayout
end

function wgpuDeviceCreateQuerySet(device, descriptor)
    @ccall libWGPU.wgpuDeviceCreateQuerySet(device::WGPUDevice, descriptor::Ptr{WGPUQuerySetDescriptor})::WGPUQuerySet
end

function wgpuDeviceCreateRenderBundleEncoder(device, descriptor)
    @ccall libWGPU.wgpuDeviceCreateRenderBundleEncoder(device::WGPUDevice, descriptor::Ptr{WGPURenderBundleEncoderDescriptor})::WGPURenderBundleEncoder
end

function wgpuDeviceCreateRenderPipeline(device, descriptor)
    @ccall libWGPU.wgpuDeviceCreateRenderPipeline(device::WGPUDevice, descriptor::Ptr{WGPURenderPipelineDescriptor})::WGPURenderPipeline
end

function wgpuDeviceCreateRenderPipelineAsync(device, descriptor, callbackInfo)
    @ccall libWGPU.wgpuDeviceCreateRenderPipelineAsync(device::WGPUDevice, descriptor::Ptr{WGPURenderPipelineDescriptor}, callbackInfo::WGPUCreateRenderPipelineAsyncCallbackInfo)::WGPUFuture
end

function wgpuDeviceCreateSampler(device, descriptor)
    @ccall libWGPU.wgpuDeviceCreateSampler(device::WGPUDevice, descriptor::Ptr{WGPUSamplerDescriptor})::WGPUSampler
end

function wgpuDeviceCreateShaderModule(device, descriptor)
    @ccall libWGPU.wgpuDeviceCreateShaderModule(device::WGPUDevice, descriptor::Ptr{WGPUShaderModuleDescriptor})::WGPUShaderModule
end

function wgpuDeviceCreateTexture(device, descriptor)
    @ccall libWGPU.wgpuDeviceCreateTexture(device::WGPUDevice, descriptor::Ptr{WGPUTextureDescriptor})::WGPUTexture
end

function wgpuDeviceDestroy(device)
    @ccall libWGPU.wgpuDeviceDestroy(device::WGPUDevice)::Cvoid
end

function wgpuDeviceGetAdapterInfo(device)
    @ccall libWGPU.wgpuDeviceGetAdapterInfo(device::WGPUDevice)::WGPUAdapterInfo
end

function wgpuDeviceGetFeatures(device, features)
    @ccall libWGPU.wgpuDeviceGetFeatures(device::WGPUDevice, features::Ptr{WGPUSupportedFeatures})::Cvoid
end

function wgpuDeviceGetLimits(device, limits)
    @ccall libWGPU.wgpuDeviceGetLimits(device::WGPUDevice, limits::Ptr{WGPULimits})::WGPUStatus
end

function wgpuDeviceGetLostFuture(device)
    @ccall libWGPU.wgpuDeviceGetLostFuture(device::WGPUDevice)::WGPUFuture
end

function wgpuDeviceGetQueue(device)
    @ccall libWGPU.wgpuDeviceGetQueue(device::WGPUDevice)::WGPUQueue
end

function wgpuDeviceHasFeature(device, feature)
    @ccall libWGPU.wgpuDeviceHasFeature(device::WGPUDevice, feature::WGPUFeatureName)::WGPUBool
end

function wgpuDevicePopErrorScope(device, callbackInfo)
    @ccall libWGPU.wgpuDevicePopErrorScope(device::WGPUDevice, callbackInfo::WGPUPopErrorScopeCallbackInfo)::WGPUFuture
end

function wgpuDevicePushErrorScope(device, filter)
    @ccall libWGPU.wgpuDevicePushErrorScope(device::WGPUDevice, filter::WGPUErrorFilter)::Cvoid
end

function wgpuDeviceSetLabel(device, label)
    @ccall libWGPU.wgpuDeviceSetLabel(device::WGPUDevice, label::WGPUStringView)::Cvoid
end

function wgpuDeviceAddRef(device)
    @ccall libWGPU.wgpuDeviceAddRef(device::WGPUDevice)::Cvoid
end

function wgpuDeviceRelease(device)
    @ccall libWGPU.wgpuDeviceRelease(device::WGPUDevice)::Cvoid
end

function wgpuInstanceCreateSurface(instance, descriptor)
    @ccall libWGPU.wgpuInstanceCreateSurface(instance::WGPUInstance, descriptor::Ptr{WGPUSurfaceDescriptor})::WGPUSurface
end

function wgpuInstanceGetWGSLLanguageFeatures(instance, features)
    @ccall libWGPU.wgpuInstanceGetWGSLLanguageFeatures(instance::WGPUInstance, features::Ptr{WGPUSupportedWGSLLanguageFeatures})::WGPUStatus
end

function wgpuInstanceHasWGSLLanguageFeature(instance, feature)
    @ccall libWGPU.wgpuInstanceHasWGSLLanguageFeature(instance::WGPUInstance, feature::WGPUWGSLLanguageFeatureName)::WGPUBool
end

function wgpuInstanceProcessEvents(instance)
    @ccall libWGPU.wgpuInstanceProcessEvents(instance::WGPUInstance)::Cvoid
end

function wgpuInstanceRequestAdapter(instance, options, callbackInfo)
    @ccall libWGPU.wgpuInstanceRequestAdapter(instance::WGPUInstance, options::Ptr{WGPURequestAdapterOptions}, callbackInfo::WGPURequestAdapterCallbackInfo)::WGPUFuture
end

function wgpuInstanceWaitAny(instance, futureCount, futures, timeoutNS)
    @ccall libWGPU.wgpuInstanceWaitAny(instance::WGPUInstance, futureCount::Csize_t, futures::Ptr{WGPUFutureWaitInfo}, timeoutNS::UInt64)::WGPUWaitStatus
end

function wgpuInstanceAddRef(instance)
    @ccall libWGPU.wgpuInstanceAddRef(instance::WGPUInstance)::Cvoid
end

function wgpuInstanceRelease(instance)
    @ccall libWGPU.wgpuInstanceRelease(instance::WGPUInstance)::Cvoid
end

function wgpuPipelineLayoutSetLabel(pipelineLayout, label)
    @ccall libWGPU.wgpuPipelineLayoutSetLabel(pipelineLayout::WGPUPipelineLayout, label::WGPUStringView)::Cvoid
end

function wgpuPipelineLayoutAddRef(pipelineLayout)
    @ccall libWGPU.wgpuPipelineLayoutAddRef(pipelineLayout::WGPUPipelineLayout)::Cvoid
end

function wgpuPipelineLayoutRelease(pipelineLayout)
    @ccall libWGPU.wgpuPipelineLayoutRelease(pipelineLayout::WGPUPipelineLayout)::Cvoid
end

function wgpuQuerySetDestroy(querySet)
    @ccall libWGPU.wgpuQuerySetDestroy(querySet::WGPUQuerySet)::Cvoid
end

function wgpuQuerySetGetCount(querySet)
    @ccall libWGPU.wgpuQuerySetGetCount(querySet::WGPUQuerySet)::UInt32
end

function wgpuQuerySetGetType(querySet)
    @ccall libWGPU.wgpuQuerySetGetType(querySet::WGPUQuerySet)::WGPUQueryType
end

function wgpuQuerySetSetLabel(querySet, label)
    @ccall libWGPU.wgpuQuerySetSetLabel(querySet::WGPUQuerySet, label::WGPUStringView)::Cvoid
end

function wgpuQuerySetAddRef(querySet)
    @ccall libWGPU.wgpuQuerySetAddRef(querySet::WGPUQuerySet)::Cvoid
end

function wgpuQuerySetRelease(querySet)
    @ccall libWGPU.wgpuQuerySetRelease(querySet::WGPUQuerySet)::Cvoid
end

function wgpuQueueOnSubmittedWorkDone(queue, callbackInfo)
    @ccall libWGPU.wgpuQueueOnSubmittedWorkDone(queue::WGPUQueue, callbackInfo::WGPUQueueWorkDoneCallbackInfo)::WGPUFuture
end

function wgpuQueueSetLabel(queue, label)
    @ccall libWGPU.wgpuQueueSetLabel(queue::WGPUQueue, label::WGPUStringView)::Cvoid
end

function wgpuQueueSubmit(queue, commandCount, commands)
    @ccall libWGPU.wgpuQueueSubmit(queue::WGPUQueue, commandCount::Csize_t, commands::Ptr{WGPUCommandBuffer})::Cvoid
end

function wgpuQueueWriteBuffer(queue, buffer, bufferOffset, data, size)
    @ccall libWGPU.wgpuQueueWriteBuffer(queue::WGPUQueue, buffer::WGPUBuffer, bufferOffset::UInt64, data::Ptr{Cvoid}, size::Csize_t)::Cvoid
end

function wgpuQueueWriteTexture(queue, destination, data, dataSize, dataLayout, writeSize)
    @ccall libWGPU.wgpuQueueWriteTexture(queue::WGPUQueue, destination::Ptr{WGPUTexelCopyTextureInfo}, data::Ptr{Cvoid}, dataSize::Csize_t, dataLayout::Ptr{WGPUTexelCopyBufferLayout}, writeSize::Ptr{WGPUExtent3D})::Cvoid
end

function wgpuQueueAddRef(queue)
    @ccall libWGPU.wgpuQueueAddRef(queue::WGPUQueue)::Cvoid
end

function wgpuQueueRelease(queue)
    @ccall libWGPU.wgpuQueueRelease(queue::WGPUQueue)::Cvoid
end

function wgpuRenderBundleSetLabel(renderBundle, label)
    @ccall libWGPU.wgpuRenderBundleSetLabel(renderBundle::WGPURenderBundle, label::WGPUStringView)::Cvoid
end

function wgpuRenderBundleAddRef(renderBundle)
    @ccall libWGPU.wgpuRenderBundleAddRef(renderBundle::WGPURenderBundle)::Cvoid
end

function wgpuRenderBundleRelease(renderBundle)
    @ccall libWGPU.wgpuRenderBundleRelease(renderBundle::WGPURenderBundle)::Cvoid
end

function wgpuRenderBundleEncoderDraw(renderBundleEncoder, vertexCount, instanceCount, firstVertex, firstInstance)
    @ccall libWGPU.wgpuRenderBundleEncoderDraw(renderBundleEncoder::WGPURenderBundleEncoder, vertexCount::UInt32, instanceCount::UInt32, firstVertex::UInt32, firstInstance::UInt32)::Cvoid
end

function wgpuRenderBundleEncoderDrawIndexed(renderBundleEncoder, indexCount, instanceCount, firstIndex, baseVertex, firstInstance)
    @ccall libWGPU.wgpuRenderBundleEncoderDrawIndexed(renderBundleEncoder::WGPURenderBundleEncoder, indexCount::UInt32, instanceCount::UInt32, firstIndex::UInt32, baseVertex::Int32, firstInstance::UInt32)::Cvoid
end

function wgpuRenderBundleEncoderDrawIndexedIndirect(renderBundleEncoder, indirectBuffer, indirectOffset)
    @ccall libWGPU.wgpuRenderBundleEncoderDrawIndexedIndirect(renderBundleEncoder::WGPURenderBundleEncoder, indirectBuffer::WGPUBuffer, indirectOffset::UInt64)::Cvoid
end

function wgpuRenderBundleEncoderDrawIndirect(renderBundleEncoder, indirectBuffer, indirectOffset)
    @ccall libWGPU.wgpuRenderBundleEncoderDrawIndirect(renderBundleEncoder::WGPURenderBundleEncoder, indirectBuffer::WGPUBuffer, indirectOffset::UInt64)::Cvoid
end

function wgpuRenderBundleEncoderFinish(renderBundleEncoder, descriptor)
    @ccall libWGPU.wgpuRenderBundleEncoderFinish(renderBundleEncoder::WGPURenderBundleEncoder, descriptor::Ptr{WGPURenderBundleDescriptor})::WGPURenderBundle
end

function wgpuRenderBundleEncoderInsertDebugMarker(renderBundleEncoder, markerLabel)
    @ccall libWGPU.wgpuRenderBundleEncoderInsertDebugMarker(renderBundleEncoder::WGPURenderBundleEncoder, markerLabel::WGPUStringView)::Cvoid
end

function wgpuRenderBundleEncoderPopDebugGroup(renderBundleEncoder)
    @ccall libWGPU.wgpuRenderBundleEncoderPopDebugGroup(renderBundleEncoder::WGPURenderBundleEncoder)::Cvoid
end

function wgpuRenderBundleEncoderPushDebugGroup(renderBundleEncoder, groupLabel)
    @ccall libWGPU.wgpuRenderBundleEncoderPushDebugGroup(renderBundleEncoder::WGPURenderBundleEncoder, groupLabel::WGPUStringView)::Cvoid
end

function wgpuRenderBundleEncoderSetBindGroup(renderBundleEncoder, groupIndex, group, dynamicOffsetCount, dynamicOffsets)
    @ccall libWGPU.wgpuRenderBundleEncoderSetBindGroup(renderBundleEncoder::WGPURenderBundleEncoder, groupIndex::UInt32, group::WGPUBindGroup, dynamicOffsetCount::Csize_t, dynamicOffsets::Ptr{UInt32})::Cvoid
end

function wgpuRenderBundleEncoderSetIndexBuffer(renderBundleEncoder, buffer, format, offset, size)
    @ccall libWGPU.wgpuRenderBundleEncoderSetIndexBuffer(renderBundleEncoder::WGPURenderBundleEncoder, buffer::WGPUBuffer, format::WGPUIndexFormat, offset::UInt64, size::UInt64)::Cvoid
end

function wgpuRenderBundleEncoderSetLabel(renderBundleEncoder, label)
    @ccall libWGPU.wgpuRenderBundleEncoderSetLabel(renderBundleEncoder::WGPURenderBundleEncoder, label::WGPUStringView)::Cvoid
end

function wgpuRenderBundleEncoderSetPipeline(renderBundleEncoder, pipeline)
    @ccall libWGPU.wgpuRenderBundleEncoderSetPipeline(renderBundleEncoder::WGPURenderBundleEncoder, pipeline::WGPURenderPipeline)::Cvoid
end

function wgpuRenderBundleEncoderSetVertexBuffer(renderBundleEncoder, slot, buffer, offset, size)
    @ccall libWGPU.wgpuRenderBundleEncoderSetVertexBuffer(renderBundleEncoder::WGPURenderBundleEncoder, slot::UInt32, buffer::WGPUBuffer, offset::UInt64, size::UInt64)::Cvoid
end

function wgpuRenderBundleEncoderAddRef(renderBundleEncoder)
    @ccall libWGPU.wgpuRenderBundleEncoderAddRef(renderBundleEncoder::WGPURenderBundleEncoder)::Cvoid
end

function wgpuRenderBundleEncoderRelease(renderBundleEncoder)
    @ccall libWGPU.wgpuRenderBundleEncoderRelease(renderBundleEncoder::WGPURenderBundleEncoder)::Cvoid
end

function wgpuRenderPassEncoderBeginOcclusionQuery(renderPassEncoder, queryIndex)
    @ccall libWGPU.wgpuRenderPassEncoderBeginOcclusionQuery(renderPassEncoder::WGPURenderPassEncoder, queryIndex::UInt32)::Cvoid
end

function wgpuRenderPassEncoderDraw(renderPassEncoder, vertexCount, instanceCount, firstVertex, firstInstance)
    @ccall libWGPU.wgpuRenderPassEncoderDraw(renderPassEncoder::WGPURenderPassEncoder, vertexCount::UInt32, instanceCount::UInt32, firstVertex::UInt32, firstInstance::UInt32)::Cvoid
end

function wgpuRenderPassEncoderDrawIndexed(renderPassEncoder, indexCount, instanceCount, firstIndex, baseVertex, firstInstance)
    @ccall libWGPU.wgpuRenderPassEncoderDrawIndexed(renderPassEncoder::WGPURenderPassEncoder, indexCount::UInt32, instanceCount::UInt32, firstIndex::UInt32, baseVertex::Int32, firstInstance::UInt32)::Cvoid
end

function wgpuRenderPassEncoderDrawIndexedIndirect(renderPassEncoder, indirectBuffer, indirectOffset)
    @ccall libWGPU.wgpuRenderPassEncoderDrawIndexedIndirect(renderPassEncoder::WGPURenderPassEncoder, indirectBuffer::WGPUBuffer, indirectOffset::UInt64)::Cvoid
end

function wgpuRenderPassEncoderDrawIndirect(renderPassEncoder, indirectBuffer, indirectOffset)
    @ccall libWGPU.wgpuRenderPassEncoderDrawIndirect(renderPassEncoder::WGPURenderPassEncoder, indirectBuffer::WGPUBuffer, indirectOffset::UInt64)::Cvoid
end

function wgpuRenderPassEncoderEnd(renderPassEncoder)
    @ccall libWGPU.wgpuRenderPassEncoderEnd(renderPassEncoder::WGPURenderPassEncoder)::Cvoid
end

function wgpuRenderPassEncoderEndOcclusionQuery(renderPassEncoder)
    @ccall libWGPU.wgpuRenderPassEncoderEndOcclusionQuery(renderPassEncoder::WGPURenderPassEncoder)::Cvoid
end

function wgpuRenderPassEncoderExecuteBundles(renderPassEncoder, bundleCount, bundles)
    @ccall libWGPU.wgpuRenderPassEncoderExecuteBundles(renderPassEncoder::WGPURenderPassEncoder, bundleCount::Csize_t, bundles::Ptr{WGPURenderBundle})::Cvoid
end

function wgpuRenderPassEncoderInsertDebugMarker(renderPassEncoder, markerLabel)
    @ccall libWGPU.wgpuRenderPassEncoderInsertDebugMarker(renderPassEncoder::WGPURenderPassEncoder, markerLabel::WGPUStringView)::Cvoid
end

function wgpuRenderPassEncoderPopDebugGroup(renderPassEncoder)
    @ccall libWGPU.wgpuRenderPassEncoderPopDebugGroup(renderPassEncoder::WGPURenderPassEncoder)::Cvoid
end

function wgpuRenderPassEncoderPushDebugGroup(renderPassEncoder, groupLabel)
    @ccall libWGPU.wgpuRenderPassEncoderPushDebugGroup(renderPassEncoder::WGPURenderPassEncoder, groupLabel::WGPUStringView)::Cvoid
end

function wgpuRenderPassEncoderSetBindGroup(renderPassEncoder, groupIndex, group, dynamicOffsetCount, dynamicOffsets)
    @ccall libWGPU.wgpuRenderPassEncoderSetBindGroup(renderPassEncoder::WGPURenderPassEncoder, groupIndex::UInt32, group::WGPUBindGroup, dynamicOffsetCount::Csize_t, dynamicOffsets::Ptr{UInt32})::Cvoid
end

function wgpuRenderPassEncoderSetBlendConstant(renderPassEncoder, color)
    @ccall libWGPU.wgpuRenderPassEncoderSetBlendConstant(renderPassEncoder::WGPURenderPassEncoder, color::Ptr{WGPUColor})::Cvoid
end

function wgpuRenderPassEncoderSetIndexBuffer(renderPassEncoder, buffer, format, offset, size)
    @ccall libWGPU.wgpuRenderPassEncoderSetIndexBuffer(renderPassEncoder::WGPURenderPassEncoder, buffer::WGPUBuffer, format::WGPUIndexFormat, offset::UInt64, size::UInt64)::Cvoid
end

function wgpuRenderPassEncoderSetLabel(renderPassEncoder, label)
    @ccall libWGPU.wgpuRenderPassEncoderSetLabel(renderPassEncoder::WGPURenderPassEncoder, label::WGPUStringView)::Cvoid
end

function wgpuRenderPassEncoderSetPipeline(renderPassEncoder, pipeline)
    @ccall libWGPU.wgpuRenderPassEncoderSetPipeline(renderPassEncoder::WGPURenderPassEncoder, pipeline::WGPURenderPipeline)::Cvoid
end

function wgpuRenderPassEncoderSetScissorRect(renderPassEncoder, x, y, width, height)
    @ccall libWGPU.wgpuRenderPassEncoderSetScissorRect(renderPassEncoder::WGPURenderPassEncoder, x::UInt32, y::UInt32, width::UInt32, height::UInt32)::Cvoid
end

function wgpuRenderPassEncoderSetStencilReference(renderPassEncoder, reference)
    @ccall libWGPU.wgpuRenderPassEncoderSetStencilReference(renderPassEncoder::WGPURenderPassEncoder, reference::UInt32)::Cvoid
end

function wgpuRenderPassEncoderSetVertexBuffer(renderPassEncoder, slot, buffer, offset, size)
    @ccall libWGPU.wgpuRenderPassEncoderSetVertexBuffer(renderPassEncoder::WGPURenderPassEncoder, slot::UInt32, buffer::WGPUBuffer, offset::UInt64, size::UInt64)::Cvoid
end

function wgpuRenderPassEncoderSetViewport(renderPassEncoder, x, y, width, height, minDepth, maxDepth)
    @ccall libWGPU.wgpuRenderPassEncoderSetViewport(renderPassEncoder::WGPURenderPassEncoder, x::Cfloat, y::Cfloat, width::Cfloat, height::Cfloat, minDepth::Cfloat, maxDepth::Cfloat)::Cvoid
end

function wgpuRenderPassEncoderAddRef(renderPassEncoder)
    @ccall libWGPU.wgpuRenderPassEncoderAddRef(renderPassEncoder::WGPURenderPassEncoder)::Cvoid
end

function wgpuRenderPassEncoderRelease(renderPassEncoder)
    @ccall libWGPU.wgpuRenderPassEncoderRelease(renderPassEncoder::WGPURenderPassEncoder)::Cvoid
end

function wgpuRenderPipelineGetBindGroupLayout(renderPipeline, groupIndex)
    @ccall libWGPU.wgpuRenderPipelineGetBindGroupLayout(renderPipeline::WGPURenderPipeline, groupIndex::UInt32)::WGPUBindGroupLayout
end

function wgpuRenderPipelineSetLabel(renderPipeline, label)
    @ccall libWGPU.wgpuRenderPipelineSetLabel(renderPipeline::WGPURenderPipeline, label::WGPUStringView)::Cvoid
end

function wgpuRenderPipelineAddRef(renderPipeline)
    @ccall libWGPU.wgpuRenderPipelineAddRef(renderPipeline::WGPURenderPipeline)::Cvoid
end

function wgpuRenderPipelineRelease(renderPipeline)
    @ccall libWGPU.wgpuRenderPipelineRelease(renderPipeline::WGPURenderPipeline)::Cvoid
end

function wgpuSamplerSetLabel(sampler, label)
    @ccall libWGPU.wgpuSamplerSetLabel(sampler::WGPUSampler, label::WGPUStringView)::Cvoid
end

function wgpuSamplerAddRef(sampler)
    @ccall libWGPU.wgpuSamplerAddRef(sampler::WGPUSampler)::Cvoid
end

function wgpuSamplerRelease(sampler)
    @ccall libWGPU.wgpuSamplerRelease(sampler::WGPUSampler)::Cvoid
end

function wgpuShaderModuleGetCompilationInfo(shaderModule, callbackInfo)
    @ccall libWGPU.wgpuShaderModuleGetCompilationInfo(shaderModule::WGPUShaderModule, callbackInfo::WGPUCompilationInfoCallbackInfo)::WGPUFuture
end

function wgpuShaderModuleSetLabel(shaderModule, label)
    @ccall libWGPU.wgpuShaderModuleSetLabel(shaderModule::WGPUShaderModule, label::WGPUStringView)::Cvoid
end

function wgpuShaderModuleAddRef(shaderModule)
    @ccall libWGPU.wgpuShaderModuleAddRef(shaderModule::WGPUShaderModule)::Cvoid
end

function wgpuShaderModuleRelease(shaderModule)
    @ccall libWGPU.wgpuShaderModuleRelease(shaderModule::WGPUShaderModule)::Cvoid
end

function wgpuSupportedFeaturesFreeMembers(supportedFeatures)
    @ccall libWGPU.wgpuSupportedFeaturesFreeMembers(supportedFeatures::WGPUSupportedFeatures)::Cvoid
end

function wgpuSupportedWGSLLanguageFeaturesFreeMembers(supportedWGSLLanguageFeatures)
    @ccall libWGPU.wgpuSupportedWGSLLanguageFeaturesFreeMembers(supportedWGSLLanguageFeatures::WGPUSupportedWGSLLanguageFeatures)::Cvoid
end

function wgpuSurfaceConfigure(surface, config)
    @ccall libWGPU.wgpuSurfaceConfigure(surface::WGPUSurface, config::Ptr{WGPUSurfaceConfiguration})::Cvoid
end

function wgpuSurfaceGetCapabilities(surface, adapter, capabilities)
    @ccall libWGPU.wgpuSurfaceGetCapabilities(surface::WGPUSurface, adapter::WGPUAdapter, capabilities::Ptr{WGPUSurfaceCapabilities})::WGPUStatus
end

function wgpuSurfaceGetCurrentTexture(surface, surfaceTexture)
    @ccall libWGPU.wgpuSurfaceGetCurrentTexture(surface::WGPUSurface, surfaceTexture::Ptr{WGPUSurfaceTexture})::Cvoid
end

function wgpuSurfacePresent(surface)
    @ccall libWGPU.wgpuSurfacePresent(surface::WGPUSurface)::WGPUStatus
end

function wgpuSurfaceSetLabel(surface, label)
    @ccall libWGPU.wgpuSurfaceSetLabel(surface::WGPUSurface, label::WGPUStringView)::Cvoid
end

function wgpuSurfaceUnconfigure(surface)
    @ccall libWGPU.wgpuSurfaceUnconfigure(surface::WGPUSurface)::Cvoid
end

function wgpuSurfaceAddRef(surface)
    @ccall libWGPU.wgpuSurfaceAddRef(surface::WGPUSurface)::Cvoid
end

function wgpuSurfaceRelease(surface)
    @ccall libWGPU.wgpuSurfaceRelease(surface::WGPUSurface)::Cvoid
end

function wgpuSurfaceCapabilitiesFreeMembers(surfaceCapabilities)
    @ccall libWGPU.wgpuSurfaceCapabilitiesFreeMembers(surfaceCapabilities::WGPUSurfaceCapabilities)::Cvoid
end

function wgpuTextureCreateView(texture, descriptor)
    @ccall libWGPU.wgpuTextureCreateView(texture::WGPUTexture, descriptor::Ptr{WGPUTextureViewDescriptor})::WGPUTextureView
end

function wgpuTextureDestroy(texture)
    @ccall libWGPU.wgpuTextureDestroy(texture::WGPUTexture)::Cvoid
end

function wgpuTextureGetDepthOrArrayLayers(texture)
    @ccall libWGPU.wgpuTextureGetDepthOrArrayLayers(texture::WGPUTexture)::UInt32
end

function wgpuTextureGetDimension(texture)
    @ccall libWGPU.wgpuTextureGetDimension(texture::WGPUTexture)::WGPUTextureDimension
end

function wgpuTextureGetFormat(texture)
    @ccall libWGPU.wgpuTextureGetFormat(texture::WGPUTexture)::WGPUTextureFormat
end

function wgpuTextureGetHeight(texture)
    @ccall libWGPU.wgpuTextureGetHeight(texture::WGPUTexture)::UInt32
end

function wgpuTextureGetMipLevelCount(texture)
    @ccall libWGPU.wgpuTextureGetMipLevelCount(texture::WGPUTexture)::UInt32
end

function wgpuTextureGetSampleCount(texture)
    @ccall libWGPU.wgpuTextureGetSampleCount(texture::WGPUTexture)::UInt32
end

function wgpuTextureGetUsage(texture)
    @ccall libWGPU.wgpuTextureGetUsage(texture::WGPUTexture)::WGPUTextureUsage
end

function wgpuTextureGetWidth(texture)
    @ccall libWGPU.wgpuTextureGetWidth(texture::WGPUTexture)::UInt32
end

function wgpuTextureSetLabel(texture, label)
    @ccall libWGPU.wgpuTextureSetLabel(texture::WGPUTexture, label::WGPUStringView)::Cvoid
end

function wgpuTextureAddRef(texture)
    @ccall libWGPU.wgpuTextureAddRef(texture::WGPUTexture)::Cvoid
end

function wgpuTextureRelease(texture)
    @ccall libWGPU.wgpuTextureRelease(texture::WGPUTexture)::Cvoid
end

function wgpuTextureViewSetLabel(textureView, label)
    @ccall libWGPU.wgpuTextureViewSetLabel(textureView::WGPUTextureView, label::WGPUStringView)::Cvoid
end

function wgpuTextureViewAddRef(textureView)
    @ccall libWGPU.wgpuTextureViewAddRef(textureView::WGPUTextureView)::Cvoid
end

function wgpuTextureViewRelease(textureView)
    @ccall libWGPU.wgpuTextureViewRelease(textureView::WGPUTextureView)::Cvoid
end

@cenum WGPUNativeSType::UInt32 begin
    WGPUSType_DeviceExtras = 196609
    WGPUSType_NativeLimits = 196610
    WGPUSType_PipelineLayoutExtras = 196611
    WGPUSType_ShaderModuleGLSLDescriptor = 196612
    WGPUSType_InstanceExtras = 196614
    WGPUSType_BindGroupEntryExtras = 196615
    WGPUSType_BindGroupLayoutEntryExtras = 196616
    WGPUSType_QuerySetDescriptorExtras = 196617
    WGPUSType_SurfaceConfigurationExtras = 196618
    WGPUNativeSType_Force32 = 2147483647
end

@cenum WGPUNativeFeature::UInt32 begin
    WGPUNativeFeature_PushConstants = 196609
    WGPUNativeFeature_TextureAdapterSpecificFormatFeatures = 196610
    WGPUNativeFeature_MultiDrawIndirect = 196611
    WGPUNativeFeature_MultiDrawIndirectCount = 196612
    WGPUNativeFeature_VertexWritableStorage = 196613
    WGPUNativeFeature_TextureBindingArray = 196614
    WGPUNativeFeature_SampledTextureAndStorageBufferArrayNonUniformIndexing = 196615
    WGPUNativeFeature_PipelineStatisticsQuery = 196616
    WGPUNativeFeature_StorageResourceBindingArray = 196617
    WGPUNativeFeature_PartiallyBoundBindingArray = 196618
    WGPUNativeFeature_TextureFormat16bitNorm = 196619
    WGPUNativeFeature_TextureCompressionAstcHdr = 196620
    WGPUNativeFeature_MappablePrimaryBuffers = 196622
    WGPUNativeFeature_BufferBindingArray = 196623
    WGPUNativeFeature_UniformBufferAndStorageTextureArrayNonUniformIndexing = 196624
    WGPUNativeFeature_SpirvShaderPassthrough = 196631
    WGPUNativeFeature_VertexAttribute64bit = 196633
    WGPUNativeFeature_TextureFormatNv12 = 196634
    WGPUNativeFeature_RayTracingAccelerationStructure = 196635
    WGPUNativeFeature_RayQuery = 196636
    WGPUNativeFeature_ShaderF64 = 196637
    WGPUNativeFeature_ShaderI16 = 196638
    WGPUNativeFeature_ShaderPrimitiveIndex = 196639
    WGPUNativeFeature_ShaderEarlyDepthTest = 196640
    WGPUNativeFeature_Subgroup = 196641
    WGPUNativeFeature_SubgroupVertex = 196642
    WGPUNativeFeature_SubgroupBarrier = 196643
    WGPUNativeFeature_TimestampQueryInsideEncoders = 196644
    WGPUNativeFeature_TimestampQueryInsidePasses = 196645
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

const WGPUInstanceBackend = WGPUFlags

const WGPUInstanceFlag = WGPUFlags

@cenum WGPUDx12Compiler::UInt32 begin
    WGPUDx12Compiler_Undefined = 0
    WGPUDx12Compiler_Fxc = 1
    WGPUDx12Compiler_Dxc = 2
    WGPUDx12Compiler_Force32 = 2147483647
end

@cenum WGPUGles3MinorVersion::UInt32 begin
    WGPUGles3MinorVersion_Automatic = 0
    WGPUGles3MinorVersion_Version0 = 1
    WGPUGles3MinorVersion_Version1 = 2
    WGPUGles3MinorVersion_Version2 = 3
    WGPUGles3MinorVersion_Force32 = 2147483647
end

@cenum WGPUPipelineStatisticName::UInt32 begin
    WGPUPipelineStatisticName_VertexShaderInvocations = 0
    WGPUPipelineStatisticName_ClipperInvocations = 1
    WGPUPipelineStatisticName_ClipperPrimitivesOut = 2
    WGPUPipelineStatisticName_FragmentShaderInvocations = 3
    WGPUPipelineStatisticName_ComputeShaderInvocations = 4
    WGPUPipelineStatisticName_Force32 = 2147483647
end

@cenum WGPUNativeQueryType::UInt32 begin
    WGPUNativeQueryType_PipelineStatistics = 196608
    WGPUNativeQueryType_Force32 = 2147483647
end

mutable struct WGPUInstanceExtras
    chain::WGPUChainedStruct
    backends::WGPUInstanceBackend
    flags::WGPUInstanceFlag
    dx12ShaderCompiler::WGPUDx12Compiler
    gles3MinorVersion::WGPUGles3MinorVersion
    dxilPath::WGPUStringView
    dxcPath::WGPUStringView
    WGPUInstanceExtras() = new()
end

mutable struct WGPUDeviceExtras
    chain::WGPUChainedStruct
    tracePath::WGPUStringView
    WGPUDeviceExtras() = new()
end

mutable struct WGPUNativeLimits
    chain::WGPUChainedStructOut
    maxPushConstantSize::UInt32
    maxNonSamplerBindings::UInt32
    WGPUNativeLimits() = new()
end

struct WGPUPushConstantRange
    stages::WGPUShaderStage
    start::UInt32
    _end::UInt32
end

mutable struct WGPUPipelineLayoutExtras
    chain::WGPUChainedStruct
    pushConstantRangeCount::Csize_t
    pushConstantRanges::Ptr{WGPUPushConstantRange}
    WGPUPipelineLayoutExtras() = new()
end

const WGPUSubmissionIndex = UInt64

struct WGPUShaderDefine
    name::WGPUStringView
    value::WGPUStringView
end

mutable struct WGPUShaderModuleGLSLDescriptor
    chain::WGPUChainedStruct
    stage::WGPUShaderStage
    code::WGPUStringView
    defineCount::UInt32
    defines::Ptr{WGPUShaderDefine}
    WGPUShaderModuleGLSLDescriptor() = new()
end

mutable struct WGPUShaderModuleDescriptorSpirV
    label::WGPUStringView
    sourceSize::UInt32
    source::Ptr{UInt32}
    WGPUShaderModuleDescriptorSpirV() = new()
end

struct WGPURegistryReport
    numAllocated::Csize_t
    numKeptFromUser::Csize_t
    numReleasedFromUser::Csize_t
    elementSize::Csize_t
end

struct WGPUHubReport
    adapters::WGPURegistryReport
    devices::WGPURegistryReport
    queues::WGPURegistryReport
    pipelineLayouts::WGPURegistryReport
    shaderModules::WGPURegistryReport
    bindGroupLayouts::WGPURegistryReport
    bindGroups::WGPURegistryReport
    commandBuffers::WGPURegistryReport
    renderBundles::WGPURegistryReport
    renderPipelines::WGPURegistryReport
    computePipelines::WGPURegistryReport
    pipelineCaches::WGPURegistryReport
    querySets::WGPURegistryReport
    buffers::WGPURegistryReport
    textures::WGPURegistryReport
    textureViews::WGPURegistryReport
    samplers::WGPURegistryReport
end

mutable struct WGPUGlobalReport
    surfaces::WGPURegistryReport
    hub::WGPUHubReport
    WGPUGlobalReport() = new()
end

mutable struct WGPUInstanceEnumerateAdapterOptions
    nextInChain::Ptr{WGPUChainedStruct}
    backends::WGPUInstanceBackend
    WGPUInstanceEnumerateAdapterOptions() = new()
end

mutable struct WGPUBindGroupEntryExtras
    chain::WGPUChainedStruct
    buffers::Ptr{WGPUBuffer}
    bufferCount::Csize_t
    samplers::Ptr{WGPUSampler}
    samplerCount::Csize_t
    textureViews::Ptr{WGPUTextureView}
    textureViewCount::Csize_t
    WGPUBindGroupEntryExtras() = new()
end

mutable struct WGPUBindGroupLayoutEntryExtras
    chain::WGPUChainedStruct
    count::UInt32
    WGPUBindGroupLayoutEntryExtras() = new()
end

mutable struct WGPUQuerySetDescriptorExtras
    chain::WGPUChainedStruct
    pipelineStatistics::Ptr{WGPUPipelineStatisticName}
    pipelineStatisticCount::Csize_t
    WGPUQuerySetDescriptorExtras() = new()
end

mutable struct WGPUSurfaceConfigurationExtras
    chain::WGPUChainedStruct
    desiredMaximumFrameLatency::UInt32
    WGPUSurfaceConfigurationExtras() = new()
end

# typedef void ( * WGPULogCallback ) ( WGPULogLevel level , WGPUStringView message , void * userdata )
const WGPULogCallback = Ptr{Cvoid}

@cenum WGPUNativeTextureFormat::UInt32 begin
    WGPUNativeTextureFormat_R16Unorm = 196609
    WGPUNativeTextureFormat_R16Snorm = 196610
    WGPUNativeTextureFormat_Rg16Unorm = 196611
    WGPUNativeTextureFormat_Rg16Snorm = 196612
    WGPUNativeTextureFormat_Rgba16Unorm = 196613
    WGPUNativeTextureFormat_Rgba16Snorm = 196614
    WGPUNativeTextureFormat_NV12 = 196615
end

function wgpuGenerateReport(instance, report)
    @ccall libWGPU.wgpuGenerateReport(instance::WGPUInstance, report::Ptr{WGPUGlobalReport})::Cvoid
end

function wgpuInstanceEnumerateAdapters(instance, options, adapters)
    @ccall libWGPU.wgpuInstanceEnumerateAdapters(instance::WGPUInstance, options::Ptr{WGPUInstanceEnumerateAdapterOptions}, adapters::Ptr{WGPUAdapter})::Csize_t
end

function wgpuQueueSubmitForIndex(queue, commandCount, commands)
    @ccall libWGPU.wgpuQueueSubmitForIndex(queue::WGPUQueue, commandCount::Csize_t, commands::Ptr{WGPUCommandBuffer})::WGPUSubmissionIndex
end

function wgpuDevicePoll(device, wait, wrappedSubmissionIndex)
    @ccall libWGPU.wgpuDevicePoll(device::WGPUDevice, wait::WGPUBool, wrappedSubmissionIndex::Ptr{WGPUSubmissionIndex})::WGPUBool
end

function wgpuDeviceCreateShaderModuleSpirV(device, descriptor)
    @ccall libWGPU.wgpuDeviceCreateShaderModuleSpirV(device::WGPUDevice, descriptor::Ptr{WGPUShaderModuleDescriptorSpirV})::WGPUShaderModule
end

function wgpuSetLogCallback(callback, userdata)
    @ccall libWGPU.wgpuSetLogCallback(callback::WGPULogCallback, userdata::Ptr{Cvoid})::Cvoid
end

function wgpuSetLogLevel(level)
    @ccall libWGPU.wgpuSetLogLevel(level::WGPULogLevel)::Cvoid
end

function wgpuGetVersion()
    @ccall libWGPU.wgpuGetVersion()::UInt32
end

function wgpuRenderPassEncoderSetPushConstants(encoder, stages, offset, sizeBytes, data)
    @ccall libWGPU.wgpuRenderPassEncoderSetPushConstants(encoder::WGPURenderPassEncoder, stages::WGPUShaderStage, offset::UInt32, sizeBytes::UInt32, data::Ptr{Cvoid})::Cvoid
end

function wgpuComputePassEncoderSetPushConstants(encoder, offset, sizeBytes, data)
    @ccall libWGPU.wgpuComputePassEncoderSetPushConstants(encoder::WGPUComputePassEncoder, offset::UInt32, sizeBytes::UInt32, data::Ptr{Cvoid})::Cvoid
end

function wgpuRenderBundleEncoderSetPushConstants(encoder, stages, offset, sizeBytes, data)
    @ccall libWGPU.wgpuRenderBundleEncoderSetPushConstants(encoder::WGPURenderBundleEncoder, stages::WGPUShaderStage, offset::UInt32, sizeBytes::UInt32, data::Ptr{Cvoid})::Cvoid
end

function wgpuRenderPassEncoderMultiDrawIndirect(encoder, buffer, offset, count)
    @ccall libWGPU.wgpuRenderPassEncoderMultiDrawIndirect(encoder::WGPURenderPassEncoder, buffer::WGPUBuffer, offset::UInt64, count::UInt32)::Cvoid
end

function wgpuRenderPassEncoderMultiDrawIndexedIndirect(encoder, buffer, offset, count)
    @ccall libWGPU.wgpuRenderPassEncoderMultiDrawIndexedIndirect(encoder::WGPURenderPassEncoder, buffer::WGPUBuffer, offset::UInt64, count::UInt32)::Cvoid
end

function wgpuRenderPassEncoderMultiDrawIndirectCount(encoder, buffer, offset, count_buffer, count_buffer_offset, max_count)
    @ccall libWGPU.wgpuRenderPassEncoderMultiDrawIndirectCount(encoder::WGPURenderPassEncoder, buffer::WGPUBuffer, offset::UInt64, count_buffer::WGPUBuffer, count_buffer_offset::UInt64, max_count::UInt32)::Cvoid
end

function wgpuRenderPassEncoderMultiDrawIndexedIndirectCount(encoder, buffer, offset, count_buffer, count_buffer_offset, max_count)
    @ccall libWGPU.wgpuRenderPassEncoderMultiDrawIndexedIndirectCount(encoder::WGPURenderPassEncoder, buffer::WGPUBuffer, offset::UInt64, count_buffer::WGPUBuffer, count_buffer_offset::UInt64, max_count::UInt32)::Cvoid
end

function wgpuComputePassEncoderBeginPipelineStatisticsQuery(computePassEncoder, querySet, queryIndex)
    @ccall libWGPU.wgpuComputePassEncoderBeginPipelineStatisticsQuery(computePassEncoder::WGPUComputePassEncoder, querySet::WGPUQuerySet, queryIndex::UInt32)::Cvoid
end

function wgpuComputePassEncoderEndPipelineStatisticsQuery(computePassEncoder)
    @ccall libWGPU.wgpuComputePassEncoderEndPipelineStatisticsQuery(computePassEncoder::WGPUComputePassEncoder)::Cvoid
end

function wgpuRenderPassEncoderBeginPipelineStatisticsQuery(renderPassEncoder, querySet, queryIndex)
    @ccall libWGPU.wgpuRenderPassEncoderBeginPipelineStatisticsQuery(renderPassEncoder::WGPURenderPassEncoder, querySet::WGPUQuerySet, queryIndex::UInt32)::Cvoid
end

function wgpuRenderPassEncoderEndPipelineStatisticsQuery(renderPassEncoder)
    @ccall libWGPU.wgpuRenderPassEncoderEndPipelineStatisticsQuery(renderPassEncoder::WGPURenderPassEncoder)::Cvoid
end

function wgpuComputePassEncoderWriteTimestamp(computePassEncoder, querySet, queryIndex)
    @ccall libWGPU.wgpuComputePassEncoderWriteTimestamp(computePassEncoder::WGPUComputePassEncoder, querySet::WGPUQuerySet, queryIndex::UInt32)::Cvoid
end

function wgpuRenderPassEncoderWriteTimestamp(renderPassEncoder, querySet, queryIndex)
    @ccall libWGPU.wgpuRenderPassEncoderWriteTimestamp(renderPassEncoder::WGPURenderPassEncoder, querySet::WGPUQuerySet, queryIndex::UInt32)::Cvoid
end

# Skipping MacroDefinition: _wgpu_COMMA ,

const WGPU_ARRAY_LAYER_COUNT_UNDEFINED = UINT32_MAX

const WGPU_COPY_STRIDE_UNDEFINED = UINT32_MAX

const WGPU_DEPTH_SLICE_UNDEFINED = UINT32_MAX

const WGPU_LIMIT_U32_UNDEFINED = UINT32_MAX

const WGPU_LIMIT_U64_UNDEFINED = UINT64_MAX

const WGPU_MIP_LEVEL_COUNT_UNDEFINED = UINT32_MAX

const WGPU_QUERY_SET_INDEX_UNDEFINED = UINT32_MAX

const WGPU_WHOLE_MAP_SIZE = SIZE_MAX

const WGPU_WHOLE_SIZE = UINT64_MAX

const WGPU_STRLEN = SIZE_MAX

# Skipping MacroDefinition: WGPU_STRING_VIEW_INIT _wgpu_MAKE_INIT_STRUCT ( WGPUStringView , { /*.data=*/ NULL _wgpu_COMMA /*.length=*/ WGPU_STRLEN _wgpu_COMMA \
#} )

# exports
const PREFIXES = ["WGPU", "wgpu"]
for name in names(@__MODULE__; all=true), prefix in PREFIXES
    if startswith(string(name), prefix)
        @eval export $name
    end
end

end # module
