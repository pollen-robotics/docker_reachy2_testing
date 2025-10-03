FROM pollenrobotics/reachy2_core:1.7.5.8_deploy

COPY package /package

#RUN mkdir -p -m 0700 /home/reachy/.ssh && ssh-keyscan github.com >> $HOME/.ssh/known_hosts
#ENV GIT_SSH_COMMAND='ssh -Tvv'
#USER reachy

RUN mkdir -p /home/reachy/.ssh && ssh-keyscan github.com >> /home/reachy/.ssh/known_hosts
# RUN --mount=type=ssh,id=default,uid=1000 git clone git@github.com:pollen-robotics/docker_reachy2_core.git

RUN sudo apt-get -y update
RUN sudo apt --fix-broken -y install
RUN sudo apt-get install -y libxcb-cursor0
RUN sudo apt-get install -y mercurial
RUN sudo apt-get install -y linux-source
RUN sudo apt-get install -y linux-headers-$(uname -r)

WORKDIR $HOME/dev/poulpe_ethercat_controller
RUN --mount=type=ssh,id=default,uid=1000 git fetch
RUN --mount=type=ssh,id=default,uid=1000 git checkout develop

#RUN --mount=type=ssh git fetch
#RUN --mount=type=ssh git checkout -b develop

WORKDIR $HOME/dev
RUN git clone -b orbita_bench https://github.com/pollen-robotics/reachy2-testing.git
RUN mv poulpe_ethercat_controller poulpe_ethercat_controller.bak
#RUN git clone -b develop https://github.com/pollen-robotics/poulpe_ethercat_controller.git
RUN git clone https://github.com/pollen-robotics/firmware_Poulpe.git
RUN git clone https://github.com/pollen-robotics/bootloader_Poulpe.git
RUN git clone https://github.com/pollen-robotics/orbita3d_control.git
RUN git clone https://github.com/pollen-robotics/orbita2d_control.git
RUN git clone https://github.com/pollen-robotics/orbita3d_testbench.git
RUN git clone https://github.com/pollen-robotics/orbita2d_testbench.git



# ethercat
RUN hg clone http://hg.code.sf.net/p/etherlabmaster/code ethercat
WORKDIR $HOME/dev/ethercat
RUN hg update stable-1.5
RUN ./bootstrap
RUN ./configure --disable-8139too
RUN sudo ln -s /home/reachy /home/prod

# Install uv
RUN curl -LsSf https://astral.sh/uv/install.sh | sh

# Rust stuffs
#RUN rustup update
#RUN cargo install cargo-binstall --locked
#RUN cargo binstall --force rerun-cli@0.20.3
#RUN cargo install rerun-cli --locked

WORKDIR $HOME/dev
