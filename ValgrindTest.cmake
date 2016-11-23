
find_program(VALGRIND_COMMAND valgrind)

if (VALGRIND_COMMAND)
	set(VALGRIND_COMMAND ON CACHE STRING "Memory checking support found.")
endif()

function(add_valgrind_test COND)
	set(options "")
	set(singleValueOpts TARGET_NAME EXECUTABLE)
	set(multiValueOpts VALGRIND_ARGS EXECUTABLE_ARGS)

	cmake_parse_arguments(add_valgrind_test "${options}" "${singleValueOpts}" "${multiValueOpts}" ${ARGN})

	if (NOT EXECUTABLE)
		set(EXECUTABLE "${PROJECT_BINARY_DIR}/tests/${TARGET_NAME}")
	endif()

	if (NOT ${COND} OR NOT VALGRIND_COMMAND)
		add_test(${TARGET_NAME} ${EXECUTABLE} ${EXECUTABLE_ARGS})
	else ()
		add_test(${TARGET_NAME} ${VALGRIND_COMMAND} --leak-check=full --error-exitcode=5 ${VALGRIND_ARGS} --quiet ${EXECUTABLE} ${EXECUTABLE_ARGS})
	endif()

endfunction()

function(add_valgrind_profile COND)
	set(options "")
	set(singleValueOpts TARGET_NAME EXECUTABLE)
	set(multiValueOpts VALGRIND_ARGS EXECUTABLE_ARGS)

	cmake_parse_arguments(add_valgrind_profile "${options}" "${singleValueOpts}" "${multiValueOpts}" ${ARGN})

	if (NOT EXECUTABLE)
		set(EXECUTABLE "${PROJECT_BINARY_DIR}/tests/${TARGET_NAME}")
	endif()

	if (NOT ${COND} OR NOT VALGRIND_COMMAND)
		add_test(${TARGET_NAME} ${EXECUTABLE} ${EXECUTABLE_ARGS})
	else ()
		add_test(${TARGET_NAME} ${VALGRIND_COMMAND} --tool=calgrind --error-exitcode=5 ${VALGRIND_ARGS} --quiet ${EXECUTABLE} ${EXECUTABLE_ARGS})
	endif()

endfunction()
