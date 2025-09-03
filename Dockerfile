FROM pollenrobotics/reachy2_core:1.7.5.8_deploy

COPY package /package

RUN sudo apt-get -y update
RUN sudo apt --fix-broken -y install
RUN sudo apt-get install -y libxcb-cursor0

WORKDIR $HOME/dev
RUN git clone https://github.com/pollen-robotics/reachy2-testing.git

# Install uv
RUN curl -LsSf https://astral.sh/uv/install.sh | sh