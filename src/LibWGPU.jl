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

@cenum WGPUCompositeAlphaMode::UInt32 begin
    WGPUCompositeAlphaMode_Auto = 0
    WGPUCompositeAlphaMode_Opaque = 1
    WGPUCompositeAlphaMode_Premultiplied = 2
    WGPUCompositeAlphaMode_Unpremultiplied = 3
    WGPUCompositeAlphaMode_Inherit = 4
    WGPUCompositeAlphaMode_Force32 = 2147483647
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
    WGPUFeatureName_TextureCompressionBC = 4
    WGPUFeatureName_TextureCompressionETC2 = 5
    WGPUFeatureName_TextureCompressionASTC = 6
    WGPUFeatureName_IndirectFirstInstance = 7
    WGPUFeatureName_ShaderF16 = 8
    WGPUFeatureName_RG11B10UfloatRenderable = 9
    WGPUFeatureName_BGRA8UnormStorage = 10
    WGPUFeatureName_Float32Filterable = 11
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

@cenum WGPUPowerPreference::UInt32 begin
    WGPUPowerPreference_Undefined = 0
    WGPUPowerPreference_LowPower = 1
    WGPUPowerPreference_HighPerformance = 2
    WGPUPowerPreference_Force32 = 2147483647
end

@cenum WGPUPresentMode::UInt32 begin
    WGPUPresentMode_Fifo = 0
    WGPUPresentMode_FifoRelaxed = 1
    WGPUPresentMode_Immediate = 2
    WGPUPresentMode_Mailbox = 3
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
    WGPUQueryType_Timestamp = 1
    WGPUQueryType_Force32 = 2147483647
end

@cenum WGPUQueueWorkDoneStatus::UInt32 begin
    WGPUQueueWorkDoneStatus_Success = 0
    WGPUQueueWorkDoneStatus_Error = 1
    WGPUQueueWorkDoneStatus_Unknown = 2
    WGPUQueueWorkDoneStatus_DeviceLost = 3
    WGPUQueueWorkDoneStatus_Force32 = 2147483647
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
    WGPUStorageTextureAccess_ReadOnly = 2
    WGPUStorageTextureAccess_ReadWrite = 3
    WGPUStorageTextureAccess_Force32 = 2147483647
end

@cenum WGPUStoreOp::UInt32 begin
    WGPUStoreOp_Undefined = 0
    WGPUStoreOp_Store = 1
    WGPUStoreOp_Discard = 2
    WGPUStoreOp_Force32 = 2147483647
end

@cenum WGPUSurfaceGetCurrentTextureStatus::UInt32 begin
    WGPUSurfaceGetCurrentTextureStatus_Success = 0
    WGPUSurfaceGetCurrentTextureStatus_Timeout = 1
    WGPUSurfaceGetCurrentTextureStatus_Outdated = 2
    WGPUSurfaceGetCurrentTextureStatus_Lost = 3
    WGPUSurfaceGetCurrentTextureStatus_OutOfMemory = 4
    WGPUSurfaceGetCurrentTextureStatus_DeviceLost = 5
    WGPUSurfaceGetCurrentTextureStatus_Force32 = 2147483647
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

mutable struct WGPUAdapterProperties
    nextInChain::Ptr{WGPUChainedStructOut}
    vendorID::UInt32
    vendorName::Ptr{Cchar}
    architecture::Ptr{Cchar}
    deviceID::UInt32
    name::Ptr{Cchar}
    driverDescription::Ptr{Cchar}
    adapterType::WGPUAdapterType
    backendType::WGPUBackendType
    WGPUAdapterProperties() = new()
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
    label::Ptr{Cchar}
    usage::WGPUBufferUsageFlags
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
    label::Ptr{Cchar}
    WGPUCommandBufferDescriptor() = new()
end

mutable struct WGPUCommandEncoderDescriptor
    nextInChain::Ptr{WGPUChainedStruct}
    label::Ptr{Cchar}
    WGPUCommandEncoderDescriptor() = new()
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

struct WGPUComputePassTimestampWrites
    querySet::WGPUQuerySet
    beginningOfPassWriteIndex::UInt32
    endOfPassWriteIndex::UInt32
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

mutable struct WGPUInstanceDescriptor
    nextInChain::Ptr{WGPUChainedStruct}
    WGPUInstanceDescriptor() = new()
end

struct WGPULimits
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
    alphaToCoverageEnabled::WGPUBool
end

struct WGPUOrigin3D
    x::UInt32
    y::UInt32
    z::UInt32
end

mutable struct WGPUPipelineLayoutDescriptor
    nextInChain::Ptr{WGPUChainedStruct}
    label::Ptr{Cchar}
    bindGroupLayoutCount::Csize_t
    bindGroupLayouts::Ptr{WGPUBindGroupLayout}
    WGPUPipelineLayoutDescriptor() = new()
end

mutable struct WGPUPrimitiveDepthClipControl
    chain::WGPUChainedStruct
    unclippedDepth::WGPUBool
    WGPUPrimitiveDepthClipControl() = new()
end

struct WGPUPrimitiveState
    nextInChain::Ptr{WGPUChainedStruct}
    topology::WGPUPrimitiveTopology
    stripIndexFormat::WGPUIndexFormat
    frontFace::WGPUFrontFace
    cullMode::WGPUCullMode
end

mutable struct WGPUQuerySetDescriptor
    nextInChain::Ptr{WGPUChainedStruct}
    label::Ptr{Cchar}
    type::WGPUQueryType
    count::UInt32
    WGPUQuerySetDescriptor() = new()
end

struct WGPUQueueDescriptor
    nextInChain::Ptr{WGPUChainedStruct}
    label::Ptr{Cchar}
end

mutable struct WGPURenderBundleDescriptor
    nextInChain::Ptr{WGPUChainedStruct}
    label::Ptr{Cchar}
    WGPURenderBundleDescriptor() = new()
end

mutable struct WGPURenderBundleEncoderDescriptor
    nextInChain::Ptr{WGPUChainedStruct}
    label::Ptr{Cchar}
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

mutable struct WGPURenderPassDescriptorMaxDrawCount
    chain::WGPUChainedStruct
    maxDrawCount::UInt64
    WGPURenderPassDescriptorMaxDrawCount() = new()
end

struct WGPURenderPassTimestampWrites
    querySet::WGPUQuerySet
    beginningOfPassWriteIndex::UInt32
    endOfPassWriteIndex::UInt32
end

