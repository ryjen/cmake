# - Find mysqlclient
# Find the native MySQL includes and library
#
#  MYSQL_INCLUDE_DIRS - where to find mysql.h, etc.
#  MYSQL_LIBRARIES    - List of libraries when using MySQL.
#  MYSQL_FOUND        - True if MySQL found.

find_program(MYSQL_CONFIG mysql_config)

if (NOT MYSQL_CONFIG)
  message(FATAL_ERROR "Could not find mysql_config program for MySql package")
endif()

execute_process(COMMAND ${MYSQL_CONFIG} --variable=pkgincludedir OUTPUT_VARIABLE MYSQL_INCLUDE_DIR)
execute_process(COMMAND ${MYSQL_CONFIG} --variable=pkglibdir OUTPUT_VARIABLE MYSQL_LIB_DIR)

find_library(LIBMYSQLCLIENT_FOUND mysqlclient HINTS ${MYSQL_LIB_DIR})

if (NOT LIBMYSQLCLIENT_FOUND) 
  message(FATAL_ERROR "libmysql not found")
endif()

set(MYSQL_LIBRARIES "-lmysqlclient")

string(REGEX REPLACE " ?\n$" "" MYSQL_INCLUDE_DIR "${MYSQL_INCLUDE_DIR}")
string(REGEX REPLACE " ?\n$" "" MYSQL_LIB_DIR "${MYSQL_LIB_DIR}")

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(MYSQL
  FOUND_VAR MYSQL_FOUND
  REQUIRED_VARS MYSQL_LIBRARIES MYSQL_INCLUDE_DIR
)

mark_as_advanced(
  MYSQL_LIBRARIES
  MYSQL_INCLUDE_DIR
)

