#!/bin/bash
set -euf -o pipefail
echo "#### ros2.repos"
cat ros2.repos
echo "####"
vcs import src < ros2.repos