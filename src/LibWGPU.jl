module LibWGPU

using CEnum

const SIZE_MAX = 1024
using Libdl
using Pkg
using Pkg.Artifacts

artifact_toml = joinpath(@__DIR__, "..", "Artifacts.toml")

wgpu_hash = artifact_hash("WGPUNative", artifact_toml)

wgpulibpath = artifact_path(wgpu_hash)

const libWGPU = "$wgpulibpath/libwgpu.$(Libdl.dlext)" |> normpath

const DEFAULT_ARRAY_SIZE = 1024


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
    WGPUBackendType_Null = 0
    WGPUBackendType_WebGPU = 1
    WGPUBackendType_D3D11 = 2
    WGPUBackendType_D3D12 = 3
    WGPUBackendType_Metal = 4
    WGPUBackendType_Vulkan = 5
    WGPUBackendType_OpenGL = 6
    WGPUBackendType_OpenGLES = 7
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
    WGPUBufferMapAsyncStatus_Error = 1
    WGPUBufferMapAsyncStatus_Unknown = 2
    WGPUBufferMapAsyncStatus_DeviceLost = 3
    WGPUBufferMapAsyncStatus_DestroyedBeforeCallback = 4
    WGPUBufferMapAsyncStatus_UnmappedBeforeCallback = 5
    WGPUBufferMapAsyncStatus_Force32 = 2147483647
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
    WGPUCreatePipelineAsyncStatus_Error = 1
    WGPUCreatePipelineAsyncStatus_DeviceLost = 2
    WGPUCreatePipelineAsyncStatus_DeviceDestroyed = 3
    WGPUCreatePipelineAsyncStatus_Unknown = 4
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
    WGPUErrorFilter_Force32 = 2147483647
end

@cenum WGPUErrorType::UInt32 begin
    WGPUErrorType_NoError = 0
    WGPUErrorType_Validation = 1
    WGPUErrorType_OutOfMemory = 2
    WGPUErrorType_Unknown = 3
    WGPUErrorType_DeviceLost = 4
    WGPUErrorType_Force32 = 2147483647
end

@cenum WGPUFeatureName::UInt32 begin
    WGPUFeatureName_Undefined = 0
    WGPUFeatureName_DepthClipControl = 1
    WGPUFeatureName_Depth24UnormStencil8 = 2
    WGPUFeatureName_Depth32FloatStencil8 = 3
    WGPUFeatureName_TimestampQuery = 4
    WGPUFeatureName_PipelineStatisticsQuery = 5
    WGPUFeatureName_TextureCompressionBC = 6
    WGPUFeatureName_TextureCompressionETC2 = 7
    WGPUFeatureName_TextureCompressionASTC = 8
    WGPUFeatureName_IndirectFirstInstance = 9
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

@cenum WGPUPredefinedColorSpace::UInt32 begin
    WGPUPredefinedColorSpace_Undefined = 0
    WGPUPredefinedColorSpace_Srgb = 1
    WGPUPredefinedColorSpace_Force32 = 2147483647
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

@cenum WGPUTextureComponentType::UInt32 begin
    WGPUTextureComponentType_Float = 0
    WGPUTextureComponentType_Sint = 1
    WGPUTextureComponentType_Uint = 2
    WGPUTextureComponentType_DepthComparison = 3
    WGPUTextureComponentType_Force32 = 2147483647
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
    WGPUTextureFormat_Depth24UnormStencil8 = 41
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
    maxVertexAttributes::UInt32
    maxVertexBufferArrayStride::UInt32
    maxInterStageShaderComponents::UInt32
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
    bindGroupLayoutCount::UInt32
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
    pipelineStatisticsCount::UInt32
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
    colorFormatsCount::UInt32
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

struct WGPURenderPassTimestampWrite
    querySet::WGPUQuerySet
    queryIndex::UInt32
    location::WGPURenderPassTimestampLocation
end

struct WGPURequestAdapterOptions
    nextInChain::Ptr{WGPUChainedStruct}
    compatibleSurface::WGPUSurface
    powerPreference::WGPUPowerPreference
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
    entryCount::UInt32
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
    messageCount::UInt32
    messages::Ptr{WGPUCompilationMessage}
end

struct WGPUComputePassDescriptor
    nextInChain::Ptr{WGPUChainedStruct}
    label::Ptr{Cchar}
    timestampWriteCount::UInt32
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
    constantCount::UInt32
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
    hintCount::UInt32
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
    viewFormatCount::UInt32
    viewFormats::Ptr{WGPUTextureFormat}
end

struct WGPUVertexBufferLayout
    arrayStride::UInt64
    stepMode::WGPUVertexStepMode
    attributeCount::UInt32
    attributes::Ptr{WGPUVertexAttribute}
end

