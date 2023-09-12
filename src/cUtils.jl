
module CUtils

export CStruct, cStruct, ptr, concrete, rawCast, cast, toCString, fromCString

mutable struct CStruct{T}
	ptr::Ptr{T}
	function CStruct(cStructType::DataType)
		csPtr = Libc.calloc(sizeof(cStructType), sizeof(UInt8))
		# f(x) = begin
 		# 	@info "Destroying CStruct `$x`"
 		# 	ptr = getfield(x, :ptr)
 		# 	Libc.free(ptr)
 		# 	setfield!(x, :ptr, typeof(ptr)(0))
		# end
		obj = new{cStructType}(csPtr)
		# finalizer(f, obj)
		return obj
	end
    function CStruct(cptr::Ptr{T}) where T
    #     f(x) = begin
    #         @info "Destroying CStruct `$x`"
    #         ptr = getfield(x, :ptr)
    #         Libc.free(ptr)
    #         setfield!(x, :ptr, typeof(ptr)(0))
    #    end
        obj = new{T}(csPtr)
       # finalizer(f, obj)
        return obj
    end
end

function cStructFree(cstruct::CStruct{T}) where T
	ptr = getfield(cstruct, :ptr)
	Libc.free(ptr)
end


function indirectionToField(cstruct::CStruct{T}, x::Symbol) where T
	fieldIdx::Int64 = Base.fieldindex(T, x)
	fieldOffset = Base.fieldoffset(T, fieldIdx)
	fieldType = Base.fieldtype(T, fieldIdx)
	fieldSize = fieldType |> sizeof
	offsetptr = getfield(cstruct, :ptr) + fieldOffset
	field = convert(Ptr{fieldType}, offsetptr)
end

function Base.getproperty(cstruct::CStruct{T}, x::Symbol) where T
	unsafe_load(indirectionToField(cstruct, x), 1)
end

function Base.setproperty!(cstruct::CStruct{T}, x::Symbol, v) where T
	field = indirectionToField(cstruct, x)
	unsafe_store!(field, v)
end


function rawCast(DType::DataType, cs::CStruct{T}) where {T} 
    convert(Ptr{DType}, getfield(cs, :ptr))
end

function cast(DType::DataType, cs::CStruct{T}) where {T}
    CStruct(rawCast(DType, cs))
end

ptr(cs::CStruct{T}) where T = getfield(cs, :ptr)

# TODO this is not working right now
# left it because its not priority.
# Can always use getfield
# function Base.getproperty(cstruct::CStruct{T}, x::Val{:ptr}) where T
# 	getfield(cstruct, :ptr)
# end


function cStruct(ctype::DataType; fields...)
	cs = CStruct(ctype)
	inPairs = pairs(fields)
	for field in keys(inPairs)
		if field in fieldnames(ctype)
			setproperty!(cs, field, inPairs[field])
		else 
			@warn """ CStruct : Setting property of non member field. \n
			Trying to set non member field `$field`.
			only supported fieldnames for `$ctype` are $(fieldnames(ctype))
			"""
		end
	end
	return cs
end

function cStructPtr(ctype::DataType; fields...)
	return ptr(cStruct(ctype; fields...))
end

function concrete(cstruct::CStruct{T}) where T
	return cstruct |> ptr |> unsafe_load
end


function toCString(s::String)
	sNullTerminated = s*"\0"
	sPtr = pointer(sNullTerminated)
	dPtr = Libc.malloc(sizeof(sNullTerminated))
	dUInt8Ptr = convert(Ptr{UInt8}, dPtr)
	unsafe_copyto!(dUInt8Ptr, sPtr, sizeof(sNullTerminated))
end

function fromCString(s::Ptr{Int8})
    s != C_NULL ? unsafe_string(s) : ""
end

end