mutable struct WGPURequestAdapterOptions
    nextInChain::Ptr{WGPUChainedStruct}
    compatibleSurface::WGPUSurface
    powerPreference::WGPUPowerPreference
    backendType::WGPUBackendType
    forceFallbackAdapter::WGPUBool
    WGPURequestAdapterOptions() = new()
end

struct WGPUSamplerBindingLayout
    nextInChain::Ptr{WGPUChainedStruct}
    type::WGPUSamplerBindingType
end

mutable struct WGPUSamplerDescriptor
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
    WGPUSamplerDescriptor() = new()
end

struct WGPUShaderModuleCompilationHint
    nextInChain::Ptr{WGPUChainedStruct}
    entryPoint::Ptr{Cchar}
    layout::WGPUPipelineLayout
end

mutable struct WGPUShaderModuleSPIRVDescriptor
    chain::WGPUChainedStruct
    codeSize::UInt32
    code::Ptr{UInt32}
    WGPUShaderModuleSPIRVDescriptor() = new()
end

mutable struct WGPUShaderModuleWGSLDescriptor
    chain::WGPUChainedStruct
    code::Ptr{Cchar}
    WGPUShaderModuleWGSLDescriptor() = new()
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

mutable struct WGPUSurfaceCapabilities
    nextInChain::Ptr{WGPUChainedStructOut}
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
    usage::WGPUTextureUsageFlags
    viewFormatCount::Csize_t
    viewFormats::Ptr{WGPUTextureFormat}
    alphaMode::WGPUCompositeAlphaMode
    width::UInt32
    height::UInt32
    presentMode::WGPUPresentMode
    WGPUSurfaceConfiguration() = new()
end

mutable struct WGPUSurfaceDescriptor
    nextInChain::Ptr{WGPUChainedStruct}
    label::Ptr{Cchar}
    WGPUSurfaceDescriptor() = new()
end

mutable struct WGPUSurfaceDescriptorFromAndroidNativeWindow
    chain::WGPUChainedStruct
    window::Ptr{Cvoid}
    WGPUSurfaceDescriptorFromAndroidNativeWindow() = new()
end

mutable struct WGPUSurfaceDescriptorFromCanvasHTMLSelector
    chain::WGPUChainedStruct
    selector::Ptr{Cchar}
    WGPUSurfaceDescriptorFromCanvasHTMLSelector() = new()
end

mutable struct WGPUSurfaceDescriptorFromMetalLayer
    chain::WGPUChainedStruct
    layer::Ptr{Cvoid}
    WGPUSurfaceDescriptorFromMetalLayer() = new()
end

mutable struct WGPUSurfaceDescriptorFromWaylandSurface
    chain::WGPUChainedStruct
    display::Ptr{Cvoid}
    surface::Ptr{Cvoid}
    WGPUSurfaceDescriptorFromWaylandSurface() = new()
end

mutable struct WGPUSurfaceDescriptorFromWindowsHWND
    chain::WGPUChainedStruct
    hinstance::Ptr{Cvoid}
    hwnd::Ptr{Cvoid}
    WGPUSurfaceDescriptorFromWindowsHWND() = new()
end

mutable struct WGPUSurfaceDescriptorFromXcbWindow
    chain::WGPUChainedStruct
    connection::Ptr{Cvoid}
    window::UInt32
    WGPUSurfaceDescriptorFromXcbWindow() = new()
end

mutable struct WGPUSurfaceDescriptorFromXlibWindow
    chain::WGPUChainedStruct
    display::Ptr{Cvoid}
    window::UInt64
    WGPUSurfaceDescriptorFromXlibWindow() = new()
end

mutable struct WGPUSurfaceTexture
    texture::WGPUTexture
    suboptimal::WGPUBool
    status::WGPUSurfaceGetCurrentTextureStatus
    WGPUSurfaceTexture() = new()
end

struct WGPUTextureBindingLayout
    nextInChain::Ptr{WGPUChainedStruct}
    sampleType::WGPUTextureSampleType
    viewDimension::WGPUTextureViewDimension
    multisampled::WGPUBool
end

struct WGPUTextureDataLayout
    nextInChain::Ptr{WGPUChainedStruct}
    offset::UInt64
    bytesPerRow::UInt32
    rowsPerImage::UInt32
end

mutable struct WGPUTextureViewDescriptor
    nextInChain::Ptr{WGPUChainedStruct}
    label::Ptr{Cchar}
    format::WGPUTextureFormat
    dimension::WGPUTextureViewDimension
    baseMipLevel::UInt32
    mipLevelCount::UInt32
    baseArrayLayer::UInt32
    arrayLayerCount::UInt32
    aspect::WGPUTextureAspect
    WGPUTextureViewDescriptor() = new()
end

struct WGPUVertexAttribute
    format::WGPUVertexFormat
    offset::UInt64
    shaderLocation::UInt32
end

mutable struct WGPUBindGroupDescriptor
    nextInChain::Ptr{WGPUChainedStruct}
    label::Ptr{Cchar}
    layout::WGPUBindGroupLayout
    entryCount::Csize_t
    entries::Ptr{WGPUBindGroupEntry}
    WGPUBindGroupDescriptor() = new()
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

mutable struct WGPUCompilationInfo
    nextInChain::Ptr{WGPUChainedStruct}
    messageCount::Csize_t
    messages::Ptr{WGPUCompilationMessage}
    WGPUCompilationInfo() = new()
end

mutable struct WGPUComputePassDescriptor
    nextInChain::Ptr{WGPUChainedStruct}
    label::Ptr{Cchar}
    timestampWrites::Ptr{WGPUComputePassTimestampWrites}
    WGPUComputePassDescriptor() = new()
end

struct WGPUDepthStencilState
    nextInChain::Ptr{WGPUChainedStruct}
    format::WGPUTextureFormat
    depthWriteEnabled::WGPUBool
    depthCompare::WGPUCompareFunction
    stencilFront::WGPUStencilFaceState
    stencilBack::WGPUStencilFaceState
    stencilReadMask::UInt32
    stencilWriteMask::UInt32
    depthBias::Int32
    depthBiasSlopeScale::Cfloat
    depthBiasClamp::Cfloat
end

mutable struct WGPUImageCopyBuffer
    nextInChain::Ptr{WGPUChainedStruct}
    layout::WGPUTextureDataLayout
    buffer::WGPUBuffer
    WGPUImageCopyBuffer() = new()
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
    nextInChain::Ptr{WGPUChainedStruct}
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

mutable struct WGPUShaderModuleDescriptor
    nextInChain::Ptr{WGPUChainedStruct}
    label::Ptr{Cchar}
    hintCount::Csize_t
    hints::Ptr{WGPUShaderModuleCompilationHint}
    WGPUShaderModuleDescriptor() = new()
