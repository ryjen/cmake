# JSON-C_FOUND - true if library and headers were found
# JSON-C_INCLUDE_DIRS - include directories
# JSON-C_LIBRARIES - library directories

find_package(PkgConfig)

pkg_search_module(PC_JSON_C QUIET json-c>=0.10 json>=0.10)

find_path(JSON_C_INCLUDE_DIR json.h
	HINTS ${PC_JSON_C_INCLUDEDIR} ${PC_JSON_C_INCLUDE_DIRS} ${PC_JSON_INCLUDE_DIRS} ${PC_JSON_INCLUDEDIR} PATH_SUFFIXES json-c json)

find_library(JSON_C_LIBRARY NAMES json-c libjson-c json libjson
	HINTS ${PC_JSON_C_LIBDIR} ${PC_JSON_C_LIBRARY_DIRS} ${PC_JSON_LIBDIR} ${PC_JSON_LIBRARY_DIRS})

set(JSON_C_LIBRARIES ${JSON_C_LIBRARY})
set(JSON_C_INCLUDE_DIRS ${JSON_C_INCLUDE_DIR})

if (PC_JSON_C_FOUND)
	set(JSON_C_EXTENDED ON)
endif()

include(FindPackageHandleStandardArgs)

find_package_handle_standard_args(JSON_C DEFAULT_MSG JSON_C_LIBRARY JSON_C_INCLUDE_DIR)

mark_as_advanced(JSON_C_INCLUDE_DIR JSON_C_LIBRARY)

