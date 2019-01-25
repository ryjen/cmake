cmake_minimum_required(VERSION 3.1)
set(CMAKE_CXX_STANDARD 14)

# add options for testing
option(ENABLE_COVERAGE "Enable code coverage testing." OFF)
option(ENABLE_MEMCHECK "Enable testing for memory leaks." OFF)
option(ENABLE_PROFILING "Enable valgrind profiling." OFF)

# define project name
project(@PROJECT_NAME@ VERSION @PROJECT_VERSION@)

# set path to custom modules
list(APPEND CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake)

include(ValgrindTest)

find_program(HEADERDOC headerdoc2html)
find_program(GATHERDOC gatherheaderdoc)
find_program(DOXYGEN doxygen)

# create the package config install
include(CreatePackage)
create_package(DESCRIPTION "@PROJECT_DESCRIPTION@")

# add target for code coverage
if (ENABLE_COVERAGE)
    include(CodeCoverage)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${CMAKE_CXX_FLAGS_COVERAGE}")
    setup_target_for_coverage(TARGET ${PROJECT_NAME}-coverage OUTPUT ${PROJECT_BINARY_DIR}/gen/coverage)
endif ()

set(TEST_PROJECT_NAME "${PROJECT_NAME}_test")

# add directories
add_subdirectory(src)
add_subdirectory(tests)

# Setup testing
enable_testing()

add_valgrind_profile_test(MEMCHECK ${ENABLE_MEMCHECK} PROFILING ${ENABLE_PROFILING} TARGET ${TEST_PROJECT_NAME})

if (DOXYGEN)
    add_custom_target(html WORKING_DIRECTORY ${PROJECT_SOURCE_DIR} COMMAND ${DOXYGEN} ${PROJECT_SOURCE_DIR}/Doxyfile)
elseif (HEADERDOC)
    add_custom_target(html COMMAND ${HEADERDOC} -o ${PROJECT_BINARY_DIR}/html ${CMAKE_SOURCE_DIR}/src/**.h
            COMMAND ${GATHERDOC} ${PROJECT_BINARY_DIR}/html)
endif ()
