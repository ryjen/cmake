
find_program(MEMCHECK_COMMAND valgrind)

if (MEMCHECK_COMMAND)
	SET(MEMCHECK_FOUND ON "Memory checking support found.")
endif()

function(add_memcheck_test _targetname _testrunner)

	if (NOT MEMCHECK_COMMAND)
		MESSAGE( "Memcheck command not found!")
		add_test(${_targetname} ${_testrunner})
	else(MEMCHECK_COMMAND)
		add_test(${_targetname} ${MEMCHECK_COMMAND} --leak-check=full --error-exitcode=5 ${ARGV2} --quiet ${_testrunner})
	endif()

endfunction()

