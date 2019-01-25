
set(SOURCE_FILES)

add_executable(${TEST_PROJECT_NAME} ${SOURCE_FILES})

include_directories(SYSTEM vendor/bandit ${PROJECT_SOURCE_DIR}/src)

target_link_libraries(${TEST_PROJECT_NAME} ${PROJECT_NAME})

