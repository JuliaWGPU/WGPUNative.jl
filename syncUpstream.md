## This is set of instructions to follow to update to upstream versions

- First change upstream version in Line 13 of gen/generators.jl and artifacts.jl
- Second run both scripts 1. gen/generator.jl 2. gen/artifacts.jl
- These should overwrite src/LibWGPU.jl file with new ffi interface changes and also overwrite Artifacts.toml
- file

