cmake_minimum_required(VERSION 4.0)
project(LibIntl VERSION 1.1)

include(GNUInstallDirs)

set(BUILD_SHARED_LIBS TRUE CACHE BOOL "If enabled, shared libs will be built by default, otherwise static libs")

add_library(intl internal/libintl.cpp)
target_include_directories(intl PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
    $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
)
set_target_properties(intl PROPERTIES PUBLIC_HEADER ${CMAKE_CURRENT_SOURCE_DIR}/libintl.h)
target_compile_features(intl PRIVATE cxx_std_11)

if(WIN32 AND BUILD_SHARED_LIBS)
    set_target_properties(intl PROPERTIES WINDOWS_EXPORT_ALL_SYMBOLS ON)
endif()

install(TARGETS intl
        EXPORT LibIntlTargets
        RUNTIME DESTINATION "${CMAKE_INSTALL_BINDIR}"
        LIBRARY DESTINATION "${CMAKE_INSTALL_LIBDIR}"
        ARCHIVE DESTINATION "${CMAKE_INSTALL_LIBDIR}" COMPONENT Devel
        PUBLIC_HEADER DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
)

include(CMakePackageConfigHelpers)

write_basic_package_version_file(
    LibIntlConfigVersion.cmake
    VERSION ${PROJECT_VERSION}
    COMPATIBILITY AnyNewerVersion
)

install(EXPORT LibIntlTargets
        FILE LibIntlTargets.cmake
        NAMESPACE LibIntl::
        DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/LibIntl"
)

set(LIBINTL_INCLUDE_INSTALL_DIR "${CMAKE_INSTALL_INCLUDEDIR}")

configure_package_config_file(
    LibIntlConfig.cmake.in
    "${CMAKE_CURRENT_BINARY_DIR}/LibIntlConfig.cmake"
    INSTALL_DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/LibIntl"
    PATH_VARS LIBINTL_INCLUDE_INSTALL_DIR
)

install(FILES "${CMAKE_CURRENT_BINARY_DIR}/LibIntlConfig.cmake"
              "${CMAKE_CURRENT_BINARY_DIR}/LibIntlConfigVersion.cmake"
        DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/LibIntl"
)