end

mutable struct WGPUSupportedLimits
    nextInChain::Ptr{WGPUChainedStructOut}
    limits::WGPULimits
    WGPUSupportedLimits() = new()
end

mutable struct WGPUTextureDescriptor
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
    WGPUTextureDescriptor() = new()
end

struct WGPUVertexBufferLayout
    arrayStride::UInt64
    stepMode::WGPUVertexStepMode
    attributeCount::Csize_t
    attributes::Ptr{WGPUVertexAttribute}
end

mutable struct WGPUBindGroupLayoutDescriptor
    nextInChain::Ptr{WGPUChainedStruct}
    label::Ptr{Cchar}
    entryCount::Csize_t
    entries::Ptr{WGPUBindGroupLayoutEntry}
    WGPUBindGroupLayoutDescriptor() = new()
end

struct WGPUColorTargetState
    nextInChain::Ptr{WGPUChainedStruct}
    format::WGPUTextureFormat
    blend::Ptr{WGPUBlendState}
    writeMask::WGPUColorWriteMaskFlags
end

mutable struct WGPUComputePipelineDescriptor
    nextInChain::Ptr{WGPUChainedStruct}
    label::Ptr{Cchar}
    layout::WGPUPipelineLayout
    compute::WGPUProgrammableStageDescriptor
    WGPUComputePipelineDescriptor() = new()
end

mutable struct WGPUDeviceDescriptor
    nextInChain::Ptr{WGPUChainedStruct}
    label::Ptr{Cchar}
    requiredFeatureCount::Csize_t
    requiredFeatures::Ptr{WGPUFeatureName}
    requiredLimits::Ptr{WGPURequiredLimits}
    defaultQueue::WGPUQueueDescriptor
    deviceLostCallback::WGPUDeviceLostCallback
    deviceLostUserdata::Ptr{Cvoid}
    WGPUDeviceDescriptor() = new()
end

mutable struct WGPURenderPassDescriptor
    nextInChain::Ptr{WGPUChainedStruct}
    label::Ptr{Cchar}
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

mutable struct WGPURenderPipelineDescriptor
    nextInChain::Ptr{WGPUChainedStruct}
    label::Ptr{Cchar}
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

# typedef WGPUProc ( * WGPUProcGetProcAddress ) ( WGPUDevice device , char const * procName )
const WGPUProcGetProcAddress = Ptr{Cvoid}

# typedef size_t ( * WGPUProcAdapterEnumerateFeatures ) ( WGPUAdapter adapter , WGPUFeatureName * features )
const WGPUProcAdapterEnumerateFeatures = Ptr{Cvoid}

# typedef WGPUBool ( * WGPUProcAdapterGetLimits ) ( WGPUAdapter adapter , WGPUSupportedLimits * limits )
const WGPUProcAdapterGetLimits = Ptr{Cvoid}

# typedef void ( * WGPUProcAdapterGetProperties ) ( WGPUAdapter adapter , WGPUAdapterProperties * properties )
const WGPUProcAdapterGetProperties = Ptr{Cvoid}

# typedef WGPUBool ( * WGPUProcAdapterHasFeature ) ( WGPUAdapter adapter , WGPUFeatureName feature )
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

# typedef void ( * WGPUProcComputePassEncoderDispatchWorkgroups ) ( WGPUComputePassEncoder computePassEncoder , uint32_t workgroupCountX , uint32_t workgroupCountY , uint32_t workgroupCountZ )
const WGPUProcComputePassEncoderDispatchWorkgroups = Ptr{Cvoid}

# typedef void ( * WGPUProcComputePassEncoderDispatchWorkgroupsIndirect ) ( WGPUComputePassEncoder computePassEncoder , WGPUBuffer indirectBuffer , uint64_t indirectOffset )
const WGPUProcComputePassEncoderDispatchWorkgroupsIndirect = Ptr{Cvoid}

# typedef void ( * WGPUProcComputePassEncoderEnd ) ( WGPUComputePassEncoder computePassEncoder )
const WGPUProcComputePassEncoderEnd = Ptr{Cvoid}

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

# typedef WGPUTexture ( * WGPUProcDeviceCreateTexture ) ( WGPUDevice device , WGPUTextureDescriptor const * descriptor )
const WGPUProcDeviceCreateTexture = Ptr{Cvoid}

# typedef void ( * WGPUProcDeviceDestroy ) ( WGPUDevice device )
const WGPUProcDeviceDestroy = Ptr{Cvoid}

# typedef size_t ( * WGPUProcDeviceEnumerateFeatures ) ( WGPUDevice device , WGPUFeatureName * features )
const WGPUProcDeviceEnumerateFeatures = Ptr{Cvoid}

# typedef WGPUBool ( * WGPUProcDeviceGetLimits ) ( WGPUDevice device , WGPUSupportedLimits * limits )
const WGPUProcDeviceGetLimits = Ptr{Cvoid}

# typedef WGPUQueue ( * WGPUProcDeviceGetQueue ) ( WGPUDevice device )
const WGPUProcDeviceGetQueue = Ptr{Cvoid}

# typedef WGPUBool ( * WGPUProcDeviceHasFeature ) ( WGPUDevice device , WGPUFeatureName feature )
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

# typedef void ( * WGPUProcSurfaceConfigure ) ( WGPUSurface surface , WGPUSurfaceConfiguration const * config )
const WGPUProcSurfaceConfigure = Ptr{Cvoid}

# typedef void ( * WGPUProcSurfaceGetCapabilities ) ( WGPUSurface surface , WGPUAdapter adapter , WGPUSurfaceCapabilities * capabilities )
const WGPUProcSurfaceGetCapabilities = Ptr{Cvoid}

# typedef void ( * WGPUProcSurfaceGetCurrentTexture ) ( WGPUSurface surface , WGPUSurfaceTexture * surfaceTexture )
const WGPUProcSurfaceGetCurrentTexture = Ptr{Cvoid}

# typedef WGPUTextureFormat ( * WGPUProcSurfaceGetPreferredFormat ) ( WGPUSurface surface , WGPUAdapter adapter )
const WGPUProcSurfaceGetPreferredFormat = Ptr{Cvoid}

# typedef void ( * WGPUProcSurfacePresent ) ( WGPUSurface surface )
const WGPUProcSurfacePresent = Ptr{Cvoid}

# typedef void ( * WGPUProcSurfaceUnconfigure ) ( WGPUSurface surface )
const WGPUProcSurfaceUnconfigure = Ptr{Cvoid}

