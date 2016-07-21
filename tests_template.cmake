
set(SOURCE_FILES)

add_executable(${PROJECT_NAME}_test ${SOURCE_FILES})

include_directories(SYSTEM vendor/bandit ${PROJECT_SOURCE_DIR}/src)

target_link_libraries (${PROJECT_NAME}_test ${PROJECT_NAME})

