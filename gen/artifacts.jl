using Debugger
using Downloads

using Tar, Inflate, SHA

arch = lowercase(String(Sys.ARCH))
kernel = lowercase(String(Sys.KERNEL))

# modifying conventions for wgpu specifically based on
# releases at https://github.com/gfx-rs/wgpu-native/releases/tag/v0.12.0.1

version = "v.0.1.4"
kernels = ["macos", "linux", "windows"]
archs = ["aarch64", "i686", "x86_64"]

upstreamVersion = "v0.19.1.1"

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
	for kernel in kernels
		for arch in archs
			releasefile = "wgpu-$kernel-$arch-release.zip"
			tarfile = "WGPU.$(upstreamVersion).$(arch)-$(kernel).tar.gz"
			try
				url = "https://github.com/gfx-rs/wgpu-native/releases/download/$(upstreamVersion)/$releasefile"
				Downloads.download(url, releasefile)
				run(`rm -rf "wgpulibs$arch$kernel"`)
				run(`mkdir wgpulibs$arch$kernel`)
				run(`unzip $releasefile -d wgpulibs$arch$kernel`)
				run(`cd "wgpulibs$arch$kernel"`)
				run(`tar -C wgpulibs$arch$kernel -czvf $tarfile .`)
				run(`cd ".."`)
			catch(e)
				println("$e")
			end
		end
	end
end

function writeArtifactsTOML()
	for kernel in kernels
		for arch in archs
			releasefile = "wgpu-$kernel-$arch-release.zip"
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
end

generateArtifacts()

# TODO 
# publish artifacts as a release through github through github API
# for now we could simply add input for confirmation of upload.

writeArtifactsTOML()