# typedef void ( * WGPUProcSurfaceReference ) ( WGPUSurface surface )
const WGPUProcSurfaceReference = Ptr{Cvoid}

# typedef void ( * WGPUProcSurfaceRelease ) ( WGPUSurface surface )
const WGPUProcSurfaceRelease = Ptr{Cvoid}

# typedef void ( * WGPUProcSurfaceCapabilitiesFreeMembers ) ( WGPUSurfaceCapabilities capabilities )
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
    @ccall libWGPU.wgpuCreateInstance(descriptor::Ptr{WGPUInstanceDescriptor})::WGPUInstance
end

function wgpuGetProcAddress(device, procName)
    @ccall libWGPU.wgpuGetProcAddress(device::WGPUDevice, procName::Ptr{Cchar})::WGPUProc
end

function wgpuAdapterEnumerateFeatures(adapter, features)
    @ccall libWGPU.wgpuAdapterEnumerateFeatures(adapter::WGPUAdapter, features::Ptr{WGPUFeatureName})::Csize_t
end

function wgpuAdapterGetLimits(adapter, limits)
    @ccall libWGPU.wgpuAdapterGetLimits(adapter::WGPUAdapter, limits::Ptr{WGPUSupportedLimits})::WGPUBool
end

function wgpuAdapterGetProperties(adapter, properties)
    @ccall libWGPU.wgpuAdapterGetProperties(adapter::WGPUAdapter, properties::Ptr{WGPUAdapterProperties})::Cvoid
end

function wgpuAdapterHasFeature(adapter, feature)
    @ccall libWGPU.wgpuAdapterHasFeature(adapter::WGPUAdapter, feature::WGPUFeatureName)::WGPUBool
end

function wgpuAdapterRequestDevice(adapter, descriptor, callback, userdata)
    @ccall libWGPU.wgpuAdapterRequestDevice(adapter::WGPUAdapter, descriptor::Ptr{WGPUDeviceDescriptor}, callback::WGPURequestDeviceCallback, userdata::Ptr{Cvoid})::Cvoid
end

function wgpuAdapterReference(adapter)
    @ccall libWGPU.wgpuAdapterReference(adapter::WGPUAdapter)::Cvoid
end

function wgpuAdapterRelease(adapter)
    @ccall libWGPU.wgpuAdapterRelease(adapter::WGPUAdapter)::Cvoid
end

function wgpuBindGroupSetLabel(bindGroup, label)
    @ccall libWGPU.wgpuBindGroupSetLabel(bindGroup::WGPUBindGroup, label::Ptr{Cchar})::Cvoid
end

function wgpuBindGroupReference(bindGroup)
    @ccall libWGPU.wgpuBindGroupReference(bindGroup::WGPUBindGroup)::Cvoid
end

function wgpuBindGroupRelease(bindGroup)
    @ccall libWGPU.wgpuBindGroupRelease(bindGroup::WGPUBindGroup)::Cvoid
end

function wgpuBindGroupLayoutSetLabel(bindGroupLayout, label)
    @ccall libWGPU.wgpuBindGroupLayoutSetLabel(bindGroupLayout::WGPUBindGroupLayout, label::Ptr{Cchar})::Cvoid
end

function wgpuBindGroupLayoutReference(bindGroupLayout)
    @ccall libWGPU.wgpuBindGroupLayoutReference(bindGroupLayout::WGPUBindGroupLayout)::Cvoid
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
    @ccall libWGPU.wgpuBufferGetUsage(buffer::WGPUBuffer)::WGPUBufferUsageFlags
end

function wgpuBufferMapAsync(buffer, mode, offset, size, callback, userdata)
    @ccall libWGPU.wgpuBufferMapAsync(buffer::WGPUBuffer, mode::WGPUMapModeFlags, offset::Csize_t, size::Csize_t, callback::WGPUBufferMapCallback, userdata::Ptr{Cvoid})::Cvoid
end

function wgpuBufferSetLabel(buffer, label)
    @ccall libWGPU.wgpuBufferSetLabel(buffer::WGPUBuffer, label::Ptr{Cchar})::Cvoid
end

function wgpuBufferUnmap(buffer)
    @ccall libWGPU.wgpuBufferUnmap(buffer::WGPUBuffer)::Cvoid
end

function wgpuBufferReference(buffer)
    @ccall libWGPU.wgpuBufferReference(buffer::WGPUBuffer)::Cvoid
end

function wgpuBufferRelease(buffer)
    @ccall libWGPU.wgpuBufferRelease(buffer::WGPUBuffer)::Cvoid
end

function wgpuCommandBufferSetLabel(commandBuffer, label)
    @ccall libWGPU.wgpuCommandBufferSetLabel(commandBuffer::WGPUCommandBuffer, label::Ptr{Cchar})::Cvoid
end

function wgpuCommandBufferReference(commandBuffer)
    @ccall libWGPU.wgpuCommandBufferReference(commandBuffer::WGPUCommandBuffer)::Cvoid
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
    @ccall libWGPU.wgpuCommandEncoderCopyBufferToTexture(commandEncoder::WGPUCommandEncoder, source::Ptr{WGPUImageCopyBuffer}, destination::Ptr{WGPUImageCopyTexture}, copySize::Ptr{WGPUExtent3D})::Cvoid
end

function wgpuCommandEncoderCopyTextureToBuffer(commandEncoder, source, destination, copySize)
    @ccall libWGPU.wgpuCommandEncoderCopyTextureToBuffer(commandEncoder::WGPUCommandEncoder, source::Ptr{WGPUImageCopyTexture}, destination::Ptr{WGPUImageCopyBuffer}, copySize::Ptr{WGPUExtent3D})::Cvoid
end

function wgpuCommandEncoderCopyTextureToTexture(commandEncoder, source, destination, copySize)
    @ccall libWGPU.wgpuCommandEncoderCopyTextureToTexture(commandEncoder::WGPUCommandEncoder, source::Ptr{WGPUImageCopyTexture}, destination::Ptr{WGPUImageCopyTexture}, copySize::Ptr{WGPUExtent3D})::Cvoid
end

function wgpuCommandEncoderFinish(commandEncoder, descriptor)
    @ccall libWGPU.wgpuCommandEncoderFinish(commandEncoder::WGPUCommandEncoder, descriptor::Ptr{WGPUCommandBufferDescriptor})::WGPUCommandBuffer
end

function wgpuCommandEncoderInsertDebugMarker(commandEncoder, markerLabel)
    @ccall libWGPU.wgpuCommandEncoderInsertDebugMarker(commandEncoder::WGPUCommandEncoder, markerLabel::Ptr{Cchar})::Cvoid