struct WGPUBindGroupLayoutDescriptor
    nextInChain::Ptr{WGPUChainedStruct}
    label::Ptr{Cchar}
    entryCount::UInt32
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
    requiredFeaturesCount::UInt32
    requiredFeatures::Ptr{WGPUFeatureName}
    requiredLimits::Ptr{WGPURequiredLimits}
    defaultQueue::WGPUQueueDescriptor
end

struct WGPURenderPassDescriptor
    nextInChain::Ptr{WGPUChainedStruct}
    label::Ptr{Cchar}
    colorAttachmentCount::UInt32
    colorAttachments::Ptr{WGPURenderPassColorAttachment}
    depthStencilAttachment::Ptr{WGPURenderPassDepthStencilAttachment}
    occlusionQuerySet::WGPUQuerySet
    timestampWriteCount::UInt32
    timestampWrites::Ptr{WGPURenderPassTimestampWrite}
end

struct WGPUVertexState
    nextInChain::Ptr{WGPUChainedStruct}
    _module::WGPUShaderModule
    entryPoint::Ptr{Cchar}
    constantCount::UInt32
    constants::Ptr{WGPUConstantEntry}
    bufferCount::UInt32
    buffers::Ptr{WGPUVertexBufferLayout}
end

struct WGPUFragmentState
    nextInChain::Ptr{WGPUChainedStruct}
    _module::WGPUShaderModule
    entryPoint::Ptr{Cchar}
    constantCount::UInt32
    constants::Ptr{WGPUConstantEntry}
    targetCount::UInt32
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

# typedef void ( * WGPUBufferMapCallback ) ( WGPUBufferMapAsyncStatus status , void * userdata )
const WGPUBufferMapCallback = Ptr{Cvoid}

# typedef void ( * WGPUCompilationInfoCallback ) ( WGPUCompilationInfoRequestStatus status , WGPUCompilationInfo const * compilationInfo , void * userdata )
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

# typedef void ( * WGPUProcAdapterRequestDevice ) ( WGPUAdapter adapter , WGPUDeviceDescriptor const * descriptor , WGPURequestDeviceCallback callback , void * userdata )
const WGPUProcAdapterRequestDevice = Ptr{Cvoid}

# typedef void ( * WGPUProcBufferDestroy ) ( WGPUBuffer buffer )
const WGPUProcBufferDestroy = Ptr{Cvoid}

# typedef void const * ( * WGPUProcBufferGetConstMappedRange ) ( WGPUBuffer buffer , size_t offset , size_t size )
const WGPUProcBufferGetConstMappedRange = Ptr{Cvoid}

# typedef void * ( * WGPUProcBufferGetMappedRange ) ( WGPUBuffer buffer , size_t offset , size_t size )
const WGPUProcBufferGetMappedRange = Ptr{Cvoid}

# typedef void ( * WGPUProcBufferMapAsync ) ( WGPUBuffer buffer , WGPUMapModeFlags mode , size_t offset , size_t size , WGPUBufferMapCallback callback , void * userdata )
const WGPUProcBufferMapAsync = Ptr{Cvoid}

# typedef void ( * WGPUProcBufferUnmap ) ( WGPUBuffer buffer )
const WGPUProcBufferUnmap = Ptr{Cvoid}

# typedef WGPUComputePassEncoder ( * WGPUProcCommandEncoderBeginComputePass ) ( WGPUCommandEncoder commandEncoder , WGPUComputePassDescriptor const * descriptor )
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

# typedef WGPUCommandBuffer ( * WGPUProcCommandEncoderFinish ) ( WGPUCommandEncoder commandEncoder , WGPUCommandBufferDescriptor const * descriptor )
const WGPUProcCommandEncoderFinish = Ptr{Cvoid}

# typedef void ( * WGPUProcCommandEncoderInsertDebugMarker ) ( WGPUCommandEncoder commandEncoder , char const * markerLabel )
const WGPUProcCommandEncoderInsertDebugMarker = Ptr{Cvoid}

# typedef void ( * WGPUProcCommandEncoderPopDebugGroup ) ( WGPUCommandEncoder commandEncoder )
const WGPUProcCommandEncoderPopDebugGroup = Ptr{Cvoid}

# typedef void ( * WGPUProcCommandEncoderPushDebugGroup ) ( WGPUCommandEncoder commandEncoder , char const * groupLabel )
const WGPUProcCommandEncoderPushDebugGroup = Ptr{Cvoid}

# typedef void ( * WGPUProcCommandEncoderResolveQuerySet ) ( WGPUCommandEncoder commandEncoder , WGPUQuerySet querySet , uint32_t firstQuery , uint32_t queryCount , WGPUBuffer destination , uint64_t destinationOffset )
const WGPUProcCommandEncoderResolveQuerySet = Ptr{Cvoid}

# typedef void ( * WGPUProcCommandEncoderWriteTimestamp ) ( WGPUCommandEncoder commandEncoder , WGPUQuerySet querySet , uint32_t queryIndex )
const WGPUProcCommandEncoderWriteTimestamp = Ptr{Cvoid}

