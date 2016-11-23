
if (NOT DEFINED PROJECT_NAME)
	message(FATAL_ERROR "Must define a project name before using create_package")
endif()

if (NOT DEFINED PROJECT_VERSION)
	message(FATAL_ERROR "Must define a project version before using create_package")
endif()

set(THIS_FILE_DIR ${CMAKE_CURRENT_LIST_DIR})
set(THIS_OUTPUT_DIR "${PROJECT_BINARY_DIR}/gen")

macro(create_package _description)

  set(PKGCONF_NAME ${PROJECT_NAME})
	set(PKGCONF_DESCRIPTION ${_description})
    set(PKGCONF_VERSION ${PROJECT_VERSION})

	message(STATUS "Creating package config file ${PROJECT_NAME}.pc")

	configure_file("${THIS_FILE_DIR}/pkg-config.pc.in" "${THIS_OUTPUT_DIR}/${PROJECT_NAME}.pc" @ONLY)

	install(FILES "${THIS_OUTPUT_DIR}/${PROJECT_NAME}.pc" DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig")

endmacro()

macro(create_package_named _name _version _description)

  set(PKGCONF_NAME ${_name})
  set(PKGCONF_DESCRIPTION ${_description})
  set(PKGCONF_VERSION ${_version})

  message(STATUS "Creating package config file ${_name}.pc")

  configure_file("${THIS_FILE_DIR}/pkg-config.pc.in" "${THIS_OUTPUT_DIR}/${_name}.pc" @ONLY)

  install(FILES "${THIS_OUTPUT_DIR}/${_name}.pc" DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig")

endmacro()