end

function wgpuCommandEncoderPopDebugGroup(commandEncoder)
    @ccall libWGPU.wgpuCommandEncoderPopDebugGroup(commandEncoder::WGPUCommandEncoder)::Cvoid
end

function wgpuCommandEncoderPushDebugGroup(commandEncoder, groupLabel)
    @ccall libWGPU.wgpuCommandEncoderPushDebugGroup(commandEncoder::WGPUCommandEncoder, groupLabel::Ptr{Cchar})::Cvoid
end

function wgpuCommandEncoderResolveQuerySet(commandEncoder, querySet, firstQuery, queryCount, destination, destinationOffset)
    @ccall libWGPU.wgpuCommandEncoderResolveQuerySet(commandEncoder::WGPUCommandEncoder, querySet::WGPUQuerySet, firstQuery::UInt32, queryCount::UInt32, destination::WGPUBuffer, destinationOffset::UInt64)::Cvoid
end

function wgpuCommandEncoderSetLabel(commandEncoder, label)
    @ccall libWGPU.wgpuCommandEncoderSetLabel(commandEncoder::WGPUCommandEncoder, label::Ptr{Cchar})::Cvoid
end

function wgpuCommandEncoderWriteTimestamp(commandEncoder, querySet, queryIndex)
    @ccall libWGPU.wgpuCommandEncoderWriteTimestamp(commandEncoder::WGPUCommandEncoder, querySet::WGPUQuerySet, queryIndex::UInt32)::Cvoid
end

function wgpuCommandEncoderReference(commandEncoder)
    @ccall libWGPU.wgpuCommandEncoderReference(commandEncoder::WGPUCommandEncoder)::Cvoid
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
    @ccall libWGPU.wgpuComputePassEncoderInsertDebugMarker(computePassEncoder::WGPUComputePassEncoder, markerLabel::Ptr{Cchar})::Cvoid
end

function wgpuComputePassEncoderPopDebugGroup(computePassEncoder)
    @ccall libWGPU.wgpuComputePassEncoderPopDebugGroup(computePassEncoder::WGPUComputePassEncoder)::Cvoid
end

function wgpuComputePassEncoderPushDebugGroup(computePassEncoder, groupLabel)
    @ccall libWGPU.wgpuComputePassEncoderPushDebugGroup(computePassEncoder::WGPUComputePassEncoder, groupLabel::Ptr{Cchar})::Cvoid
end

function wgpuComputePassEncoderSetBindGroup(computePassEncoder, groupIndex, group, dynamicOffsetCount, dynamicOffsets)
    @ccall libWGPU.wgpuComputePassEncoderSetBindGroup(computePassEncoder::WGPUComputePassEncoder, groupIndex::UInt32, group::WGPUBindGroup, dynamicOffsetCount::Csize_t, dynamicOffsets::Ptr{UInt32})::Cvoid
end

function wgpuComputePassEncoderSetLabel(computePassEncoder, label)
    @ccall libWGPU.wgpuComputePassEncoderSetLabel(computePassEncoder::WGPUComputePassEncoder, label::Ptr{Cchar})::Cvoid
end

function wgpuComputePassEncoderSetPipeline(computePassEncoder, pipeline)
    @ccall libWGPU.wgpuComputePassEncoderSetPipeline(computePassEncoder::WGPUComputePassEncoder, pipeline::WGPUComputePipeline)::Cvoid
end

function wgpuComputePassEncoderReference(computePassEncoder)
    @ccall libWGPU.wgpuComputePassEncoderReference(computePassEncoder::WGPUComputePassEncoder)::Cvoid
end

function wgpuComputePassEncoderRelease(computePassEncoder)
    @ccall libWGPU.wgpuComputePassEncoderRelease(computePassEncoder::WGPUComputePassEncoder)::Cvoid
end

function wgpuComputePipelineGetBindGroupLayout(computePipeline, groupIndex)
    @ccall libWGPU.wgpuComputePipelineGetBindGroupLayout(computePipeline::WGPUComputePipeline, groupIndex::UInt32)::WGPUBindGroupLayout
end

function wgpuComputePipelineSetLabel(computePipeline, label)
    @ccall libWGPU.wgpuComputePipelineSetLabel(computePipeline::WGPUComputePipeline, label::Ptr{Cchar})::Cvoid
end

function wgpuComputePipelineReference(computePipeline)
    @ccall libWGPU.wgpuComputePipelineReference(computePipeline::WGPUComputePipeline)::Cvoid
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

function wgpuDeviceCreateComputePipelineAsync(device, descriptor, callback, userdata)
    @ccall libWGPU.wgpuDeviceCreateComputePipelineAsync(device::WGPUDevice, descriptor::Ptr{WGPUComputePipelineDescriptor}, callback::WGPUCreateComputePipelineAsyncCallback, userdata::Ptr{Cvoid})::Cvoid
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

function wgpuDeviceCreateRenderPipelineAsync(device, descriptor, callback, userdata)
    @ccall libWGPU.wgpuDeviceCreateRenderPipelineAsync(device::WGPUDevice, descriptor::Ptr{WGPURenderPipelineDescriptor}, callback::WGPUCreateRenderPipelineAsyncCallback, userdata::Ptr{Cvoid})::Cvoid
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

function wgpuDeviceEnumerateFeatures(device, features)
    @ccall libWGPU.wgpuDeviceEnumerateFeatures(device::WGPUDevice, features::Ptr{WGPUFeatureName})::Csize_t
end

function wgpuDeviceGetLimits(device, limits)
    @ccall libWGPU.wgpuDeviceGetLimits(device::WGPUDevice, limits::Ptr{WGPUSupportedLimits})::WGPUBool
end

function wgpuDeviceGetQueue(device)
    @ccall libWGPU.wgpuDeviceGetQueue(device::WGPUDevice)::WGPUQueue
end

function wgpuDeviceHasFeature(device, feature)
    @ccall libWGPU.wgpuDeviceHasFeature(device::WGPUDevice, feature::WGPUFeatureName)::WGPUBool
end

function wgpuDevicePopErrorScope(device, callback, userdata)
    @ccall libWGPU.wgpuDevicePopErrorScope(device::WGPUDevice, callback::WGPUErrorCallback, userdata::Ptr{Cvoid})::Cvoid
end

function wgpuDevicePushErrorScope(device, filter)
    @ccall libWGPU.wgpuDevicePushErrorScope(device::WGPUDevice, filter::WGPUErrorFilter)::Cvoid
end

