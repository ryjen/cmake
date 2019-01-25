
find_program(HEADERDOC headerdoc2html)
find_program(GATHERDOC gatherheaderdoc)
find_program(DOXYGEN doxygen)

function(CREATE_DOCUMENTATION)
	set(options OPTIONAL)
	set(singleValueOpts TYPE)
	set(multiValueOpts)

	cmake_parse_arguments(CREATE_DOCUMENTATION "${options}" "${singleValueOpts}" "${multiValueOpts}" ${ARGN})

	set(ENABLE_DOXYGEN (NOT CREATE_DOCUMENTATION_TYPE OR CREATE_DOCUMENTATION_TYPE EQUAL "doxygen"))
	set(ENABLE_HEADERDOC (NOT CREATE_DOCUMENTATION_TYPE OR ${CREATE_DOCUMENTATION_TYPE} EQUAL "headerdoc"))

	if (DOXYGEN AND ENABLE_DOXYGEN)

		if (EXISTS ${PROJECT_SOURCE_DIR}/Doxyfile)
				set(DOXYFILE "${PROJECT_SOURCE_DIR}/Doxyfile")
		else()
			if (NOT EXISTS ${PROJECT_BINARY_DIR}/gen/Doxyfile)
				make_directory(${PROJECT_BINARY_DIR}/gen)
				execute_process(COMMAND ${DOXYGEN} -g WORKING_DIRECTORY ${PROJECT_BINARY_DIR}/gen ERROR_VARIABLE DOXYGEN_ERROR)
				if (DOXYGEN_ERROR)
					message(FATAL_ERROR "Unable to create doxygen configuration")
				endif()
			endif()
			set(DOXYFILE "${PROJECT_BINARY_DIR}/gen/Doxyfile")
		endif()

		add_custom_target(docs WORKING_DIRECTORY ${PROJECT_SOURCE_DIR} COMMAND ${DOXYGEN} ${PROJECT_SOURCE_DIR}/Doxyfile)

	elseif (HEADERDOC AND ENABLE_HEADERDOC)
		add_custom_target(docs COMMAND ${HEADERDOC} -o ${PROJECT_SOURCE_DIR}/html ${PROJECT_SOURCE_DIR}/src/**.h
																	 COMMAND ${GATHERDOC} ${PROJECT_BINARY_DIR}/html)
	else()
		message(WARNING "No document generator found. Try installing doxygen or headerdoc.")
	endif()

endfunction()
