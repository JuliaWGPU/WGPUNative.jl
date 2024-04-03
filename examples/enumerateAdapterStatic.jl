using WGPUNative
using StaticCompiler, StaticTools
#using Infiltrator

function mainF(argc::Int, argv::Ptr{Ptr{UInt8}})::Int64
	lib = StaticTools.dlopen(c"/Users/arhik/.julia/artifacts/8e207917f3748d7a51a6164da7b78236957c2a94/libwgpu_native.dylib")
 	createInstance = StaticTools.dlsym(lib, c"wgpuCreateInstance")
	releaseInstance = StaticTools.dlsym(lib, c"wgpuInstanceRelease")
	releaseAdapter = StaticTools.dlsym(lib, c"wgpuAdapterRelease")
	enumerateAdapters = StaticTools.dlsym(lib, c"wgpuInstanceEnumerateAdapters")
	getProperties = StaticTools.dlsym(lib, c"wgpuAdapterGetProperties")
	instance = @ptrcall createInstance(C_NULL::Ptr{Nothing})::Ptr{WGPUInstanceImpl}
	adapterCount::UInt32 = @ptrcall enumerateAdapters(instance::Ptr{WGPUInstanceImpl}, C_NULL::Ptr{Nothing}, C_NULL::Ptr{Nothing})::UInt32

	adapters = MallocArray{WGPUAdapter}(undef, adapterCount |> Int)
	refAdapters = Ref(adapters)
	GC.@preserve refAdapters begin
		pa = refAdapters[] |> pointer
		@ptrcall enumerateAdapters(instance::Ptr{WGPUInstanceImpl}, C_NULL::Ptr{Nothing}, pa::Ptr{WGPUAdapter})::UInt32
	end
	for idx in 1:adapterCount
		propertiesPtr = Ptr{WGPUAdapterProperties}(Libc.malloc(sizeof(WGPUAdapterProperties)))
		adapter = adapters[idx]
		adapterRef = Ref(adapter)
		propertiesRef = Ref(propertiesPtr)
		GC.@preserve adapterRef propertiesRef begin
			@ptrcall getProperties(adapter::Ptr{WGPUAdapterImpl}, propertiesPtr::Ptr{WGPUAdapterProperties})::Nothing
		end
		properties = unsafe_load(propertiesPtr)
		vendorID = properties.vendorID
		printf(c"VendorID : %d\n", vendorID)
		architecture = properties.architecture 
		printf(c"Architecture: %d\n", architecture)
		deviceID = properties.deviceID
		printf(c"deviceID : %d\n", deviceID)
		name = properties.name
		printf(c"name : %s\n", name |> Cstring)
		vendorName = properties.vendorName
		printf(c"vendorName : %s\n", vendorName |> Cstring)
		description = properties.driverDescription
		printf(c"description: %s\n", description |> Cstring)
		adapterType = properties.adapterType
		printf(c"adapterType: %d\n", adapterType |> Int)
		backendType = properties.backendType
		printf(c"backendType : %d\n", backendType |> Int)
		GC.@preserve adapterRef begin
			@ptrcall releaseAdapter(adapter::Ptr{WGPUAdapterImpl})::Nothing
		end
		Libc.free(propertiesPtr)
	end
	free(adapters)
	@ptrcall releaseInstance(instance::Ptr{WGPUInstanceImpl})::Int64
	StaticTools.dlclose(lib)
	return 0
end

using StaticCompiler, StaticTools

compile_executable(mainF, (Int64, Ptr{Ptr{UInt8}}), "./")