# typedef void ( * WGPUProcComputePassEncoderBeginPipelineStatisticsQuery ) ( WGPUComputePassEncoder computePassEncoder , WGPUQuerySet querySet , uint32_t queryIndex )
const WGPUProcComputePassEncoderBeginPipelineStatisticsQuery = Ptr{Cvoid}

# typedef void ( * WGPUProcComputePassEncoderDispatch ) ( WGPUComputePassEncoder computePassEncoder , uint32_t workgroupCountX , uint32_t workgroupCountY , uint32_t workgroupCountZ )
const WGPUProcComputePassEncoderDispatch = Ptr{Cvoid}

# typedef void ( * WGPUProcComputePassEncoderDispatchIndirect ) ( WGPUComputePassEncoder computePassEncoder , WGPUBuffer indirectBuffer , uint64_t indirectOffset )
const WGPUProcComputePassEncoderDispatchIndirect = Ptr{Cvoid}

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

# typedef void ( * WGPUProcComputePassEncoderSetBindGroup ) ( WGPUComputePassEncoder computePassEncoder , uint32_t groupIndex , WGPUBindGroup group , uint32_t dynamicOffsetCount , uint32_t const * dynamicOffsets )
const WGPUProcComputePassEncoderSetBindGroup = Ptr{Cvoid}

# typedef void ( * WGPUProcComputePassEncoderSetPipeline ) ( WGPUComputePassEncoder computePassEncoder , WGPUComputePipeline pipeline )
const WGPUProcComputePassEncoderSetPipeline = Ptr{Cvoid}

# typedef WGPUBindGroupLayout ( * WGPUProcComputePipelineGetBindGroupLayout ) ( WGPUComputePipeline computePipeline , uint32_t groupIndex )
const WGPUProcComputePipelineGetBindGroupLayout = Ptr{Cvoid}

# typedef void ( * WGPUProcComputePipelineSetLabel ) ( WGPUComputePipeline computePipeline , char const * label )
const WGPUProcComputePipelineSetLabel = Ptr{Cvoid}

# typedef WGPUBindGroup ( * WGPUProcDeviceCreateBindGroup ) ( WGPUDevice device , WGPUBindGroupDescriptor const * descriptor )
const WGPUProcDeviceCreateBindGroup = Ptr{Cvoid}

# typedef WGPUBindGroupLayout ( * WGPUProcDeviceCreateBindGroupLayout ) ( WGPUDevice device , WGPUBindGroupLayoutDescriptor const * descriptor )
const WGPUProcDeviceCreateBindGroupLayout = Ptr{Cvoid}

# typedef WGPUBuffer ( * WGPUProcDeviceCreateBuffer ) ( WGPUDevice device , WGPUBufferDescriptor const * descriptor )
const WGPUProcDeviceCreateBuffer = Ptr{Cvoid}

# typedef WGPUCommandEncoder ( * WGPUProcDeviceCreateCommandEncoder ) ( WGPUDevice device , WGPUCommandEncoderDescriptor const * descriptor )
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

# typedef WGPUSampler ( * WGPUProcDeviceCreateSampler ) ( WGPUDevice device , WGPUSamplerDescriptor const * descriptor )
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

# typedef bool ( * WGPUProcDevicePopErrorScope ) ( WGPUDevice device , WGPUErrorCallback callback , void * userdata )
const WGPUProcDevicePopErrorScope = Ptr{Cvoid}

# typedef void ( * WGPUProcDevicePushErrorScope ) ( WGPUDevice device , WGPUErrorFilter filter )
const WGPUProcDevicePushErrorScope = Ptr{Cvoid}

# typedef void ( * WGPUProcDeviceSetDeviceLostCallback ) ( WGPUDevice device , WGPUDeviceLostCallback callback , void * userdata )
const WGPUProcDeviceSetDeviceLostCallback = Ptr{Cvoid}

# typedef void ( * WGPUProcDeviceSetUncapturedErrorCallback ) ( WGPUDevice device , WGPUErrorCallback callback , void * userdata )
const WGPUProcDeviceSetUncapturedErrorCallback = Ptr{Cvoid}

# typedef WGPUSurface ( * WGPUProcInstanceCreateSurface ) ( WGPUInstance instance , WGPUSurfaceDescriptor const * descriptor )
const WGPUProcInstanceCreateSurface = Ptr{Cvoid}

# typedef void ( * WGPUProcInstanceProcessEvents ) ( WGPUInstance instance )
const WGPUProcInstanceProcessEvents = Ptr{Cvoid}

# typedef void ( * WGPUProcInstanceRequestAdapter ) ( WGPUInstance instance , WGPURequestAdapterOptions const * options , WGPURequestAdapterCallback callback , void * userdata )
const WGPUProcInstanceRequestAdapter = Ptr{Cvoid}

# typedef void ( * WGPUProcQuerySetDestroy ) ( WGPUQuerySet querySet )
const WGPUProcQuerySetDestroy = Ptr{Cvoid}

