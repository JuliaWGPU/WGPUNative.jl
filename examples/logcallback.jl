
function logCallBack(logLevel::WGPULogLevel, msg::WGPUStringView)
		if logLevel == WGPULogLevel_Error
				level_str = "ERROR"
		elseif logLevel == WGPULogLevel_Warn
				level_str = "WARN"
		elseif logLevel == WGPULogLevel_Info
				level_str = "INFO"
		elseif logLevel == WGPULogLevel_Debug
				level_str = "DEBUG"
		elseif logLevel == WGPULogLevel_Trace
				level_str = "TRACE"
		else
				level_str = "UNKNOWN LOG LEVEL"
		end
        println("$(level_str) $(unsafe_string(msg.data, msg.length))")
end

logcallback = @cfunction(logCallBack, Cvoid, (WGPULogLevel, WGPUStringView))

GC.@preserve logcallback wgpuSetLogCallback(logcallback, Ptr{Cvoid}())
wgpuSetLogLevel(WGPULogLevel_Debug)
