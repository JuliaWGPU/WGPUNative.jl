using Clang.Generators

arch = lowercase(String(Sys.ARCH))
kernel = lowercase(String(Sys.KERNEL))

if kernel == "darwin"
	kernel = "macos"
elseif kernel == "windows"
	arch = "$(arch)-msvc"
end

releasefile = "wgpu-$kernel-$arch-release.zip"
location = "$releasefile"

upstreamVersion = "v22.1.0.5"

url = "https://github.com/gfx-rs/wgpu-native/releases/download/$(upstreamVersion)/wgpu-$kernel-$arch-release.zip"
download(url, location)
run(`rm -rf wgpulib`)
run(`mkdir wgpulib`)
run(`unzip $location -d wgpulib`)
run(`rm $releasefile`)
run(`mv $(joinpath("wgpulib", "include", "webgpu", "webgpu.h")) $(joinpath("wgpulib", "include"))`)
run(`mv $(joinpath("wgpulib", "include", "wgpu", "wgpu.h")) $(joinpath("wgpulib", "include"))`)

const C_HEADERS = [joinpath("include", "webgpu.h"), joinpath("include", "wgpu.h")]
const WGPU_HEADERS = [joinpath(@__DIR__, "wgpulib", h) for h in C_HEADERS]

options = load_options(joinpath(@__DIR__, "generator.toml"))

args = get_default_args()
push!(args, joinpath(@__DIR__, "..", "wgpulib", "include"))

ctx = create_context(WGPU_HEADERS, args, options)

build!(ctx)

run(`rm -rf wgpulib`)


