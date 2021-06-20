#!/usr/bin/env bash

build_libintl() {
    echo ">>> Building fmt for $1"
    "$ANDROID_SDK_ROOT"/cmake/3.18.1/bin/cmake -B build \
        -DCMAKE_TOOLCHAIN_FILE="$ANDROID_NDK_ROOT"/build/cmake/android.toolchain.cmake \
        -DANDROID_ABI="$1" \
        -DANDROID_NATIVE_API_LEVEL=21 \
        -DCMAKE_INSTALL_PREFIX=out/libintl-lite/"$1" \
        .
    "$ANDROID_SDK_ROOT"/cmake/3.18.1/bin/cmake --build build
    "$ANDROID_SDK_ROOT"/cmake/3.18.1/bin/cmake --build build --target install
}

if [ -z "${ANDROID_SDK_ROOT}" ]; then
    echo "ANDROID_SDK_ROOT not set."
    exit 1
fi

if [ -z "${ANDROID_NDK_ROOT}" ]; then
    echo "ANDROID_NDK_ROOT not set."
    exit 1
fi

if [ -z "${BUILD_ARCH}" ]; then
    echo "BUILD_ARCH not set; can be a ',' separated list."
    exit 1
fi

IFS=',' read -ra ARCH <<< "${BUILD_ARCH}"

for a in "${ARCH[@]}"; do
  build_libintl "$a"
done
