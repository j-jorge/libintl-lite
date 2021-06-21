#!/usr/bin/env bash

CMAKE=""

build_libintl() {
    echo ">>> Building libintl for $1"
    "$CMAKE" -B build \
        -DCMAKE_TOOLCHAIN_FILE="$ANDROID_NDK_ROOT"/build/cmake/android.toolchain.cmake \
        -DANDROID_ABI="$1" \
        -DANDROID_PLATFORM="$ANDROID_PLATFORM" \
        -DANDROID_STL=c++_shared \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_INSTALL_PREFIX=out/libintl-lite/"$1" \
        .
    "$CMAKE" --build build
    "$CMAKE" --build build --target install
    rm -rf ./build
}

if [ -z "${ANDROID_SDK_ROOT}" ]; then
    echo "ANDROID_SDK_ROOT should be set to Android SDK path."
    exit 1
fi

if [ -z "${ANDROID_NDK_ROOT}" ]; then
    echo "ANDROID_NDK_ROOT should be set to Android NDK path."
    exit 1
fi

if [ -z "${ANDROID_SDK_CMAKE_VERSION}" ]; then
    echo "ANDROID_SDK_CMAKE_VERSION should be set to desired cmake version in \$ANDROID_SDK_ROOT/cmake. eg. 3.18.1"
    exit 1
fi

if [ -z "${ANDROID_PLATFORM}" ]; then
    echo "ANDROID_PLATFORM should be set to minimum API level supported by the library. eg. 21"
    exit 1
fi

if [ -z "${ANDROID_ABI}" ]; then
    echo "ANDROID_ABI not set; can be a ',' separated list. eg. armeabi-v7a,arm64-v8a"
    exit 1
fi

CMAKE="$ANDROID_SDK_ROOT/cmake/$ANDROID_SDK_CMAKE_VERSION/bin/cmake"

if [ ! -f "$CMAKE" ]; then
    echo "Cannot find cmake: '$CMAKE'"
    exit 1
fi

IFS=',' read -ra ARCH <<< "${ANDROID_ABI}"

for a in "${ARCH[@]}"; do
  build_libintl "$a"
done
