# docker-stacks
We provide 3 docker stacks for running pluto!

1. Pluto only in a simple standalone setting
2. Pluto within a very minimal JupyterLab (using the great http-proxy extension, binder compatible)
3. Pluto with CUDA support on

## To run pluto on docker:
```
docker pull ghcr.io/juliapluto/pluto@sha256:1235456d069482cc5a1a0151ef6ad1178bdbb53ae84e454adacdec8471b8de08:pluto

# Change 80 with the port you want to _access_ pluto on the machine docker runs!
docker run -p80:1234 ghcr.io/juliapluto/pluto

```


## For running pluto with cuda support please checkout [this README](cuda/README.md).