function wgpuDeviceSetLabel(device, label)
    @ccall libWGPU.wgpuDeviceSetLabel(device::WGPUDevice, label::Ptr{Cchar})::Cvoid
end

function wgpuDeviceSetUncapturedErrorCallback(device, callback, userdata)
    @ccall libWGPU.wgpuDeviceSetUncapturedErrorCallback(device::WGPUDevice, callback::WGPUErrorCallback, userdata::Ptr{Cvoid})::Cvoid
end

function wgpuDeviceReference(device)
    @ccall libWGPU.wgpuDeviceReference(device::WGPUDevice)::Cvoid
end

function wgpuDeviceRelease(device)
    @ccall libWGPU.wgpuDeviceRelease(device::WGPUDevice)::Cvoid
end

function wgpuInstanceCreateSurface(instance, descriptor)
    @ccall libWGPU.wgpuInstanceCreateSurface(instance::WGPUInstance, descriptor::Ptr{WGPUSurfaceDescriptor})::WGPUSurface
end

function wgpuInstanceProcessEvents(instance)
    @ccall libWGPU.wgpuInstanceProcessEvents(instance::WGPUInstance)::Cvoid
end

function wgpuInstanceRequestAdapter(instance, options, callback, userdata)
    @ccall libWGPU.wgpuInstanceRequestAdapter(instance::WGPUInstance, options::Ptr{WGPURequestAdapterOptions}, callback::WGPURequestAdapterCallback, userdata::Ptr{Cvoid})::Cvoid
end

function wgpuInstanceReference(instance)
    @ccall libWGPU.wgpuInstanceReference(instance::WGPUInstance)::Cvoid
end

function wgpuInstanceRelease(instance)
    @ccall libWGPU.wgpuInstanceRelease(instance::WGPUInstance)::Cvoid
end

function wgpuPipelineLayoutSetLabel(pipelineLayout, label)
    @ccall libWGPU.wgpuPipelineLayoutSetLabel(pipelineLayout::WGPUPipelineLayout, label::Ptr{Cchar})::Cvoid
end

function wgpuPipelineLayoutReference(pipelineLayout)
    @ccall libWGPU.wgpuPipelineLayoutReference(pipelineLayout::WGPUPipelineLayout)::Cvoid
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
    @ccall libWGPU.wgpuQuerySetSetLabel(querySet::WGPUQuerySet, label::Ptr{Cchar})::Cvoid
end

function wgpuQuerySetReference(querySet)
    @ccall libWGPU.wgpuQuerySetReference(querySet::WGPUQuerySet)::Cvoid
end

function wgpuQuerySetRelease(querySet)
    @ccall libWGPU.wgpuQuerySetRelease(querySet::WGPUQuerySet)::Cvoid
end

function wgpuQueueOnSubmittedWorkDone(queue, callback, userdata)
    @ccall libWGPU.wgpuQueueOnSubmittedWorkDone(queue::WGPUQueue, callback::WGPUQueueWorkDoneCallback, userdata::Ptr{Cvoid})::Cvoid
end

function wgpuQueueSetLabel(queue, label)
    @ccall libWGPU.wgpuQueueSetLabel(queue::WGPUQueue, label::Ptr{Cchar})::Cvoid
end

function wgpuQueueSubmit(queue, commandCount, commands)
    @ccall libWGPU.wgpuQueueSubmit(queue::WGPUQueue, commandCount::Csize_t, commands::Ptr{WGPUCommandBuffer})::Cvoid
end

function wgpuQueueWriteBuffer(queue, buffer, bufferOffset, data, size)
    @ccall libWGPU.wgpuQueueWriteBuffer(queue::WGPUQueue, buffer::WGPUBuffer, bufferOffset::UInt64, data::Ptr{Cvoid}, size::Csize_t)::Cvoid
end

function wgpuQueueWriteTexture(queue, destination, data, dataSize, dataLayout, writeSize)
    @ccall libWGPU.wgpuQueueWriteTexture(queue::WGPUQueue, destination::Ptr{WGPUImageCopyTexture}, data::Ptr{Cvoid}, dataSize::Csize_t, dataLayout::Ptr{WGPUTextureDataLayout}, writeSize::Ptr{WGPUExtent3D})::Cvoid
end

function wgpuQueueReference(queue)
    @ccall libWGPU.wgpuQueueReference(queue::WGPUQueue)::Cvoid
end

function wgpuQueueRelease(queue)
    @ccall libWGPU.wgpuQueueRelease(queue::WGPUQueue)::Cvoid
end

function wgpuRenderBundleSetLabel(renderBundle, label)
    @ccall libWGPU.wgpuRenderBundleSetLabel(renderBundle::WGPURenderBundle, label::Ptr{Cchar})::Cvoid
end

function wgpuRenderBundleReference(renderBundle)
    @ccall libWGPU.wgpuRenderBundleReference(renderBundle::WGPURenderBundle)::Cvoid
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
    @ccall libWGPU.wgpuRenderBundleEncoderInsertDebugMarker(renderBundleEncoder::WGPURenderBundleEncoder, markerLabel::Ptr{Cchar})::Cvoid
end

function wgpuRenderBundleEncoderPopDebugGroup(renderBundleEncoder)
    @ccall libWGPU.wgpuRenderBundleEncoderPopDebugGroup(renderBundleEncoder::WGPURenderBundleEncoder)::Cvoid
end

function wgpuRenderBundleEncoderPushDebugGroup(renderBundleEncoder, groupLabel)
    @ccall libWGPU.wgpuRenderBundleEncoderPushDebugGroup(renderBundleEncoder::WGPURenderBundleEncoder, groupLabel::Ptr{Cchar})::Cvoid
end

function wgpuRenderBundleEncoderSetBindGroup(renderBundleEncoder, groupIndex, group, dynamicOffsetCount, dynamicOffsets)
    @ccall libWGPU.wgpuRenderBundleEncoderSetBindGroup(renderBundleEncoder::WGPURenderBundleEncoder, groupIndex::UInt32, group::WGPUBindGroup, dynamicOffsetCount::Csize_t, dynamicOffsets::Ptr{UInt32})::Cvoid
end

function wgpuRenderBundleEncoderSetIndexBuffer(renderBundleEncoder, buffer, format, offset, size)
    @ccall libWGPU.wgpuRenderBundleEncoderSetIndexBuffer(renderBundleEncoder::WGPURenderBundleEncoder, buffer::WGPUBuffer, format::WGPUIndexFormat, offset::UInt64, size::UInt64)::Cvoid
end

