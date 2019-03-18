#!/bin/bash
set -euf -o pipefail

apt-get update
apt-get -y --no-install-recommends install dirmngr

echo "deb http://packages.ros.org/ros2/ubuntu `lsb_release -cs` main" > /etc/apt/sources.list.d/ros2-latest.list
curl http://repo.ros2.org/repos.key | apt-key add -

apt-get update
apt-get -y install git wget \
                   build-essential cppcheck cmake libopencv-dev libpoco-dev python-empy python3-dev python3-empy python3-nose python3-pip  \
                   python3-setuptools  python3-yaml libtinyxml-dev libeigen3-dev libcurl4-openssl-dev libpoco-dev \
                   libcurl4-openssl-dev libqt5core5a libqt5gui5 libqt5opengl5 libqt5widgets5 libxaw7-dev libgles2-mesa-dev libglu1-mesa-dev qtbase5-dev \
                   libtinyxml2-dev libasio-dev liblog4cxx-dev

# install some pip packages needed for testing
python3 -m pip install -U \
  argcomplete \
  flake8 \
  flake8-blind-except \
  flake8-builtins \
  flake8-class-newline \
  flake8-comprehensions \
  flake8-deprecated \
  flake8-docstrings \
  flake8-import-order \
  flake8-quotes \
  git+https://github.com/lark-parser/lark.git@0.7d \
  pytest-repeat \
  pytest-rerunfailures \
  pytest \
  pytest-cov \
  pytest-runner \
  setuptools
