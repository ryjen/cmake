include_guard(GLOBAL)

# Keep the legacy report-generation targets available while moving compiler
# instrumentation off directory/global CMake flags.
include(CodeCoverage)

function(coda_enable_target_coverage)
  set(options)
  set(oneValueArgs TARGET)
  set(multiValueArgs)
  cmake_parse_arguments(CODA_COVERAGE "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})

  if(NOT CODA_COVERAGE_TARGET)
    message(FATAL_ERROR "coda_enable_target_coverage requires TARGET")
  endif()

  if(NOT TARGET ${CODA_COVERAGE_TARGET})
    message(FATAL_ERROR "Coverage target does not exist: ${CODA_COVERAGE_TARGET}")
  endif()

  if(NOT CMAKE_CXX_COMPILER_ID MATCHES "^(GNU|Clang|AppleClang)$")
    message(FATAL_ERROR
      "Target-local coverage currently supports GCC and Clang-family C++ compilers; got ${CMAKE_CXX_COMPILER_ID}")
  endif()

  get_target_property(CODA_COVERAGE_TARGET_TYPE ${CODA_COVERAGE_TARGET} TYPE)

  if(CODA_COVERAGE_TARGET_TYPE STREQUAL "INTERFACE_LIBRARY")
    message(FATAL_ERROR "Cannot instrument interface-only target ${CODA_COVERAGE_TARGET}")
  endif()

  target_compile_options(${CODA_COVERAGE_TARGET}
    PRIVATE
      -O0
      --coverage
  )

  # Static/object libraries need compile instrumentation but have no final link
  # step. The executable/shared target that consumes them receives --coverage
  # separately so the compiler runtime is linked intentionally.
  if(CODA_COVERAGE_TARGET_TYPE STREQUAL "EXECUTABLE" OR
     CODA_COVERAGE_TARGET_TYPE STREQUAL "SHARED_LIBRARY" OR
     CODA_COVERAGE_TARGET_TYPE STREQUAL "MODULE_LIBRARY")
    target_link_options(${CODA_COVERAGE_TARGET}
      PRIVATE
        --coverage
    )
  endif()
endfunction()