# typedef void ( * WGPUProcQueueOnSubmittedWorkDone ) ( WGPUQueue queue , WGPUQueueWorkDoneCallback callback , void * userdata )
const WGPUProcQueueOnSubmittedWorkDone = Ptr{Cvoid}

# typedef void ( * WGPUProcQueueSubmit ) ( WGPUQueue queue , uint32_t commandCount , WGPUCommandBuffer const * commands )
const WGPUProcQueueSubmit = Ptr{Cvoid}

# typedef void ( * WGPUProcQueueWriteBuffer ) ( WGPUQueue queue , WGPUBuffer buffer , uint64_t bufferOffset , void const * data , size_t size )
const WGPUProcQueueWriteBuffer = Ptr{Cvoid}

# typedef void ( * WGPUProcQueueWriteTexture ) ( WGPUQueue queue , WGPUImageCopyTexture const * destination , void const * data , size_t dataSize , WGPUTextureDataLayout const * dataLayout , WGPUExtent3D const * writeSize )
const WGPUProcQueueWriteTexture = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderBundleEncoderDraw ) ( WGPURenderBundleEncoder renderBundleEncoder , uint32_t vertexCount , uint32_t instanceCount , uint32_t firstVertex , uint32_t firstInstance )
const WGPUProcRenderBundleEncoderDraw = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderBundleEncoderDrawIndexed ) ( WGPURenderBundleEncoder renderBundleEncoder , uint32_t indexCount , uint32_t instanceCount , uint32_t firstIndex , int32_t baseVertex , uint32_t firstInstance )
const WGPUProcRenderBundleEncoderDrawIndexed = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderBundleEncoderDrawIndexedIndirect ) ( WGPURenderBundleEncoder renderBundleEncoder , WGPUBuffer indirectBuffer , uint64_t indirectOffset )
const WGPUProcRenderBundleEncoderDrawIndexedIndirect = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderBundleEncoderDrawIndirect ) ( WGPURenderBundleEncoder renderBundleEncoder , WGPUBuffer indirectBuffer , uint64_t indirectOffset )
const WGPUProcRenderBundleEncoderDrawIndirect = Ptr{Cvoid}

# typedef WGPURenderBundle ( * WGPUProcRenderBundleEncoderFinish ) ( WGPURenderBundleEncoder renderBundleEncoder , WGPURenderBundleDescriptor const * descriptor )
const WGPUProcRenderBundleEncoderFinish = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderBundleEncoderInsertDebugMarker ) ( WGPURenderBundleEncoder renderBundleEncoder , char const * markerLabel )
const WGPUProcRenderBundleEncoderInsertDebugMarker = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderBundleEncoderPopDebugGroup ) ( WGPURenderBundleEncoder renderBundleEncoder )
const WGPUProcRenderBundleEncoderPopDebugGroup = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderBundleEncoderPushDebugGroup ) ( WGPURenderBundleEncoder renderBundleEncoder , char const * groupLabel )
const WGPUProcRenderBundleEncoderPushDebugGroup = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderBundleEncoderSetBindGroup ) ( WGPURenderBundleEncoder renderBundleEncoder , uint32_t groupIndex , WGPUBindGroup group , uint32_t dynamicOffsetCount , uint32_t const * dynamicOffsets )
const WGPUProcRenderBundleEncoderSetBindGroup = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderBundleEncoderSetIndexBuffer ) ( WGPURenderBundleEncoder renderBundleEncoder , WGPUBuffer buffer , WGPUIndexFormat format , uint64_t offset , uint64_t size )
const WGPUProcRenderBundleEncoderSetIndexBuffer = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderBundleEncoderSetPipeline ) ( WGPURenderBundleEncoder renderBundleEncoder , WGPURenderPipeline pipeline )
const WGPUProcRenderBundleEncoderSetPipeline = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderBundleEncoderSetVertexBuffer ) ( WGPURenderBundleEncoder renderBundleEncoder , uint32_t slot , WGPUBuffer buffer , uint64_t offset , uint64_t size )
const WGPUProcRenderBundleEncoderSetVertexBuffer = Ptr{Cvoid}

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

