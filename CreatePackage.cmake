
if ("${PROJECT_NAME}" EQUAL "")
	message(FATAL_ERROR "Must define a project before using create_package")
endif()

if ("${PROJECT_VERSION}" EQUAL "")
	message(FATAL_ERROR "Must define a project version before using create_package")
endif()

set(THIS_FILE_DIR ${CMAKE_CURRENT_LIST_DIR})

function(create_package _description)

	set(PROJECT_DESCRIPTION _description)

	message(STATUS "Creating package config file ${PROJECT_NAME}.pc")

	configure_file("${THIS_FILE_DIR}/pkg-config.pc.in" "${CMAKE_CURRENT_BINARY_DIR}/${PROJET_NAME}.pc" @ONLY)

	install(FILES "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}.pc" DESTINATION "${CMAKE_INSTALL_LIBDIR}/pkgconfig")

endfunction()

