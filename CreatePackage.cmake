
function(create_package)
  set(options)
  set(singleValueOpts DESCRIPTION TARGET VERSION)
  set(multiValueOpts VALGRIND_ARGS EXECUTABLE_ARGS)

  cmake_parse_arguments(CREATE_PACKAGE "${options}" "${singleValueOpts}" "${multiValueOpts}" ${ARGN})

  if (NOT DEFINED CREATE_PACKAGE_TARGET)
    if (NOT DEFINED PROJECT_NAME)
      message(FATAL_ERROR "Must define a target name before using create_package")
    endif()
    set(CREATE_PACKAGE_TARGET ${PROJECT_NAME})
  endif()

  if (NOT DEFINED CREATE_PACKAGE_VERSION)
    if (NOT DEFINED PROJECT_VERSION)
      message(FATAL_ERROR "Must define a project version before using create_package")
    endif()
    set(CREATE_PACKAGE_VERSION ${PROJECT_VERSION})
  endif()

  if (NOT DEFINED CREATE_PACKAGE_DESCRIPTION)
    message(FATAL_ERROR "Must define a description for the package")
  endif()

  set(PKGCONF_NAME ${CREATE_PACKAGE_TARGET})
	set(PKGCONF_DESCRIPTION ${CREATE_PACKAGE_DESCRIPTION})
  set(PKGCONF_VERSION ${CREATE_PACKAGE_VERSION})

  set(CREATE_PACKAGE_OUTPUT_DIR "${PROJECT_BINARY_DIR}/gen")

	message(STATUS "Creating package config file ${CREATE_PACKAGE_TARGET}.pc")

	configure_file("${PROJECT_SOURCE_DIR}/cmake/pkg-config.pc.in" "${CREATE_PACKAGE_OUTPUT_DIR}/${CREATE_PACKAGE_TARGET}.pc" @ONLY)

	install(FILES "${CREATE_PACKAGE_OUTPUT_DIR}/${CREATE_PACKAGE_TARGET}.pc" DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig")

endfunction()