function wgpuRenderBundleEncoderSetLabel(renderBundleEncoder, label)
    @ccall libWGPU.wgpuRenderBundleEncoderSetLabel(renderBundleEncoder::WGPURenderBundleEncoder, label::Ptr{Cchar})::Cvoid
end

function wgpuRenderBundleEncoderSetPipeline(renderBundleEncoder, pipeline)
    @ccall libWGPU.wgpuRenderBundleEncoderSetPipeline(renderBundleEncoder::WGPURenderBundleEncoder, pipeline::WGPURenderPipeline)::Cvoid
end

function wgpuRenderBundleEncoderSetVertexBuffer(renderBundleEncoder, slot, buffer, offset, size)
    @ccall libWGPU.wgpuRenderBundleEncoderSetVertexBuffer(renderBundleEncoder::WGPURenderBundleEncoder, slot::UInt32, buffer::WGPUBuffer, offset::UInt64, size::UInt64)::Cvoid
end

function wgpuRenderBundleEncoderReference(renderBundleEncoder)
    @ccall libWGPU.wgpuRenderBundleEncoderReference(renderBundleEncoder::WGPURenderBundleEncoder)::Cvoid
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
    @ccall libWGPU.wgpuRenderPassEncoderInsertDebugMarker(renderPassEncoder::WGPURenderPassEncoder, markerLabel::Ptr{Cchar})::Cvoid
end

function wgpuRenderPassEncoderPopDebugGroup(renderPassEncoder)
    @ccall libWGPU.wgpuRenderPassEncoderPopDebugGroup(renderPassEncoder::WGPURenderPassEncoder)::Cvoid
end

function wgpuRenderPassEncoderPushDebugGroup(renderPassEncoder, groupLabel)
    @ccall libWGPU.wgpuRenderPassEncoderPushDebugGroup(renderPassEncoder::WGPURenderPassEncoder, groupLabel::Ptr{Cchar})::Cvoid
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
    @ccall libWGPU.wgpuRenderPassEncoderSetLabel(renderPassEncoder::WGPURenderPassEncoder, label::Ptr{Cchar})::Cvoid
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

function wgpuRenderPassEncoderReference(renderPassEncoder)
    @ccall libWGPU.wgpuRenderPassEncoderReference(renderPassEncoder::WGPURenderPassEncoder)::Cvoid
end

function wgpuRenderPassEncoderRelease(renderPassEncoder)
    @ccall libWGPU.wgpuRenderPassEncoderRelease(renderPassEncoder::WGPURenderPassEncoder)::Cvoid
end

function wgpuRenderPipelineGetBindGroupLayout(renderPipeline, groupIndex)
    @ccall libWGPU.wgpuRenderPipelineGetBindGroupLayout(renderPipeline::WGPURenderPipeline, groupIndex::UInt32)::WGPUBindGroupLayout
end

function wgpuRenderPipelineSetLabel(renderPipeline, label)
    @ccall libWGPU.wgpuRenderPipelineSetLabel(renderPipeline::WGPURenderPipeline, label::Ptr{Cchar})::Cvoid
end

function wgpuRenderPipelineReference(renderPipeline)
    @ccall libWGPU.wgpuRenderPipelineReference(renderPipeline::WGPURenderPipeline)::Cvoid
end

function wgpuRenderPipelineRelease(renderPipeline)
    @ccall libWGPU.wgpuRenderPipelineRelease(renderPipeline::WGPURenderPipeline)::Cvoid
end

function wgpuSamplerSetLabel(sampler, label)
    @ccall libWGPU.wgpuSamplerSetLabel(sampler::WGPUSampler, label::Ptr{Cchar})::Cvoid
end

function wgpuSamplerReference(sampler)
    @ccall libWGPU.wgpuSamplerReference(sampler::WGPUSampler)::Cvoid
end

function wgpuSamplerRelease(sampler)
    @ccall libWGPU.wgpuSamplerRelease(sampler::WGPUSampler)::Cvoid
end

function wgpuShaderModuleGetCompilationInfo(shaderModule, callback, userdata)
    @ccall libWGPU.wgpuShaderModuleGetCompilationInfo(shaderModule::WGPUShaderModule, callback::WGPUCompilationInfoCallback, userdata::Ptr{Cvoid})::Cvoid
end

function wgpuShaderModuleSetLabel(shaderModule, label)
    @ccall libWGPU.wgpuShaderModuleSetLabel(shaderModule::WGPUShaderModule, label::Ptr{Cchar})::Cvoid
end

function wgpuShaderModuleReference(shaderModule)
    @ccall libWGPU.wgpuShaderModuleReference(shaderModule::WGPUShaderModule)::Cvoid
end

function wgpuShaderModuleRelease(shaderModule)
    @ccall libWGPU.wgpuShaderModuleRelease(shaderModule::WGPUShaderModule)::Cvoid
end

function wgpuSurfaceConfigure(surface, config)
    @ccall libWGPU.wgpuSurfaceConfigure(surface::WGPUSurface, config::Ptr{WGPUSurfaceConfiguration})::Cvoid
end

function wgpuSurfaceGetCapabilities(surface, adapter, capabilities)
    @ccall libWGPU.wgpuSurfaceGetCapabilities(surface::WGPUSurface, adapter::WGPUAdapter, capabilities::Ptr{WGPUSurfaceCapabilities})::Cvoid
end

function wgpuSurfaceGetCurrentTexture(surface, surfaceTexture)
    @ccall libWGPU.wgpuSurfaceGetCurrentTexture(surface::WGPUSurface, surfaceTexture::Ptr{WGPUSurfaceTexture})::Cvoid
end

function wgpuSurfaceGetPreferredFormat(surface, adapter)
    @ccall libWGPU.wgpuSurfaceGetPreferredFormat(surface::WGPUSurface, adapter::WGPUAdapter)::WGPUTextureFormat
end

function wgpuSurfacePresent(surface)
    @ccall libWGPU.wgpuSurfacePresent(surface::WGPUSurface)::Cvoid
end

function wgpuSurfaceUnconfigure(surface)
    @ccall libWGPU.wgpuSurfaceUnconfigure(surface::WGPUSurface)::Cvoid
end

function wgpuSurfaceReference(surface)
    @ccall libWGPU.wgpuSurfaceReference(surface::WGPUSurface)::Cvoid
end

function wgpuSurfaceRelease(surface)
    @ccall libWGPU.wgpuSurfaceRelease(surface::WGPUSurface)::Cvoid
end

function wgpuSurfaceCapabilitiesFreeMembers(capabilities)
    @ccall libWGPU.wgpuSurfaceCapabilitiesFreeMembers(capabilities::WGPUSurfaceCapabilities)::Cvoid
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
    @ccall libWGPU.wgpuTextureGetUsage(texture::WGPUTexture)::WGPUTextureUsageFlags
