using Debugger
using Downloads

using Tar, Inflate, SHA

arch = lowercase(String(Sys.ARCH))
kernel = lowercase(String(Sys.KERNEL))

if kernel == "nt"
	kernel == "windows"
end
	
# modifying conventions for wgpu specifically based on
# releases at https://github.com/gfx-rs/wgpu-native/releases/tag/v22.1.0.5

version = "v0.1.8"
kernels = ["macos", "linux", "windows", "ios", "android"]
archs = ["aarch64", "i686", "x86_64"]

upstreamVersion = "v24.0.0.1"

io = IOBuffer()

function writeIO(io, arch, kernel, sha1, sha256, filename, url)
	write(
		io,
		"""
		[[WGPUNative]]
		arch = "$arch"
		git-tree-sha1 = "$sha1"
		os = "$kernel"

			[[WGPUNative.download]]
			sha256 = "$sha256"
			url = "$url"
		
		"""
	)
end

remoteurl = "https://github.com/JuliaWGPU/WGPUNative.jl/releases/download/$(version)"

function generateArtifacts()
	buildType = ""
	for kernel in kernels
		for arch in archs
			if kernel == "windows"
				buildType = "-msvc" # Choosing only msvc for now
			else
				buildType = ""
			end
			releasefile = "wgpu-$kernel-$arch$buildType-release.zip"
			tarfile = "WGPU.$(upstreamVersion).$(arch)-$(kernel).tar.gz"
			try
				url = "https://github.com/gfx-rs/wgpu-native/releases/download/$(upstreamVersion)/$releasefile"
				Downloads.download(url, releasefile)
				rm("wgpulibs$arch$kernel", force=true, recursive=true)
				mkdir("wgpulibs$arch$kernel")
				run(`unzip $releasefile -d wgpulibs$arch$kernel`)
				run(`tar -C wgpulibs$arch$kernel -czvf $tarfile .`)
				rm("wgpulibs$arch$kernel", recursive=true)
				rm("$releasefile")
			catch(e)
				println("$e")
			end
		end
	end
end

function writeArtifactsTOML()
	buildType = ""
	for kernel in kernels
		for arch in archs
			if kernel == "windows"
				buildType = "-msvc" # Choosing only msvc for now
			end
			releasefile = "wgpu-$kernel-$arch$buildType-release.zip"
			tarfile = "WGPU.$(upstreamVersion).$(arch)-$(kernel).tar.gz"
			try
				# Downloads.download(joinpath(remoteurl, tarfile), tarfile)
				sha256Val = bytes2hex(open(sha256, tarfile))
				sha1Val = Tar.tree_hash(IOBuffer(inflate_gzip(tarfile)))
				writeIO(io, arch, kernel, sha1Val, sha256Val, "", joinpath(remoteurl, tarfile))
			catch(e)
				println("$e")
			end
		end
	end
	seek(io, 0)
	f = open("Artifacts.toml", "w")
	write(f, io)
	close(f)
	mv("Artifacts.toml", "../Artifacts.toml")
end


generateArtifacts()

# TODO 
# publish artifacts as a release through github through github API
# for now we could simply add input for confirmation of upload.

# writeArtifactsTOML()
