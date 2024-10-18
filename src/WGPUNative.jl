module WGPUNative

using Artifacts
using Reexport

include("cUtils.jl")
include("LibWGPU.jl")
@reexport using .LibWGPU

function __init__()
    if Sys.iswindows()
        libpath = joinpath(artifact"WGPUNative", "lib", "wgpu_native.dll")
        chmod(libpath, filemode(libpath) | 0o755)
    end
end

end
