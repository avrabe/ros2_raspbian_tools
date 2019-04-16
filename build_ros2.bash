#!/bin/bash
set -euf -o pipefail

PYTHON_MAJOR=3
PYTHON_MINOR=5

echo "do not build visualization studd"
touch src/ros-visualization/COLCON_IGNORE
touch src/ros2/rviz/COLCON_IGNORE
touch src/ros2/demos/COLCON_IGNORE

echo start colcon
colcon build --symlink-install \
    --cmake-args \
    --no-warn-unused-cli \
    -DBUILD_TESTING=OFF \
    -DCMAKE_FIND_ROOT_PATH="/ros2_ws/install_isolated" \
    -DCMAKE_TOOLCHAIN_FILE="/polly/raspberrypi1-cxx14-pic.cmake" \
    -DPYTHON_INCLUDE_DIR="${RASPBERRYPI_CROSS_COMPILE_SYSROOT}/usr/include/python${PYTHON_MAJOR}.${PYTHON_MINOR}m" \
    -DPYTHON_LIBRARY="${RASPBERRYPI_CROSS_COMPILE_SYSROOT}/usr/lib/${RASPBERRYPI_CROSS_COMPILE_TOOLCHAIN_PREFIX}/libpython${PYTHON_MAJOR}.${PYTHON_MINOR}m.so" \
    -DPYTHON_SOABI="cpython-${PYTHON_MAJOR}${PYTHON_MINOR}m-${RASPBERRYPI_CROSS_COMPILE_TOOLCHAIN_PREFIX}" \
    -DEIGEN3_INCLUDE_DIR="${RASPBERRYPI_CROSS_COMPILE_SYSROOT}/usr/include/eigen3" \
    -DOpenCV_DIR="${RASPBERRYPI_CROSS_COMPILE_SYSROOT}/usr/share/OpenCV" \
    -DEigen3_DIR="${RASPBERRYPI_CROSS_COMPILE_SYSROOT}/usr/lib/cmake/eigen3" \
    -DPoco_INCLUDE_DIR="${RASPBERRYPI_CROSS_COMPILE_SYSROOT}/usr/include" \
    -DPoco_LIBRARY_DIR="${RASPBERRYPI_CROSS_COMPILE_SYSROOT}/usr/lib" \
    -DASIO_INCLUDE_DIR="${RASPBERRYPI_CROSS_COMPILE_SYSROOT}/usr/include" \
    -DTINYXML2_INCLUDE_DIR="${RASPBERRYPI_CROSS_COMPILE_SYSROOT}/usr/include" \
    -DTINYXML2_LIBRARY="${RASPBERRYPI_CROSS_COMPILE_SYSROOT}/usr/lib/${RASPBERRYPI_CROSS_COMPILE_TOOLCHAIN_PREFIX}/libtinyxml2.so" \
    -DTinyXML_INCLUDE_DIR="${RASPBERRYPI_CROSS_COMPILE_SYSROOT}/usr/include" \
    -DTinyXML_LIBRARY="${RASPBERRYPI_CROSS_COMPILE_SYSROOT}/usr/lib/${RASPBERRYPI_CROSS_COMPILE_TOOLCHAIN_PREFIX}/libtinyxml.so" \
    -DCURL_INCLUDE_DIR="${RASPBERRYPI_CROSS_COMPILE_SYSROOT}/usr/include/${RASPBERRYPI_CROSS_COMPILE_TOOLCHAIN_PREFIX}" \
    -DCURL_LIBRARY="${RASPBERRYPI_CROSS_COMPILE_SYSROOT}/usr/lib/${RASPBERRYPI_CROSS_COMPILE_TOOLCHAIN_PREFIX}/libcurl.so" \
    -DPoco_LIBRARY_DIR="${RASPBERRYPI_CROSS_COMPILE_SYSROOT}/usr/lib" \
    -DPoco_INCLUDE_DIR="${RASPBERRYPI_CROSS_COMPILE_SYSROOT}/usr/include" \
    -DPoco_LIBRARIES="dl;PocoFoundation" \
    -DLog4cxx_LIBRARY="${RASPBERRYPI_CROSS_COMPILE_SYSROOT}/usr/lib/${RASPBERRYPI_CROSS_COMPILE_TOOLCHAIN_PREFIX}/liblog4cxx.so" \
    -DLog4cxx_INCLUDE_DIR="${RASPBERRYPI_CROSS_COMPILE_SYSROOT}/usr/include" \
    -DLog4cxx_LIBRARY_DIR="${RASPBERRYPI_CROSS_COMPILE_SYSROOT}/usr/lib" \
    -Dlibyaml_LIBRARY="${RASPBERRYPI_CROSS_COMPILE_SYSROOT}/usr/lib/${RASPBERRYPI_CROSS_COMPILE_TOOLCHAIN_PREFIX}/libyaml.so" \
    -Dlibyaml_INCLUDE_DIR="${RASPBERRYPI_CROSS_COMPILE_SYSROOT}/usr/include" \
    -Dlibyaml_LIBRARY_DIR="${RASPBERRYPI_CROSS_COMPILE_SYSROOT}/usr/lib/${RASPBERRYPI_CROSS_COMPILE_TOOLCHAIN_PREFIX}/" \
    -DQt5_DIR=${RASPBERRYPI_CROSS_COMPILE_SYSROOT}/usr/lib/${RASPBERRYPI_CROSS_COMPILE_TOOLCHAIN_PREFIX}/cmake/Qt5/ \
    $*
