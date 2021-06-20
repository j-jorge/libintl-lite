libintl lite
============

libintl-lite is a simple (but less powerful) GNU gettext libintl replacement originally written by felixhaedicke and released on SourceForge.net: http://sourceforge.net/projects/libintl-lite/

The library does not depends upon any library except the standard C++ library and the STL, thus making it well suited for platforms like Android.

Build with Android NDK and cmake
===============

Build script is configured via environment variables, but you can always override them in command line:

```bash
ANDROID_SDK_ROOT="/path/to/android/sdk" \
ANDROID_NDK_ROOT="/path/to/android/ndk" \
ANDROID_SDK_CMAKE_VERSION="3.18.1" \
ANDROID_PLATFORM="21" \
ANDROID_ABI="armeabi-v7a,arm64-v8a" \
./build-android-cmake.sh
```

Where `ANDROID_SDK_ROOT` is path to Android SDK, it should contain proper version of cmake. `ANDROID_NDK_ROOT` is path to Android NDK, can be `$ANDROID_SDK_ROOT/ndk/<version>`. `ANDROID_ABI` is comma separated list, eg `armeabi-v7a,arm64-v8a,x86,x86_64`.

Build artifacts are stored in `out/libintl-lite/<arch>`. You can use them via `find_package(LibIntl)` as normal cmake packages.

Where to get help?
===============

Issues should be reported on the project's page on GitHub: https://github.com/j-jorge/libintl-lite

For general questions, send an email to julien.jorge@stuff-o-matic.com.

Legal information
==============

The software is licensed under the version 1 of the Boost Software License.

See the accompanying LICENSE file for details.
