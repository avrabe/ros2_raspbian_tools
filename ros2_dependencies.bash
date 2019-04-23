#!/bin/bash
set -euf -o pipefail

apt-get update
apt-get -y --no-install-recommends install dirmngr

echo "deb http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" > /etc/apt/sources.list.d/ros2-latest.list
curl http://repo.ros2.org/repos.key | apt-key add -

apt-get update
apt-get -y install libopencv-dev libpoco-dev python-empy python3-dev python3-empy python3-nose python3-pip  \
                   python3-setuptools  python3-yaml libtinyxml-dev libeigen3-dev libcurl4-openssl-dev libpoco-dev \
                   libcurl4-openssl-dev libtinyxml2-dev libasio-dev liblog4cxx-dev libyaml-dev libasio-dev
