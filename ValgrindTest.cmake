
find_program(VALGRIND_COMMAND valgrind)

if (VALGRIND_COMMAND)
    set(VALGRIND_COMMAND ON CACHE STRING "Memory checking support found.")
endif ()

function(add_valgrind_test)
    set(options)
    set(singleValueOpts TARGET EXECUTABLE MEMCHECK)
    set(multiValueOpts VALGRIND_ARGS EXECUTABLE_ARGS)

    cmake_parse_arguments(ADD_VALGRIND_TEST "${options}" "${singleValueOpts}" "${multiValueOpts}" ${ARGN})

    if (NOT ADD_VALGRIND_TEST_TARGET)
        message(FATAL_ERROR "No target specified to add_valgrind_test")
    endif ()

    if (NOT ADD_VALGRIND_TEST_EXECUTABLE)
        set(ADD_VALGRIND_TEST_EXECUTABLE "${PROJECT_BINARY_DIR}/tests/${ADD_VALGRIND_TEST_TARGET}")
    endif ()

    if (NOT ADD_VALGRIND_TEST_MEMCHECK OR NOT VALGRIND_COMMAND)
        add_test(${ADD_VALGRIND_TEST_TARGET} ${ADD_VALGRIND_TEST_EXECUTABLE} ${ADD_VALGRIND_TEST_EXECUTABLE_ARGS})
    else ()
        add_test(${ADD_VALGRIND_TEST_TARGET} ${VALGRIND_COMMAND} --leak-check=full --error-exitcode=5 ${ADD_VALGRIND_TEST_VALGRIND_ARGS} --quiet ${ADD_VALGRIND_TEST_EXECUTABLE} ${ADD_VALGRIND_TEST_EXECUTABLE_ARGS})
    endif ()

endfunction()

function(add_valgrind_profile)
    set(options)
    set(singleValueOpts TARGET EXECUTABLE PROFILING)
    set(multiValueOpts VALGRIND_ARGS EXECUTABLE_ARGS)

    cmake_parse_arguments(ADD_VALGRIND_PROFILE "${options}" "${singleValueOpts}" "${multiValueOpts}" ${ARGN})

    if (NOT ADD_VALGRIND_PROFILE_TARGET)
        message(FATAL_ERROR "No target specified for ADD_VALGRIND_PROFILE")
    endif ()

    if (NOT ADD_VALGRIND_PROFILE_EXECUTABLE)
        set(ADD_VALGRIND_PROFILE_EXECUTABLE "${PROJECT_BINARY_DIR}/tests/${ADD_VALGRIND_PROFILE_TARGET}")
    endif ()

    if (NOT ADD_VALGRIND_PROFILE_PROFILING OR NOT VALGRIND_COMMAND)
        add_test(${ADD_VALGRIND_PROFILE_TARGET} ${ADD_VALGRIND_PROFILE_EXECUTABLE} ${ADD_VALGRIND_PROFILE_EXECUTABLE_ARGS})
    else ()
        add_test(${ADD_VALGRIND_PROFILE_TARGET} ${VALGRIND_COMMAND} --tool=callgrind --error-exitcode=5 ${ADD_VALGRIND_PROFILE_VALGRIND_ARGS} --quiet ${ADD_VALGRIND_PROFILE_EXECUTABLE} ${ADD_VALGRIND_PROFILE_EXECUTABLE_ARGS})
    endif ()

endfunction()

function(add_valgrind_profile_test)
    set(options)
    set(singleValueOpts TARGET EXECUTABLE PROFILING MEMCHECK)
    set(multiValueOpts VALGRIND_ARGS EXECUTABLE_ARGS)

    cmake_parse_arguments(ADD_VALGRIND_PROFILE_TEST "${options}" "${singleValueOpts}" "${multiValueOpts}" ${ARGN})

    if (NOT ADD_VALGRIND_PROFILE_TEST_TARGET)
        message(FATAL_ERROR "No target specified for ADD_VALGRIND_PROFILE")
    endif ()

    if (NOT ADD_VALGRIND_PROFILE_TEST_EXECUTABLE)
        set(ADD_VALGRIND_PROFILE_TEST_EXECUTABLE "${PROJECT_BINARY_DIR}/tests/${ADD_VALGRIND_PROFILE_TEST_TARGET}")
    endif ()

    if (ADD_VALGRIND_PROFILE_TEST_PROFILING)
        add_valgrind_profile(PROFILING ${ADD_VALGRIND_PROFILE_TEST_PROFILING} TARGET ${ADD_VALGRIND_PROFILE_TEST_TARGET}
                EXECUTABLE ${ADD_VALGRIND_PROFILE_TEST_EXECUTABLE} VALGRIND_ARGS ${ADD_VALGRIND_PROFILE_TEST_VALGRIND_ARGS}
                EXECUTABLE_ARGS ${ADD_VALGRIND_PROFILE_TEST_EXECUTABLE_ARGS})
    else ()
        add_valgrind_test(MEMCHECK ${ADD_VALGRIND_PROFILE_TEST_MEMCHECK} TARGET ${ADD_VALGRIND_PROFILE_TEST_TARGET}
                EXECUTABLE ${ADD_VALGRIND_PROFILE_TEST_EXECUTABLE} VALGRIND_ARGS ${ADD_VALGRIND_PROFILE_TEST_VALGRIND_ARGS}
                EXECUTABLE_ARGS ${ADD_VALGRIND_PROFILE_TEST_EXECUTABLE_ARGS})
    endif ()

endfunction()