end

function wgpuTextureGetWidth(texture)
    @ccall libWGPU.wgpuTextureGetWidth(texture::WGPUTexture)::UInt32
end

function wgpuTextureSetLabel(texture, label)
    @ccall libWGPU.wgpuTextureSetLabel(texture::WGPUTexture, label::Ptr{Cchar})::Cvoid
end

function wgpuTextureReference(texture)
    @ccall libWGPU.wgpuTextureReference(texture::WGPUTexture)::Cvoid
end

function wgpuTextureRelease(texture)
    @ccall libWGPU.wgpuTextureRelease(texture::WGPUTexture)::Cvoid
end

function wgpuTextureViewSetLabel(textureView, label)
    @ccall libWGPU.wgpuTextureViewSetLabel(textureView::WGPUTextureView, label::Ptr{Cchar})::Cvoid
end

function wgpuTextureViewReference(textureView)
    @ccall libWGPU.wgpuTextureViewReference(textureView::WGPUTextureView)::Cvoid
end

function wgpuTextureViewRelease(textureView)
    @ccall libWGPU.wgpuTextureViewRelease(textureView::WGPUTextureView)::Cvoid
end

@cenum WGPUNativeSType::UInt32 begin
    WGPUSType_DeviceExtras = 196609
    WGPUSType_RequiredLimitsExtras = 196610
    WGPUSType_PipelineLayoutExtras = 196611
    WGPUSType_ShaderModuleGLSLDescriptor = 196612
    WGPUSType_SupportedLimitsExtras = 196613
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
    WGPUInstanceBackend_All = 0
    WGPUInstanceBackend_Vulkan = 1
    WGPUInstanceBackend_GL = 2
    WGPUInstanceBackend_Metal = 4
    WGPUInstanceBackend_DX12 = 8
    WGPUInstanceBackend_DX11 = 16
    WGPUInstanceBackend_BrowserWebGPU = 32
    WGPUInstanceBackend_Primary = 45
    WGPUInstanceBackend_Secondary = 18
    WGPUInstanceBackend_Force32 = 2147483647
end

const WGPUInstanceBackendFlags = WGPUFlags

@cenum WGPUInstanceFlag::UInt32 begin
    WGPUInstanceFlag_Default = 0
    WGPUInstanceFlag_Debug = 1
    WGPUInstanceFlag_Validation = 2
    WGPUInstanceFlag_DiscardHalLabels = 4
    WGPUInstanceFlag_Force32 = 2147483647
end

const WGPUInstanceFlags = WGPUFlags

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
    backends::WGPUInstanceBackendFlags
    flags::WGPUInstanceFlags
    dx12ShaderCompiler::WGPUDx12Compiler
    gles3MinorVersion::WGPUGles3MinorVersion
    dxilPath::Ptr{Cchar}
    dxcPath::Ptr{Cchar}
    WGPUInstanceExtras() = new()
end

mutable struct WGPUDeviceExtras
    chain::WGPUChainedStruct
    tracePath::Ptr{Cchar}
    WGPUDeviceExtras() = new()
end

struct WGPUNativeLimits
    maxPushConstantSize::UInt32
    maxNonSamplerBindings::UInt32
end

mutable struct WGPURequiredLimitsExtras
    chain::WGPUChainedStruct
    limits::WGPUNativeLimits
    WGPURequiredLimitsExtras() = new()
end

mutable struct WGPUSupportedLimitsExtras
    chain::WGPUChainedStructOut
    limits::WGPUNativeLimits
    WGPUSupportedLimitsExtras() = new()
end

struct WGPUPushConstantRange
    stages::WGPUShaderStageFlags
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

mutable struct WGPUWrappedSubmissionIndex
    queue::WGPUQueue
    submissionIndex::WGPUSubmissionIndex
    WGPUWrappedSubmissionIndex() = new()
end

struct WGPUShaderDefine
    name::Ptr{Cchar}
    value::Ptr{Cchar}
end

mutable struct WGPUShaderModuleGLSLDescriptor
    chain::WGPUChainedStruct
    stage::WGPUShaderStage
    code::Ptr{Cchar}
    defineCount::UInt32
    defines::Ptr{WGPUShaderDefine}
    WGPUShaderModuleGLSLDescriptor() = new()
end

struct WGPURegistryReport
    numAllocated::Csize_t
    numKeptFromUser::Csize_t
    numReleasedFromUser::Csize_t
    numError::Csize_t
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
    querySets::WGPURegistryReport
    buffers::WGPURegistryReport
    textures::WGPURegistryReport
    textureViews::WGPURegistryReport
    samplers::WGPURegistryReport
end

mutable struct WGPUGlobalReport
    surfaces::WGPURegistryReport
    backendType::WGPUBackendType
    vulkan::WGPUHubReport
    metal::WGPUHubReport
    dx12::WGPUHubReport
    gl::WGPUHubReport
    WGPUGlobalReport() = new()
end

mutable struct WGPUInstanceEnumerateAdapterOptions
    nextInChain::Ptr{WGPUChainedStruct}
    backends::WGPUInstanceBackendFlags
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
    desiredMaximumFrameLatency::WGPUBool
    WGPUSurfaceConfigurationExtras() = new()
end

# typedef void ( * WGPULogCallback ) ( WGPULogLevel level , char const * message , void * userdata )
const WGPULogCallback = Ptr{Cvoid}

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
    @ccall libWGPU.wgpuDevicePoll(device::WGPUDevice, wait::WGPUBool, wrappedSubmissionIndex::Ptr{WGPUWrappedSubmissionIndex})::WGPUBool
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
    @ccall libWGPU.wgpuRenderPassEncoderSetPushConstants(encoder::WGPURenderPassEncoder, stages::WGPUShaderStageFlags, offset::UInt32, sizeBytes::UInt32, data::Ptr{Cvoid})::Cvoid
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

const WGPU_ARRAY_LAYER_COUNT_UNDEFINED = Culong(0xffffffff)

const WGPU_COPY_STRIDE_UNDEFINED = Culong(0xffffffff)

const WGPU_LIMIT_U32_UNDEFINED = Culong(0xffffffff)

const WGPU_LIMIT_U64_UNDEFINED = Culonglong(0xffffffffffffffff)

const WGPU_MIP_LEVEL_COUNT_UNDEFINED = Culong(0xffffffff)

const WGPU_QUERY_SET_INDEX_UNDEFINED = Culong(0xffffffff)

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
