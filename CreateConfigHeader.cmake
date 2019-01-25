
if (NOT DEFINED PROJECT_BINARY_DIR)
    message(FATAL_ERROR "You must define a project before configuring the header file.")
endif ()

set(THIS_LIST_DIR ${CMAKE_CURRENT_LIST_DIR})
set(THIS_OUTPUT_DIR "${PROJECT_BINARY_DIR}/gen")

macro(create_config_header)
    set(TEMPLATE_FILE "${ARGN}")
    if (NOT TEMPLATE_FILE)
        set(TEMPLATE_FILE "${THIS_LIST_DIR}/config.h.in")
    endif ()
    message(STATUS "Creating config.h for ${PROJECT_NAME}")
    configure_file(${TEMPLATE_FILE} ${PROJECT_BINARY_DIR}/gen/config.h)
    add_definitions(-DHAVE_CONFIG_H)
    include_directories(${THIS_OUTPUT_DIR})
endmacro()

