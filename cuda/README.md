# CUDA Compatible Docker Image

## Requirements

Make sure you have nvidia docker extension up and running!
Without this `docker` command wont accept `--gpus` flag for `docker run` command.
For more info check out [official documentation](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html).

## Usage

Build container using `docker build -t pluto-notebook .`

Now we can run our image with `docker run -t -p 1234:1234 --gpus all pluto-notebook`.
This will start our container and attach it to host port 1234. `--gpus all` flag tells docker to give container access to all Nvidia GPUs attached to the host machine.

First lets install `CUDA.jl`

```julia
using Pkg; Pkg.add("CUDA")
```

Now lets make sure that CUDA support works:

```julia
using CUDA

# Running this for the first time will take some time
# since CUDA.jl needs to download an artifact
CUDA.version()

# More detailed CUDA info
CUDA.versioninfo()

# List all available CUDA compatible devices
CUDA.devices()
```

If there was no errors and we got correct version printed out we can now start using `CuArray`

```julia
using CUDA

W = cu(rand(2, 5))
b = cu(rand(2))

predict(x) = W*x .+ b
loss(x, y) = sum((predict(x) .- y).^2)

x, y = cu(rand(5)), cu(rand(2))
loss(x, y)
```

Useful links:

* [CUDA.jl introduction](https://juliagpu.gitlab.io/CUDA.jl/tutorials/introduction/#Introduction)
* [CUDA.jl usage tutorial](https://juliagpu.gitlab.io/CUDA.jl/usage/overview/#UsageOverview)
* [GPU Usage with Flux.jl](https://fluxml.ai/Flux.jl/stable/gpu/)
