
if ("${CMAKE_PROJECT_NAME}" EQUAL "")
	message(FATAL_ERROR "Must define a project before using create_package")
endif()

if ("${PROJECT_VERSION}" EQUAL "")
	message(FATAL_ERROR "Must define a project version before using create_package")
endif()

set(THIS_FILE_DIR ${CMAKE_CURRENT_LIST_DIR})

function(create_package _description)

	set(PROJECT_DESCRIPTION _description)

	message(STATUS "Creating package config file ${CMAKE_PROJECT_NAME}.pc")

	configure_file("${THIS_FILE_DIR}/pkg-config.pc.in" "${CMAKE_SOURCE_DIR}/${CMAKE_PROJET_NAME}.pc" @ONLY)

	install(FILES "${CMAKE_SOURCE_DIR}/${CMAKE_PROJECT_NAME}.pc" DESTINATION "${CMAKE_INSTALL_LIBDIR}/pkgconfig")

endfunction()

