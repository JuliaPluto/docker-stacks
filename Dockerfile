FROM julia:1.6.0

ENV USER pluto
ENV USER_HOME_DIR /home/${USER}
ENV JULIA_DEPOT_PATH ${USER_HOME_DIR}/.julia
ENV NOTEBOOK_DIR ${USER_HOME_DIR}/notebooks
ENV JULIA_NUM_THREADS 100

RUN useradd -m -d ${USER_HOME_DIR} ${USER} \
    && mkdir -p ${NOTEBOOK_DIR}

COPY . ${USER_HOME_DIR}/
WORKDIR ${USER_HOME_DIR}

RUN mkdir -p /home/pluto/.julia/environments/v1.6/ &&\
    cp *.toml /home/pluto/.julia/environments/v1.6/ &&\
    julia -e "import Pkg; Pkg.activate(); Pkg.instantiate(); Pkg.precompile();" &&\
    chown -R ${USER} ${USER_HOME_DIR}

USER ${USER}

EXPOSE 1234
VOLUME ${NOTEBOOK_DIR}
WORKDIR ${NOTEBOOK_DIR}

CMD [ "julia", "--project=/home/pluto", "-e", "import Pluto; Pluto.run(host=\"0.0.0.0\", port=1234, launch_browser=false, require_secret_for_open_links=false, require_secret_for_access=false)"]
