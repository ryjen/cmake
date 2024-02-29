
include(CreateDistributions)
include(CreatePackageConfig)

function(create_packages)
  set(options)
  set(singleValueOpts TYPES MAINTAINER VENDOR DESCRIPTION INSTALL_PREFIX LICENSE README TARGET URL VERSION)
  set(multiValueOpts)

  cmake_parse_arguments(GEN_PACKAGES "${options}" "${singleValueOpts}" "${multiValueOpts}" ${ARGN})
  create_package_config(DESCRIPTION ${GEN_PACKAGES_DESCRIPTION} TARGET ${GEN_PACKAGES_TARGET} URL ${GEN_PACKAGES_URL} VERSION ${GEN_PACKAGES_VERSION})

  create_distributions(TYPES ${GEN_PACKAGES_TYPES} DESCRIPTION ${GEN_PACKAGES_DESCRIPTION} MAINTAINER ${GEN_PACKAGES_MAINTAINER} VENDOR ${GEN_PACKAGES_VENDOR} 
    INSTALL_PREFIX ${GEN_PACKAGES_INSTALL_PREFIX} LICENSE ${GEN_PACKAGES_LICENSE} README ${GEN_PACKAGES_README})

endfunction()
