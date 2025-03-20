#!/bin/bash
set -e

# パッケージ名と起動するlaunchファイルを指定する
# Specify the package name and launch file to start.

PACKAGE_NAME="sample_package"
LAUNCH_FILE="sample_launch.py"
# PACKAGE_NAME="package_name"
# LAUNCH_FILE="launch_file.launch.py"


# ROS2 humble 環境をセットアップする
# Setup ROS2 environment
source /opt/ros/humble/setup.bash
source /ros2_ws/install/setup.bash

# ros2のlaunchファイルを指定して起動する。
# Launch the specified ROS2 launch file.
echo "Starting ROS2 launch file: ${LAUNCH_FILE}..."
#ros2 launch "${PACKAGE_NAME}" "${LAUNCH_FILE}"

wait