FROM ubuntu:xenial
RUN apt update && apt-get install -y --no-install-recommends curl ca-certificates && \
    rm -rf /var/lib/apt/lists/* && \
    echo "deb http://packages.ros.org/ros2/ubuntu xenial main" > /etc/apt/sources.list.d/ros2-latest.list && \
    curl http://repo.ros2.org/repos.key | apt-key add -
RUN apt update && apt-get install -y --no-install-recommends \
    apt-transport-https \
    cmake \
    git \
    gnupg2 \
    make \
    patch \
    python3-empy \
    python3-pkg-resources \
    python3-setuptools \
    python3-pyparsing \
    python3-pip \
    qemu-user-static \
    software-properties-common \
    apt-utils \
    wget \
    build-essential gawk git texinfo bison \
    cppcheck && apt-get install -y \
    python3-colcon-common-extensions \
    python-rosdep \
    python3-vcstool && \
    python3 -m pip install -U setuptools && \
    rm -rf /var/lib/apt/lists/*
ENV PATH "/opt/cross-pi-gcc-8.3.0-0/bin:${PATH}"
ENV LD_LIBRARY_PATH "/opt/cross-pi-gcc-8.3.0-0/lib:${LD_LIBRARY_PATH}"
RUN wget "https://sourceforge.net/projects/raspberry-pi-cross-compilers/files/Raspberry%20Pi%20GCC%20Cross-Compilers/GCC%208.3.0/Raspberry%20Pi%201%2C%20Zero/cross-gcc-8.3.0-pi_0-1.tar.gz/download" -O ~/cross-gcc-8.3.0-pi_0-1.tar.gz &&\
    tar xzf  ~/cross-gcc-8.3.0-pi_0-1.tar.gz -C /opt && \
    rm  ~/cross-gcc-8.3.0-pi_0-1.tar.gz
ENV RASPBERRYPI_CROSS_COMPILE_TOOLCHAIN_PATH /opt/cross-pi-gcc-8.3.0-0/bin/
ENV RASPBERRYPI_CROSS_COMPILE_TOOLCHAIN_PREFIX arm-linux-gnueabihf
ENV RASPBERRYPI_CROSS_COMPILE_SYSROOT /raspbian_ros2_root/
ENV CC  /opt/cross-pi-gcc-8.3.0-0/bin/arm-linux-gnueabihf-gcc
ENV CXX /opt/cross-pi-gcc-8.3.0-0/bin/arm-linux-gnueabihf-g++
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

VOLUME ["/polly"]
VOLUME ["/ros2_ws"]
VOLUME ["/raspbian_ros2_root"]

WORKDIR /ros2_ws