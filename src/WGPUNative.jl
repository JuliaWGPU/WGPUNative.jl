module WGPUNative

using Reexport
include("LibWGPU.jl")
@reexport using .LibWGPU

end
