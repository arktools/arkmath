# - Try to find  BoostNumericBindings
# Once done, this will define
#
#  BOOSTNUMERICBINDINGS_FOUND        : library found
#  BOOSTNUMERICBINDINGS_INCLUDE_DIRS : include directories
#  BOOSTNUMERICBINDINGS_VERSION      : version

# macros
include(FindPackageHandleStandardArgs)

# find the include directory
find_path(_BOOSTNUMERICBINDINGS_INCLUDE_DIR
    NAMES boost/numeric/bindings/lapack/lapack.h
    )

# handle arguments
set(BOOSTNUMERICBINDINGS_INCLUDE_DIRS ${_BOOSTNUMERICBINDINGS_INCLUDE_DIR}) 
find_package_handle_standard_args(BoostNumericBindings
    REQUIRED_VARS BOOSTNUMERICBINDINGS_INCLUDE_DIRS
    )
