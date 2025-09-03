#!/bin/bash
shopt -s expand_aliases
source /opt/ros/humble/setup.bash
source /home/reachy/reachy_ws/install/setup.bash
source /home/reachy/.utils.bash

echo "Sourcing Gazebo setup.bash..."

source /usr/share/gazebo/setup.bash

echo "Generating asoundrc..."

/package/generate_asoundrc.sh

echo "Setting permissions..."

sudo chown -R reachy /home/reachy/.ros/

echo "Launching mobile base GUI..."

cd /home/reachy/dev/reachy2-testing
/home/reachy/.local/bin/uv run mobile_base_testing/mobile_base_gui.py