# typedef void ( * WGPUProcRenderPassEncoderExecuteBundles ) ( WGPURenderPassEncoder renderPassEncoder , uint32_t bundlesCount , WGPURenderBundle const * bundles )
const WGPUProcRenderPassEncoderExecuteBundles = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderPassEncoderInsertDebugMarker ) ( WGPURenderPassEncoder renderPassEncoder , char const * markerLabel )
const WGPUProcRenderPassEncoderInsertDebugMarker = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderPassEncoderPopDebugGroup ) ( WGPURenderPassEncoder renderPassEncoder )
const WGPUProcRenderPassEncoderPopDebugGroup = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderPassEncoderPushDebugGroup ) ( WGPURenderPassEncoder renderPassEncoder , char const * groupLabel )
const WGPUProcRenderPassEncoderPushDebugGroup = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderPassEncoderSetBindGroup ) ( WGPURenderPassEncoder renderPassEncoder , uint32_t groupIndex , WGPUBindGroup group , uint32_t dynamicOffsetCount , uint32_t const * dynamicOffsets )
const WGPUProcRenderPassEncoderSetBindGroup = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderPassEncoderSetBlendConstant ) ( WGPURenderPassEncoder renderPassEncoder , WGPUColor const * color )
const WGPUProcRenderPassEncoderSetBlendConstant = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderPassEncoderSetIndexBuffer ) ( WGPURenderPassEncoder renderPassEncoder , WGPUBuffer buffer , WGPUIndexFormat format , uint64_t offset , uint64_t size )
const WGPUProcRenderPassEncoderSetIndexBuffer = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderPassEncoderSetPipeline ) ( WGPURenderPassEncoder renderPassEncoder , WGPURenderPipeline pipeline )
const WGPUProcRenderPassEncoderSetPipeline = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderPassEncoderSetScissorRect ) ( WGPURenderPassEncoder renderPassEncoder , uint32_t x , uint32_t y , uint32_t width , uint32_t height )
const WGPUProcRenderPassEncoderSetScissorRect = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderPassEncoderSetStencilReference ) ( WGPURenderPassEncoder renderPassEncoder , uint32_t reference )
const WGPUProcRenderPassEncoderSetStencilReference = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderPassEncoderSetVertexBuffer ) ( WGPURenderPassEncoder renderPassEncoder , uint32_t slot , WGPUBuffer buffer , uint64_t offset , uint64_t size )
const WGPUProcRenderPassEncoderSetVertexBuffer = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderPassEncoderSetViewport ) ( WGPURenderPassEncoder renderPassEncoder , float x , float y , float width , float height , float minDepth , float maxDepth )
const WGPUProcRenderPassEncoderSetViewport = Ptr{Cvoid}

# typedef WGPUBindGroupLayout ( * WGPUProcRenderPipelineGetBindGroupLayout ) ( WGPURenderPipeline renderPipeline , uint32_t groupIndex )
const WGPUProcRenderPipelineGetBindGroupLayout = Ptr{Cvoid}

# typedef void ( * WGPUProcRenderPipelineSetLabel ) ( WGPURenderPipeline renderPipeline , char const * label )
const WGPUProcRenderPipelineSetLabel = Ptr{Cvoid}

# typedef void ( * WGPUProcShaderModuleGetCompilationInfo ) ( WGPUShaderModule shaderModule , WGPUCompilationInfoCallback callback , void * userdata )
const WGPUProcShaderModuleGetCompilationInfo = Ptr{Cvoid}

# typedef void ( * WGPUProcShaderModuleSetLabel ) ( WGPUShaderModule shaderModule , char const * label )
const WGPUProcShaderModuleSetLabel = Ptr{Cvoid}

# typedef WGPUTextureFormat ( * WGPUProcSurfaceGetPreferredFormat ) ( WGPUSurface surface , WGPUAdapter adapter )
const WGPUProcSurfaceGetPreferredFormat = Ptr{Cvoid}

# typedef WGPUTextureView ( * WGPUProcSwapChainGetCurrentTextureView ) ( WGPUSwapChain swapChain )
const WGPUProcSwapChainGetCurrentTextureView = Ptr{Cvoid}

# typedef void ( * WGPUProcSwapChainPresent ) ( WGPUSwapChain swapChain )
const WGPUProcSwapChainPresent = Ptr{Cvoid}

# typedef WGPUTextureView ( * WGPUProcTextureCreateView ) ( WGPUTexture texture , WGPUTextureViewDescriptor const * descriptor )
const WGPUProcTextureCreateView = Ptr{Cvoid}

# typedef void ( * WGPUProcTextureDestroy ) ( WGPUTexture texture )
const WGPUProcTextureDestroy = Ptr{Cvoid}

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

function wgpuBufferDestroy(buffer)
    ccall((:wgpuBufferDestroy, libWGPU), Cvoid, (WGPUBuffer,), buffer)
end

function wgpuBufferGetConstMappedRange(buffer, offset, size)
    ccall((:wgpuBufferGetConstMappedRange, libWGPU), Ptr{Cvoid}, (WGPUBuffer, Csize_t, Csize_t), buffer, offset, size)
end

function wgpuBufferGetMappedRange(buffer, offset, size)
    ccall((:wgpuBufferGetMappedRange, libWGPU), Ptr{Cvoid}, (WGPUBuffer, Csize_t, Csize_t), buffer, offset, size)
end

function wgpuBufferMapAsync(buffer, mode, offset, size, callback, userdata)
    ccall((:wgpuBufferMapAsync, libWGPU), Cvoid, (WGPUBuffer, WGPUMapModeFlags, Csize_t, Csize_t, WGPUBufferMapCallback, Ptr{Cvoid}), buffer, mode, offset, size, callback, userdata)
