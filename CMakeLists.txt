cmake_minimum_required(VERSION 3.5)
project(LibIntl VERSION 1.0)

include(GNUInstallDirs)

add_library(intl STATIC internal/libintl.cpp)
target_include_directories(intl PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
    $<INSTALL_INTERFACE:include>
)
set_target_properties(intl PROPERTIES PUBLIC_HEADER ${CMAKE_CURRENT_SOURCE_DIR}/libintl.h)
target_compile_features(intl PRIVATE cxx_std_11)

install(TARGETS intl
        EXPORT LibIntlTargets
        ARCHIVE DESTINATION lib
        PUBLIC_HEADER DESTINATION include
)

include(CMakePackageConfigHelpers)

write_basic_package_version_file(
    LibIntlConfigVersion.cmake
    VERSION ${PACKAGE_VERSION}
    COMPATIBILITY AnyNewerVersion
)

install(EXPORT LibIntlTargets
        FILE LibIntlTargets.cmake
        DESTINATION "lib/cmake"
)

configure_package_config_file(
    LibIntlConfig.cmake.in
    "${CMAKE_CURRENT_BINARY_DIR}/LibIntlConfig.cmake"
    INSTALL_DESTINATION "lib/cmake"
)

install(FILES "${CMAKE_CURRENT_BINARY_DIR}/LibIntlConfig.cmake"
              "${CMAKE_CURRENT_BINARY_DIR}/LibIntlConfigVersion.cmake"
        DESTINATION "lib/cmake"
)
