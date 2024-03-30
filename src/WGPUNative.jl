module WGPUNative

function toCString(s::String)
	sNullTerminated = s*"\0"
	sPtr = GC.@preserve sNullTerminated pointer(sNullTerminated)
	dPtr = Libc.malloc(sizeof(sNullTerminated))
	dUInt8Ptr = convert(Ptr{UInt8}, dPtr)
	unsafe_copyto!(dUInt8Ptr, sPtr, sizeof(sNullTerminated))
end

function fromCString(s::Ptr{Int8})
    s != C_NULL ? unsafe_string(s) : ""
end

using Reexport
include("LibWGPU.jl")
@reexport using .LibWGPU

end