end

function wgpuBufferUnmap(buffer)
    ccall((:wgpuBufferUnmap, libWGPU), Cvoid, (WGPUBuffer,), buffer)
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

function wgpuCommandEncoderWriteTimestamp(commandEncoder, querySet, queryIndex)
    ccall((:wgpuCommandEncoderWriteTimestamp, libWGPU), Cvoid, (WGPUCommandEncoder, WGPUQuerySet, UInt32), commandEncoder, querySet, queryIndex)
end

function wgpuComputePassEncoderBeginPipelineStatisticsQuery(computePassEncoder, querySet, queryIndex)
    ccall((:wgpuComputePassEncoderBeginPipelineStatisticsQuery, libWGPU), Cvoid, (WGPUComputePassEncoder, WGPUQuerySet, UInt32), computePassEncoder, querySet, queryIndex)
end

function wgpuComputePassEncoderDispatch(computePassEncoder, workgroupCountX, workgroupCountY, workgroupCountZ)
    ccall((:wgpuComputePassEncoderDispatch, libWGPU), Cvoid, (WGPUComputePassEncoder, UInt32, UInt32, UInt32), computePassEncoder, workgroupCountX, workgroupCountY, workgroupCountZ)
end

function wgpuComputePassEncoderDispatchIndirect(computePassEncoder, indirectBuffer, indirectOffset)
    ccall((:wgpuComputePassEncoderDispatchIndirect, libWGPU), Cvoid, (WGPUComputePassEncoder, WGPUBuffer, UInt64), computePassEncoder, indirectBuffer, indirectOffset)
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
    ccall((:wgpuComputePassEncoderSetBindGroup, libWGPU), Cvoid, (WGPUComputePassEncoder, UInt32, WGPUBindGroup, UInt32, Ptr{UInt32}), computePassEncoder, groupIndex, group, dynamicOffsetCount, dynamicOffsets)
end

function wgpuComputePassEncoderSetPipeline(computePassEncoder, pipeline)
    ccall((:wgpuComputePassEncoderSetPipeline, libWGPU), Cvoid, (WGPUComputePassEncoder, WGPUComputePipeline), computePassEncoder, pipeline)
end

function wgpuComputePipelineGetBindGroupLayout(computePipeline, groupIndex)
    ccall((:wgpuComputePipelineGetBindGroupLayout, libWGPU), WGPUBindGroupLayout, (WGPUComputePipeline, UInt32), computePipeline, groupIndex)
end

function wgpuComputePipelineSetLabel(computePipeline, label)
    ccall((:wgpuComputePipelineSetLabel, libWGPU), Cvoid, (WGPUComputePipeline, Ptr{Cchar}), computePipeline, label)
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
    ccall((:wgpuDevicePopErrorScope, libWGPU), Bool, (WGPUDevice, WGPUErrorCallback, Ptr{Cvoid}), device, callback, userdata)
end

function wgpuDevicePushErrorScope(device, filter)
    ccall((:wgpuDevicePushErrorScope, libWGPU), Cvoid, (WGPUDevice, WGPUErrorFilter), device, filter)
end

function wgpuDeviceSetDeviceLostCallback(device, callback, userdata)
    ccall((:wgpuDeviceSetDeviceLostCallback, libWGPU), Cvoid, (WGPUDevice, WGPUDeviceLostCallback, Ptr{Cvoid}), device, callback, userdata)
end

function wgpuDeviceSetUncapturedErrorCallback(device, callback, userdata)
    ccall((:wgpuDeviceSetUncapturedErrorCallback, libWGPU), Cvoid, (WGPUDevice, WGPUErrorCallback, Ptr{Cvoid}), device, callback, userdata)
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

function wgpuQuerySetDestroy(querySet)
    ccall((:wgpuQuerySetDestroy, libWGPU), Cvoid, (WGPUQuerySet,), querySet)
end

function wgpuQueueOnSubmittedWorkDone(queue, callback, userdata)
    ccall((:wgpuQueueOnSubmittedWorkDone, libWGPU), Cvoid, (WGPUQueue, WGPUQueueWorkDoneCallback, Ptr{Cvoid}), queue, callback, userdata)
end

function wgpuQueueSubmit(queue, commandCount, commands)
    ccall((:wgpuQueueSubmit, libWGPU), Cvoid, (WGPUQueue, UInt32, Ptr{WGPUCommandBuffer}), queue, commandCount, commands)
end

function wgpuQueueWriteBuffer(queue, buffer, bufferOffset, data, size)
    ccall((:wgpuQueueWriteBuffer, libWGPU), Cvoid, (WGPUQueue, WGPUBuffer, UInt64, Ptr{Cvoid}, Csize_t), queue, buffer, bufferOffset, data, size)
end

