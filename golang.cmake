
function(external_go_project)
  set(options)
  set(singleValueOpts TARGET PACKAGE)
  set(multiValueOpts)

  cmake_parse_arguments(GO_EXTERNAL "${options}" "${singleValueOpts}" "${multiValueOpts}" ${ARGN})

  if (NOT GO_EXTERNAL_TARGET)
    message(FATAL_ERROR "No target specified for external_go_project")
  endif()

  if (NOT GO_EXTERNAL_PACKAGE)
    message(FATAL_ERROR "No Package specified for external_go_project")
  endif()

  add_custom_target(${GO_EXTERNAL_TARGET} env GOPATH=${GOPATH} ${CMAKE_Go_COMPILER} get ${GO_EXTERNAL_PACKAGE})
endfunction()

function(add_go_executable)
  set(options)
  set(singleValueOpts TARGET NAME)
  set(multiValueOpts SOURCE_FILES)

  cmake_parse_arguments(GO_EXECUTABLE "${options}" "${singleValueOpts}" "${multiValueOpts}" ${ARGN})

  if (NOT GO_EXECUTABLE_TARGET)
    message(FATAL_ERROR "No target provided to add_go_executable")
  endif()

  if (NOT GO_EXECUTABLE_NAME)
    set(GO_EXECUTABLE_NAME ${GO_EXECUTABLE_TARGET})
  endif()

  if (NOT GO_EXECUTABLE_SOURCE_FILES)
    file(GLOB GO_EXECUTABLE_SOURCE_FILES RELATIVE "${CMAKE_CURRENT_SOURCE_DIR}" "*.go")
  endif()

  add_custom_target(${GO_EXECUTABLE_TARGET}  COMMAND GOPATH=${GOPATH} ${CMAKE_Go_COMPILER} build
    -o "${CMAKE_CURRENT_BINARY_DIR}/${GO_EXECUTABLE_NAME}"
    ${CMAKE_GO_FLAGS} ${GO_EXECUTABLE_SOURCE_FILES}
    WORKING_DIRECTORY ${CMAKE_CURRENT_LIST_DIR})

  install(PROGRAMS ${CMAKE_CURRENT_BINARY_DIR}/${GO_EXECUTABLE_NAME} DESTINATION bin)

endfunction()

function(add_go_library)
  set(options STATIC SHARED)
  set(singleValueOpts TARGET NAME)
  set(multiValueOpts SOURCE_FILES)

  cmake_parse_arguments(GO_LIBRARY "${options}" "${singleValueOpts}" "${multiValueOpts}" ${ARGN})

  if (NOT GO_LIBRARY_TARGET)
    message(FATAL_ERROR "No target provided for go library")
  endif()

  if (NOT GO_LIBRARY_NAME)
    set(GO_LIBRARY_NAME ${GO_LIBRARY_TARGET})
  endif()

  if (GO_LIBRARY_SHARED)
    set(BUILD_MODE -buildmode=c-shared)
    if(APPLE)
      set(LIB_NAME "lib${GO_LIBRARY_NAME}.dylib")
    else()
      set(LIB_NAME "lib${GO_LIBRARY_NAME}.so")
    endif()
  else()
    set(BUILD_MODE -buildmode=c-archive)
    set(LIB_NAME "lib${GO_LIBRARY_NAME}.a")
  endif()

  if (NOT DEFINED GO_LIBRARY_SOURCE_FILES)
    file(GLOB GO_LIBRARY_SOURCE_FILES RELATIVE "${CMAKE_CURRENT_SOURCE_DIR}" "*.go")
  endif()

  add_custom_target(${GO_LIBRARY_TARGET} COMMAND GOPATH=${GOPATH} ${CMAKE_Go_COMPILER} build ${BUILD_MODE}
    -o "${CMAKE_CURRENT_BINARY_DIR}/${LIB_NAME}"
    ${CMAKE_GO_FLAGS} ${GO_LIBRARY_SOURCE_FILES}
    WORKING_DIRECTORY ${CMAKE_CURRENT_LIST_DIR})

  if(DEFINED GO_LIBRARY_SHARED)
    install(PROGRAMS ${CMAKE_CURRENT_BINARY_DIR}/${LIB_NAME} DESTINATION bin)
  endif()
endfunction()