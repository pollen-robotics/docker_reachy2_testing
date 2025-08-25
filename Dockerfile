FROM pollenrobotics/reachy2_core:1.7.5.8_deploy

WORKDIR $HOME/dev
RUN git clone --branch 1-add-mobile-base-testing https://github.com/pollen-robotics/reachy2-testing.git

# Install uv
RUN curl -LsSf https://astral.sh/uv/install.sh | sh