function wgpuQueueWriteTexture(queue, destination, data, dataSize, dataLayout, writeSize)
    ccall((:wgpuQueueWriteTexture, libWGPU), Cvoid, (WGPUQueue, Ptr{WGPUImageCopyTexture}, Ptr{Cvoid}, Csize_t, Ptr{WGPUTextureDataLayout}, Ptr{WGPUExtent3D}), queue, destination, data, dataSize, dataLayout, writeSize)
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
    ccall((:wgpuRenderBundleEncoderSetBindGroup, libWGPU), Cvoid, (WGPURenderBundleEncoder, UInt32, WGPUBindGroup, UInt32, Ptr{UInt32}), renderBundleEncoder, groupIndex, group, dynamicOffsetCount, dynamicOffsets)
end

function wgpuRenderBundleEncoderSetIndexBuffer(renderBundleEncoder, buffer, format, offset, size)
    ccall((:wgpuRenderBundleEncoderSetIndexBuffer, libWGPU), Cvoid, (WGPURenderBundleEncoder, WGPUBuffer, WGPUIndexFormat, UInt64, UInt64), renderBundleEncoder, buffer, format, offset, size)
end

function wgpuRenderBundleEncoderSetPipeline(renderBundleEncoder, pipeline)
    ccall((:wgpuRenderBundleEncoderSetPipeline, libWGPU), Cvoid, (WGPURenderBundleEncoder, WGPURenderPipeline), renderBundleEncoder, pipeline)
end

function wgpuRenderBundleEncoderSetVertexBuffer(renderBundleEncoder, slot, buffer, offset, size)
    ccall((:wgpuRenderBundleEncoderSetVertexBuffer, libWGPU), Cvoid, (WGPURenderBundleEncoder, UInt32, WGPUBuffer, UInt64, UInt64), renderBundleEncoder, slot, buffer, offset, size)
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

function wgpuRenderPassEncoderExecuteBundles(renderPassEncoder, bundlesCount, bundles)
    ccall((:wgpuRenderPassEncoderExecuteBundles, libWGPU), Cvoid, (WGPURenderPassEncoder, UInt32, Ptr{WGPURenderBundle}), renderPassEncoder, bundlesCount, bundles)
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
    ccall((:wgpuRenderPassEncoderSetBindGroup, libWGPU), Cvoid, (WGPURenderPassEncoder, UInt32, WGPUBindGroup, UInt32, Ptr{UInt32}), renderPassEncoder, groupIndex, group, dynamicOffsetCount, dynamicOffsets)
end

function wgpuRenderPassEncoderSetBlendConstant(renderPassEncoder, color)
    ccall((:wgpuRenderPassEncoderSetBlendConstant, libWGPU), Cvoid, (WGPURenderPassEncoder, Ptr{WGPUColor}), renderPassEncoder, color)
end

function wgpuRenderPassEncoderSetIndexBuffer(renderPassEncoder, buffer, format, offset, size)
    ccall((:wgpuRenderPassEncoderSetIndexBuffer, libWGPU), Cvoid, (WGPURenderPassEncoder, WGPUBuffer, WGPUIndexFormat, UInt64, UInt64), renderPassEncoder, buffer, format, offset, size)
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

function wgpuRenderPipelineGetBindGroupLayout(renderPipeline, groupIndex)
    ccall((:wgpuRenderPipelineGetBindGroupLayout, libWGPU), WGPUBindGroupLayout, (WGPURenderPipeline, UInt32), renderPipeline, groupIndex)
end

function wgpuRenderPipelineSetLabel(renderPipeline, label)
    ccall((:wgpuRenderPipelineSetLabel, libWGPU), Cvoid, (WGPURenderPipeline, Ptr{Cchar}), renderPipeline, label)
end

function wgpuShaderModuleGetCompilationInfo(shaderModule, callback, userdata)
    ccall((:wgpuShaderModuleGetCompilationInfo, libWGPU), Cvoid, (WGPUShaderModule, WGPUCompilationInfoCallback, Ptr{Cvoid}), shaderModule, callback, userdata)
end

function wgpuShaderModuleSetLabel(shaderModule, label)
    ccall((:wgpuShaderModuleSetLabel, libWGPU), Cvoid, (WGPUShaderModule, Ptr{Cchar}), shaderModule, label)
end

function wgpuSurfaceGetPreferredFormat(surface, adapter)
    ccall((:wgpuSurfaceGetPreferredFormat, libWGPU), WGPUTextureFormat, (WGPUSurface, WGPUAdapter), surface, adapter)
end

function wgpuSwapChainGetCurrentTextureView(swapChain)
    ccall((:wgpuSwapChainGetCurrentTextureView, libWGPU), WGPUTextureView, (WGPUSwapChain,), swapChain)
end

function wgpuSwapChainPresent(swapChain)
    ccall((:wgpuSwapChainPresent, libWGPU), Cvoid, (WGPUSwapChain,), swapChain)
end

function wgpuTextureCreateView(texture, descriptor)
    ccall((:wgpuTextureCreateView, libWGPU), WGPUTextureView, (WGPUTexture, Ptr{WGPUTextureViewDescriptor}), texture, descriptor)
