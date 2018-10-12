
function(config_packages_deb)
  set(options)
  set(singleValueOpts DEPENDS SECTION RECOMMENDS)
  set(multiValueOpts)

  cmake_parse_arguments(CONFIG_PACKAGES "${options}" "${singleValueOpts}" "${multiValueOpts}" ${ARGN})

  set(CPACK_DEBIAN_PACKAGE_DEPENDS ${CONFIG_PACKAGES_DEPENDS})
  set(CPACK_DEBIAN_PACKAGE_SECTION ${CONFIG_PACKAGES_SECTION})
  set(CPACK_DEBIAN_PACKAGE_RECOMMENDS ${CONFIG_PACKAGES_RECOMMENDS})

endfunction()

function(config_packages_rpm)
  set(options)
  set(singleValueOpts DEPENDS SECTION)
  set(multiValueOpts)

  cmake_parse_arguments(CONFIG_PACKAGES "${options}" "${singleValueOpts}" "${multiValueOpts}" ${ARGN})

  set(CPACK_RPM_PACKAGE_GROUP "${CONFIG_PACKAGES_SECTION}")
  set(CPACK_RPM_PACKAGE_REQUIRES ${CONFIG_PACKAGES_DEPENDS})

endfunction()

function(create_distributions)
  set(options)
  set(singleValueOpts TYPES VENDOR MAINTAINER DESCRIPTION INSTALL_PREFIX LICENSE README)
  set(multiValueOpts)

  cmake_parse_arguments(GEN_PACKAGE "${options}" "${singleValueOpts}" "${multiValueOpts}" ${ARGN})

  if (NOT GEN_PACKAGE_TYPES) 
    set(GEN_PACKAGE_TYPES "DEB;RPM;TGZ;ZIP")
  endif()

  if (NOT GEN_PACKAGE_MAINTAINER)
    set(GEN_PACKAGE_MAINTAINER "Ryan Jennings <ryan@micrantha.com>")
  endif()
  
  if (NOT GEN_PACKAGE_VENDOR)
    set(GEN_PACKAGE_VENDOR "Micrantha Software Solutions")
  endif()

  if (NOT GEN_PACKAGE_DESCRIPTION)
    message(FATAL_ERROR "No description provided to package generator")
  endif()

  if (NOT GEN_PACKAGE_INSTALL_PREFIX)
    set(GEN_PACKAGE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")
  endif()

  if (NOT GEN_PACKAGE_LICENSE) 
    set(GEN_PACKAGE_LICENSE "${CMAKE_SOURCE_DIR}/LICENSE")
  endif()

  if (NOT GEN_PACKAGE_README)
    set(GEN_PACKAGE_README "${CMAKE_SOURCE_DIR}/README.md")
  endif()

  # Tell CPack to generate a .deb package
  set(CPACK_GENERATOR ${GEN_PACKAGE_TYPES})

  # Set a Package Maintainer.
  # This is required
  set(CPACK_DEBIAN_PACKAGE_MAINTAINER "${GEN_PACKAGE_MAINTAINER}")

  set(CPACK_PACKAGE_VENDOR "${GEN_PACKAGE_VENDOR}")

  # Set a Package Version
  set(CPACK_PACKAGE_VERSION ${PROJECT_VERSION})

  set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "${GEN_PACKAGE_DESCRIPTION}")

  set(CPACK_PACKAGING_INSTALL_PREFIX "${GEN_PACKAGE_INSTALL_PREFIX}")

  set(CPACK_RESOURCE_FILE_LICENSE "${GEN_PACKAGE_LICENSE}")

  set(CPACK_RESOURCE_FILE_README "${GEN_PACKAGE_README}")

  # Include CPack
  include(CPack)
endfunction()

