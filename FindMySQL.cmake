# - Find mysqlclient
# Find the native MySQL includes and library
#
#  MYSQL_INCLUDE_DIRS - where to find mysql.h, etc.
#  MYSQL_LIBRARIES    - List of libraries when using MySQL.
#  MYSQL_FOUND        - True if MySQL found.

find_program(MYSQL_CONFIG mysql_config)

if (NOT MYSQL_CONFIG)
  message(STATUS "Could not find mysql_config program for MySql package")
  return()
endif()

execute_process(COMMAND ${MYSQL_CONFIG} --variable=pkgincludedir OUTPUT_VARIABLE MYSQL_INCLUDE_DIR OUTPUT_STRIP_TRAILING_WHITESPACE ERROR_VARIABLE MYSQL_ERROR)

if (NOT MYSQL_ERROR)

  execute_process(COMMAND ${MYSQL_CONFIG} --variable=pkglibdir OUTPUT_VARIABLE MYSQL_LIB_DIR OUTPUT_STRIP_TRAILING_WHITESPACE ERROR_VARIABLE MYSQL_ERROR)

else()

  unset(MYSQL_INCLUDE_DIR)

  find_path(MYSQL_INCLUDE_DIR NAMES "mysql.h" PATH_SUFFIXES "mysql")

  if (NOT MYSQL_INCLUDE_DIR) 
    message(FATAL_ERROR "unable to find mysql include dir")
  endif()

  unset(MYSQL_LIB_DIR)

  find_path(MYSQL_LIB_DIR NAMES "libmysqlclient.so" PATH_SUFFIXES "mysql" PATHS "/usr/lib" "/usr/local/lib")

  if (NOT MYSQL_LIB_DIR)
    message(FATAL_ERROR "unable to find mysql lib dir")
  endif()
endif()


find_library(LIBMYSQLCLIENT_FOUND mysqlclient HINTS ${MYSQL_LIB_DIR})

if (NOT LIBMYSQLCLIENT_FOUND) 
  message(FATAL_ERROR "libmysql not found")
endif()

set(MYSQL_LIBRARIES "-lmysqlclient")

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(MYSQL
  FOUND_VAR MYSQL_FOUND
  REQUIRED_VARS MYSQL_LIBRARIES MYSQL_INCLUDE_DIR
)

mark_as_advanced(
  MYSQL_LIBRARIES
  MYSQL_INCLUDE_DIR
)