end

function wgpuTextureDestroy(texture)
    ccall((:wgpuTextureDestroy, libWGPU), Cvoid, (WGPUTexture,), texture)
end

@cenum WGPUNativeSType::UInt32 begin
    WGPUSType_DeviceExtras = 1610612737
    WGPUSType_AdapterExtras = 1610612738
    WGPUNativeSType_Force32 = 2147483647
end

@cenum WGPUNativeFeature::UInt32 begin
    WGPUNativeFeature_TEXTURE_ADAPTER_SPECIFIC_FORMAT_FEATURES = 268435456
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

struct WGPUAdapterExtras
    chain::WGPUChainedStruct
    backend::WGPUBackendType
end

struct WGPUDeviceExtras
    chain::WGPUChainedStruct
    nativeFeatures::WGPUNativeFeature
    label::Ptr{Cchar}
    tracePath::Ptr{Cchar}
end

# typedef void ( * WGPULogCallback ) ( WGPULogLevel level , const char * msg )
const WGPULogCallback = Ptr{Cvoid}

function wgpuDevicePoll(device, force_wait)
    ccall((:wgpuDevicePoll, libWGPU), Cvoid, (WGPUDevice, Bool), device, force_wait)
end

function wgpuSetLogCallback(callback)
    ccall((:wgpuSetLogCallback, libWGPU), Cvoid, (WGPULogCallback,), callback)
end

function wgpuSetLogLevel(level)
    ccall((:wgpuSetLogLevel, libWGPU), Cvoid, (WGPULogLevel,), level)
end

function wgpuGetVersion()
    ccall((:wgpuGetVersion, libWGPU), UInt32, ())
end

function wgpuRenderPassEncoderSetPushConstants(encoder, stages, offset, sizeBytes, data)
    ccall((:wgpuRenderPassEncoderSetPushConstants, libWGPU), Cvoid, (WGPURenderPassEncoder, WGPUShaderStageFlags, UInt32, UInt32, Ptr{Cvoid}), encoder, stages, offset, sizeBytes, data)
end

function wgpuBufferDrop(buffer)
    ccall((:wgpuBufferDrop, libWGPU), Cvoid, (WGPUBuffer,), buffer)
end

function wgpuCommandEncoderDrop(commandEncoder)
    ccall((:wgpuCommandEncoderDrop, libWGPU), Cvoid, (WGPUCommandEncoder,), commandEncoder)
end

function wgpuDeviceDrop(device)
    ccall((:wgpuDeviceDrop, libWGPU), Cvoid, (WGPUDevice,), device)
end

function wgpuQuerySetDrop(querySet)
    ccall((:wgpuQuerySetDrop, libWGPU), Cvoid, (WGPUQuerySet,), querySet)
end

function wgpuRenderPipelineDrop(renderPipeline)
    ccall((:wgpuRenderPipelineDrop, libWGPU), Cvoid, (WGPURenderPipeline,), renderPipeline)
end

function wgpuTextureDrop(texture)
    ccall((:wgpuTextureDrop, libWGPU), Cvoid, (WGPUTexture,), texture)
end

function wgpuTextureViewDrop(textureView)
    ccall((:wgpuTextureViewDrop, libWGPU), Cvoid, (WGPUTextureView,), textureView)
end

function wgpuSamplerDrop(sampler)
    ccall((:wgpuSamplerDrop, libWGPU), Cvoid, (WGPUSampler,), sampler)
end

function wgpuBindGroupLayoutDrop(bindGroupLayout)
    ccall((:wgpuBindGroupLayoutDrop, libWGPU), Cvoid, (WGPUBindGroupLayout,), bindGroupLayout)
end

function wgpuPipelineLayoutDrop(pipelineLayout)
    ccall((:wgpuPipelineLayoutDrop, libWGPU), Cvoid, (WGPUPipelineLayout,), pipelineLayout)
end

function wgpuBindGroupDrop(bindGroup)
    ccall((:wgpuBindGroupDrop, libWGPU), Cvoid, (WGPUBindGroup,), bindGroup)
end

function wgpuShaderModuleDrop(shaderModule)
    ccall((:wgpuShaderModuleDrop, libWGPU), Cvoid, (WGPUShaderModule,), shaderModule)
end

function wgpuCommandBufferDrop(commandBuffer)
    ccall((:wgpuCommandBufferDrop, libWGPU), Cvoid, (WGPUCommandBuffer,), commandBuffer)
end

function wgpuRenderBundleDrop(renderBundle)
    ccall((:wgpuRenderBundleDrop, libWGPU), Cvoid, (WGPURenderBundle,), renderBundle)
end

function wgpuComputePipelineDrop(computePipeline)
    ccall((:wgpuComputePipelineDrop, libWGPU), Cvoid, (WGPUComputePipeline,), computePipeline)
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
