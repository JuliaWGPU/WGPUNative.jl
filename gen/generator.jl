using Clang.Generators

arch = lowercase(String(Sys.ARCH))
kernel = lowercase(String(Sys.KERNEL))

if kernel == "darwin"
	kernel = "macos"
elseif kernel == "nt"
	arch = "$(arch)-msvc"
	kernel = "windows"
end

releasefile = "wgpu-$kernel-$arch-release.zip"
location = "$releasefile"

upstreamVersion = "v24.0.0.1"

url = "https://github.com/gfx-rs/wgpu-native/releases/download/$(upstreamVersion)/wgpu-$kernel-$arch-release.zip"
download(url, location)
rm("wgpulib", recursive=true, force=true)
mkdir("wgpulib")
run(`unzip $location -d wgpulib`)
rm("$releasefile")
mv("$(joinpath("wgpulib", "include", "webgpu", "webgpu.h"))", "$(joinpath("wgpulib", "include", "webgpu.h"))")
mv("$(joinpath("wgpulib", "include", "webgpu", "wgpu.h"))", "$(joinpath("wgpulib", "include", "wgpu.h"))")

const C_HEADERS = [joinpath("include", "webgpu.h"), joinpath("include", "wgpu.h")]
const WGPU_HEADERS = [joinpath(@__DIR__, "wgpulib", h) for h in C_HEADERS]

options = load_options(joinpath(@__DIR__, "generator.toml"))

args = get_default_args()
push!(args, joinpath(@__DIR__, "..", "wgpulib", "include"))

ctx = create_context(WGPU_HEADERS, args, options)

build!(ctx)

rm("wgpulib", recursive=true, force=true)

