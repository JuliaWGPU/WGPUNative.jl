## Load WGPU
# You need to run requestAdapter example first

device = WGPUDevice()

function request_device_callback(
    a::WGPURequestDeviceStatus,
    b::WGPUDevice,
    c::Ptr{Cchar},
    d::Ptr{Nothing})
	global device = b
	return nothing
end

requestDeviceCallback = @cfunction(request_device_callback, Cvoid, (WGPURequestDeviceStatus, WGPUDevice, Ptr{Cchar}, Ptr{Cvoid}))

GC.@preserve adapter device requestDeviceCallback wgpuAdapterRequestDevice(
	adapter,
	C_NULL,
	requestDeviceCallback,
	device
)


