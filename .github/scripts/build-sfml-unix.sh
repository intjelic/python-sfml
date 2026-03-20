#!/usr/bin/env bash

set -euo pipefail

version="${1:?SFML version is required}"
prefix="${2:?install prefix is required}"
install_deps="${3:-0}"

cmake_args=(
    -G Ninja
    -DBUILD_SHARED_LIBS=ON
    -DCMAKE_BUILD_TYPE=Release
    "-DCMAKE_INSTALL_PREFIX=${prefix}"
    -DCMAKE_INSTALL_LIBDIR=lib
    -DSFML_BUILD_DOC=OFF
    -DSFML_BUILD_EXAMPLES=OFF
    -DSFML_BUILD_TEST_SUITE=OFF
)

if [[ -f "${prefix}/include/SFML/Config.hpp" ]]; then
    exit 0
fi

if [[ "${install_deps}" == "1" ]]; then
    if command -v apt-get >/dev/null 2>&1; then
        export DEBIAN_FRONTEND=noninteractive
        apt-get update
        apt-get install -y \
            build-essential \
            cmake \
            git \
            libflac-dev \
            libfreetype6-dev \
            libgl1-mesa-dev \
            libudev-dev \
            libvorbis-dev \
            libx11-dev \
            libxcursor-dev \
            libxi-dev \
            libxrandr-dev \
            ninja-build \
            pkg-config
    elif command -v dnf >/dev/null 2>&1; then
        dnf install -y \
            cmake \
            freetype-devel \
            gcc-c++ \
            git \
            libX11-devel \
            libXcursor-devel \
            libXi-devel \
            libXrandr-devel \
            libudev-devel \
            mesa-libGL-devel \
            ninja-build \
            pkgconf-pkg-config \
            flac-devel \
            libvorbis-devel
    elif command -v yum >/dev/null 2>&1; then
        yum install -y \
            cmake \
            freetype-devel \
            gcc-c++ \
            git \
            libX11-devel \
            libXcursor-devel \
            libXi-devel \
            libXrandr-devel \
            libudev-devel \
            mesa-libGL-devel \
            ninja-build \
            pkgconfig \
            flac-devel \
            libvorbis-devel
    elif command -v brew >/dev/null 2>&1; then
        brew update
        brew install cmake ninja pkg-config
    fi
fi

src_dir="$(mktemp -d)"
build_dir="$(mktemp -d)"
trap 'rm -rf "${src_dir}" "${build_dir}"' EXIT

git clone --branch "${version}" --depth 1 https://github.com/SFML/SFML "${src_dir}"

cmake -S "${src_dir}" -B "${build_dir}" "${cmake_args[@]}"
cmake --build "${build_dir}"
cmake --install "${build_dir}"