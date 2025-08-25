FROM pollenrobotics/reachy2_core:1.7.5.8_deploy

RUN rm -rf /home/reachy/reachy_ws
RUN rm -rf /home/reachy/dev

RUN mkdir -p /home/reachy/reachy_ws/src
COPY src /home/reachy/reachy_ws/src

RUN mkdir -p /home/reachy/dev
COPY dev /home/reachy/dev

WORKDIR $HOME/dev/PyVESC
RUN pip install -e .

# Install uv
RUN curl -LsSf https://astral.sh/uv/install.sh | sh

# Build reachy_ws
WORKDIR $HOME/reachy_ws
RUN . /opt/ros/humble/setup.sh &&  \
    colcon build --symlink-install   --parallel-workers 4 --cmake-args -DCMAKE_BUILD_TYPE=Release --cargo-args --release