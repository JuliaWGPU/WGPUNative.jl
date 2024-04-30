## This is set of instructions to follow to update to upstream versions

- Change upstream version variable `upstreamVersion` in `gen/generators.jl` and `gen/artifacts.jl`
- Change tag version in `gen/artifacts.jl` to new tag.
- Run both scripts 1. gen/generator.jl 2. gen/artifacts.jl
	- These should overwrite src/LibWGPU.jl file with new ffi interface changes and also overwrite Artifacts.toml
	file
- finally add version tag to git commit and change tag version in Project.toml
- PR with these changes should pass with additional requirements which julia registrator enforces like `compat` entries etc...


