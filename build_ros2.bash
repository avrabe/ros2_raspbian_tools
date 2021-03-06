#!/bin/bash
set -euf -o pipefail

PYTHON_MAJOR=3
PYTHON_MINOR=5

echo "do not build visualization studd"
touch src/ros-visualization/COLCON_IGNORE
touch src/ros2/rviz/COLCON_IGNORE
touch src/ros2/demos/COLCON_IGNORE

echo "run rosdep check"
rosdep init
rosdep update
rosdep resolve $(rosdep keys --from-paths src --ignore-src --rosdistro crystal) || true

#echo "limits.h"
#echo "#include <limits.h>" > /tmp/foo.c
#/opt/cross-pi-gcc-8.3.0-0/bin/arm-linux-gnueabihf-g++ -M --sysroot /raspbian_ros2_root/ -mfpu=vfp -marm -mcpu=arm1176jzf-s -mfloat-abi=hard -mlittle-endian -munaligned-access /tmp/foo.c
#
#echo "###features.h - features"
#echo "#include <features.h>" | /opt/cross-pi-gcc-8.3.0-0/bin/arm-linux-gnueabihf-cpp -dN | grep "#define __USE_"
#
#echo "### features.h - all predefined macros"
#/opt/cross-pi-gcc-8.3.0-0/bin/arm-linux-gnueabihf-cpp -dM /dev/null
#
#echo "### features.h - all compiler defined macros"
#/opt/cross-pi-gcc-8.3.0-0/bin/arm-linux-gnueabihf-gcc -E -dM - < /dev/null

echo "### start colcon"
colcon build --merge-install \
    --cmake-force-configure \
    --cmake-args \
    --no-warn-unused-cli \
    -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON \
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
    $*

