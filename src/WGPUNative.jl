module WGPUNative

export SIZE_MAX
const SIZE_MAX=256

using Reexport

include("LibWGPU.jl")
@reexport using .LibWGPU

end
