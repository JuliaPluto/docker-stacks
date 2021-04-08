FROM nvidia/cuda:11.0.3-cudnn8-runtime-ubuntu18.04
ARG USER_ID=1000
ARG JULIA_VER=1.6.0
ARG JULIA_URL=https://julialang-s3.julialang.org/bin/linux/x64/1.6
ARG USER_NAME=julia

EXPOSE 1234
USER root
WORKDIR /

RUN apt-get update && apt-get install -y \
	curl tar

RUN curl -LO ${JULIA_URL}/julia-${JULIA_VER}-linux-x86_64.tar.gz && \
	tar -xf julia-${JULIA_VER}-linux-x86_64.tar.gz && \
	rm -rf julia-${JULIA_VER}-linux-x86_64.tar.gz && \
	ln -s /julia-${JULIA_VER}/bin/julia /usr/local/bin/julia
RUN mkdir /.julia && chown ${USER_ID} /.julia

RUN useradd --no-log-init --system --uid ${USER_ID} \
	--create-home --shell /bin/bash ${USER_NAME}

USER ${USER_NAME}
WORKDIR /.local

RUN julia -e 'using Pkg; Pkg.add("Pluto")'

CMD ["julia", "-e", "import Pluto; Pluto.run()"]
