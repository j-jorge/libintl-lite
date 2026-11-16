find_program(MSGFMT_EXECUTABLE msgfmt REQUIRED)

set(test_catalogs ar de ja noheader pl)
set(test_mo_files)
foreach(catalog ${test_catalogs})
    set(mo_file "${CMAKE_CURRENT_BINARY_DIR}/${catalog}.mo")
    add_custom_command(
        OUTPUT ${mo_file}
        COMMAND ${MSGFMT_EXECUTABLE} -o ${mo_file} ${CMAKE_CURRENT_SOURCE_DIR}/${catalog}.po
        DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/${catalog}.po
    )
    list(APPEND test_mo_files ${mo_file})
endforeach()
add_custom_target(test_catalogs ALL DEPENDS ${test_mo_files})

add_executable(plural_test plural_test.cpp)
target_link_libraries(plural_test PRIVATE intl)
target_compile_features(plural_test PRIVATE cxx_std_11)
add_dependencies(plural_test test_catalogs)

add_test(NAME plural_test COMMAND plural_test ${CMAKE_CURRENT_BINARY_DIR})
