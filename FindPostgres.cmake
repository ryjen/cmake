# - Find POSTGRESclient
# Find the native POSTGRES includes and library
#
#  POSTGRES_LIB_DIRS     - where to find libraries
#  POSTGRES_INCLUDE_DIRS - where to find postgres.h, etc.
#  POSTGRES_LIBRARIES    - List of libraries when using postgres.
#  POSTGRES_FOUND        - True if postgres found.

find_program(PG_CONFIG pg_config)

if (NOT PG_CONFIG)
  message(FATAL_ERROR "Unable to find pg_config program for Postgres")
endif()

execute_process(COMMAND ${PG_CONFIG} --includedir OUTPUT_VARIABLE POSTGRES_INCLUDE_DIR)
execute_process(COMMAND ${PG_CONFIG} --includedir-server OUTPUT_VARIABLE POSTGRES_INCLUDE_DIR_SERVER)
execute_process(COMMAND ${PG_CONFIG} --libdir OUTPUT_VARIABLE POSTGRES_LIB_DIR)
execute_process(COMMAND ${PG_CONFIG} --pkglibdir OUTPUT_VARIABLE POSTGRES_LIB_DIR_PKG)

find_library(LIBPQ_FOUND pq HINTS ${POSTGRES_LIB_DIR} ${POSTGRES_LIB_DIR_PKG})

if (NOT LIBPQ_FOUND) 
  message(FATAL_ERROR "Unable to find libpq for Postgres")
endif()

set(POSTGRES_LIBRARIES "-lpq")

string(REGEX REPLACE " ?\n$" "" POSTGRES_INCLUDE_DIR "${POSTGRES_INCLUDE_DIR}")
string(REGEX REPLACE " ?\n$" "" POSTGRES_INCLUDE_DIR_SERVER "${POSTGRES_INCLUDE_DIR_SERVER}")
string(REGEX REPLACE " ?\n$" "" POSTGRES_LIB_DIR "${POSTGRES_LIB_DIR}")
string(REGEX REPLACE " ?\n$" "" POSTGRES_LIB_DIR_PKG "${POSTGRES_LIB_DIR_PKG}")

mark_as_advanced(
  POSTGRES_LIBRARIES
  POSTGRES_INCLUDE_DIRS
  POSTGRES_LIB_DIRS
  POSTGRES_INCLUDE_DIR
  POSTGRES_LIB_DIR
  POSTGRES_INCLUDE_DIR_SERVER
  POSTGRES_LIB_DIR_PKG
  )

set(POSTGRES_INCLUDE_DIRS "${POSTGRES_INCLUDE_DIR};${POSTGRES_INCLUDE_DIR_SERVER}")
set(POSTGRES_LIB_DIRS "${POSTGRES_LIB_DIR};${POSTGRES_LIB_DIR_PKG}")

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(POSTGRES
  FOUND_VAR POSTGRES_FOUND
  REQUIRED_VARS POSTGRES_LIBRARIES POSTGRES_INCLUDE_DIRS POSTGRES_LIB_DIRS
  )

