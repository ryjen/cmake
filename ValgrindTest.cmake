
find_program(VALGRIND_COMMAND valgrind)

if (VALGRIND_COMMAND)
	SET(VALGRIND_COMMAND ON CACHE STRING "Memory checking support found.")
endif()

function(add_valgrind_test _targetname _testrunner)

	if (NOT VALGRIND_COMMAND)
		MESSAGE( "Valgrind command not found!")
		add_test(${_targetname} ${_testrunner} ${ARGN})
	else ()
		add_test(${_targetname} ${VALGRIND_COMMAND} --leak-check=full --error-exitcode=5 ${ARGV2} --quiet ${_testrunner} ${ARG3})
	endif()

endfunction()

function(add_valgrind_profile _targetname _testrunner)

	if (NOT VALGRIND_COMMAND)
		MESSAGE( "Valgrind command not found!")
		add_test(${_targetname} ${_testrunner} ${ARGN})
	else ()
		add_test(${_targetname} ${VALGRIND_COMMAND} --tool=callgrind --error-exitcode=5 ${ARGV2} --quiet ${_testrunner} ${ARG3})
	endif()

endfunction()


function(add_opt_valgrind_test _cond _targetname _testrunner)

  if (NOT ${_cond} OR NOT VALGRIND_COMMAND)
    add_test(${_targetname} ${_testrunner} ${ARGN})
  else ()
    add_test(${_targetname} ${VALGRIND_COMMAND} --leak-check=full --error-exitcode=5 ${ARGV3} --quiet ${_testrunner} ${ARG4})
  endif()

endfunction()


function(add_opt_valgrind_profile _cond _targetname _testrunner)

  if (NOT ${_cond} OR NOT VALGRIND_COMMAND)
    add_test(${_targetname} ${_testrunner} ${ARGN})
  else ()
    add_test(${_targetname} ${VALGRIND_COMMAND} --tool=calgrind --error-exitcode=5 ${ARGV3} --quiet ${_testrunner} ${ARG4})
  endif()

endfunction()
