
set(SOURCE_FILES)

add_library(${PROJECT_NAME} ${SOURCE_FILES})

set(ADDITIONAL_LIBRARIES)

target_link_libraries(${PROJECT_NAME} ${ADDITIONAL_LIBRARIES})

set(HEADER_FILES)

INSTALL(FILES ${HEADER_FILES} DESTINATION ${CMAKE_INSTALL_PREFIX}/include/${PROJECT_NAME})

