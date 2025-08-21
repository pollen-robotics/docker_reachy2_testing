FROM pollenrobotics/ros_pollen_base:humble_v1.1

#  --no-install-recommends to avoid extra pacakges
RUN sudo apt-get update && sudo apt-get install -y --no-install-recommends ssh

# init environment
ENV DOCKER_IMAGE_NAME=template ROS_VERSION=humble
RUN mkdir $HOME/reachy_ws && mkdir $HOME/reachy_ws/src && mkdir $HOME/dev
COPY src/ $HOME/reachy_ws/src
COPY dev/ $HOME/dev
COPY .reachy.bash .reachy.yaml $HOME/


# Don't forget to remove what is not necessary, or confidential from the Docker image
RUN pip cache purge && sudo apt-get clean