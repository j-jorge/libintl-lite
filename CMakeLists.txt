cmake_minimum_required(VERSION 3.0)

include(GNUInstallDirs)

add_library(intl STATIC internal/libintl.cpp)

install(FILES libintl.h DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})
install(TARGETS intl DESTINATION ${CMAKE_INSTALL_LIBDIR})