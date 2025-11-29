#!/bin/bash

set -ex

# Configure with CMake
cmake -S . -B build \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_CXX_STANDARD=20 \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DCMAKE_INSTALL_LIBDIR=lib \
    -DBUILD_TESTING=OFF \
    -DBUILD_CLI=ON \
    -DBUILD_BENCHMARKS=OFF

# Build
cmake --build build --parallel ${CPU_COUNT}

# Install
cmake --install build