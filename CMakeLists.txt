project (arkmath C CXX Fortran)

# settings
cmake_minimum_required (VERSION 2.8)
set(PROJECT_VERSION_MAJOR "0")
set(PROJECT_VERSION_MINOR "2")
set(PROJECT_VERSION_PATCH "7")
set(PROJECT_VERSION "${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}.${PROJECT_VERSION_PATCH}")
set(PROJECT_CONTACT_EMAIL james.goppert@gmail.com)
set(PROJECT_CONTACT_VENDOR arkTools)
set(LIBRARY_VERSION ${PROJECT_VERSION})
set(LIBRARY_SOVERSION "0.0.0")

# options
option(WITH_BUILD_DEPS "Build external dependencies." ON)
option(WITH_BUILD_SHARED "Build shared library." OFF)
option(WITH_PREFER_STATIC "Prefer static linking." ON)
option(WITH_BUILD_TESTING "Build test programs." OFF)
option(WITH_LAPACK "Build with lapack library support." OFF)

# variables
set(ROOT_THREAD TRUE CACHE INTERNAL "Is this the top level of the recursion?")
set(INSTALLED_TARGETS "")

# modules
list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake ${CMAKE_SOURCE_DIR}/cmake/arkcmake)
include(BundleUtilities)
include(CheckIncludeFiles)
include(CheckFunctionExists)
include(CheckSymbolExists)
include(CheckLibraryExists)
#include(CheckTypeSize)
#include(CheckPrototypeExists)
#include(CheckCXXSourceCompiles)
#include(CheckCSourceCompiles)
include(ExternalProject)

# spawn new cmake to build deps
if (WITH_BUILD_DEPS AND ROOT_THREAD)
    execute_process(COMMAND ${CMAKE_COMMAND} "${CMAKE_SOURCE_DIR}"
        "-DCMAKE_TOOLCHAIN_FILE=${CMAKE_TOOLCHAIN_FILE}"
        "-DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}"
        "-DEP_BASE_DIR=${EP_BASE_DIR}"
        "-DWITH_BUILD_DEPS=${WITH_BUILD_DEPS}"
        "-DWITH_BUILD_SHARED=${WITH_BUILD_SHARED}"
        "-DWITH_PREFER_STATIC=${WITH_PREFER_STATIC}"
        "-DWITH_TESTING=${WITH_TESTING}"
        "-DWITH_LAPACK=${WITH_LAPACK}"
        "-DROOT_THREAD=FALSE"
        RESULT_VARIABLE ERROR)
    if (ERROR)
        message(FATAL_ERROR "error, recursing loop returned error code: ${ERROR}")
    endif()
    message("** Making dependencies")
    execute_process(COMMAND ${CMAKE_MAKE_PROGRAM} "-j4" "-f${CMAKE_BINARY_DIR}/Makefile")
    message("** Configuring ${PROJECT_NAME}")
endif()

# external projects find path
if(NOT EP_BASE_DIR)
    set(EP_BASE_DIR "${CMAKE_BINARY_DIR}/CMakeExternals")
endif()
list(APPEND CMAKE_FIND_ROOT_PATH ${EP_BASE_DIR})

# prefer static packages if building static library
message("** Finding libraries")
if (WITH_PREFER_STATIC)
    set(BOOST_USE_STATIC_LIBS ON)
    # prefer static libs
    if(WIN32)
        set(CMAKE_FIND_LIBRARY_SUFFIXES .lib .a ${CMAKE_FIND_LIBRARY_SUFFIXES})
    else()
        set(CMAKE_FIND_LIBRARY_SUFFIXES .a ${CMAKE_FIND_LIBRARY_SUFFIXES})
    endif()
endif()

# find libraries with cmake modules
set(REQUIRED_IF_ROOT_THREAD)
if (ROOT_THREAD)
    set(REQUIRED_IF_ROOT_THREAD "REQUIRED")
endif()
if(WITH_LAPACK)
    enable_language(Fortran)
    find_package(LAPACK)
    find_package(BoostNumericBindings ${REQUIRED_IF_ROOT_THREAD})
endif()
if(WIN32)
    find_package(Boost 1.40.0 REQUIRED COMPONENTS system-mt thread_win32-mt)
else()
    find_package(Boost 1.40.0 REQUIRED COMPONENTS system-mt thread-mt)
endif()

# build dependencies
if (WITH_BUILD_DEPS AND (NOT ROOT_THREAD) )
    message("** Configuring dependencies")

    # add external projects

    set(CMAKE_DEFAULT_ARGS
        -DEP_BASE_DIR=${EP_BASE_DIR}
        -DCMAKE_TOOLCHAIN_FILE=${CMAKE_TOOLCHAIN_FILE}
        -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
        )

    if (WITH_LAPACK)
        ExternalProject_Add(boost-numeric-bindings
            URL http://mathema.tician.de/news.tiker.net/download/software/boost-numeric-bindings/boost-numeric-bindings-20081116.tar.gz
            URL_MD5 835c88497ba8d6fd745e3971c560a6a3
            BUILD_IN_SOURCE 1
            CONFIGURE_COMMAND ""
            BUILD_COMMAND ""
            INSTALL_DIR ${EP_BASE_DIR}/${CMAKE_INSTALL_PREFIX}
            INSTALL_COMMAND ${CMAKE_COMMAND} -E  copy_directory boost ${EP_BASE_DIR}/${CMAKE_INSTALL_PREFIX}/include/boost
        )
    endif()

    # terminate non root cmake thread
    return()
endif()

# configure
#check_include_files(string.h HAVE_STRING_H)
#check_function_exists(memcopy HAVE_MEMCOPY)
#check_symbol_exists(LC_MESSAGES "locale.h" HAVE_LC_MESSAGES) 
#check_library_exists(arkosg  attachNode "" HAVE_ARKOSG)

# config files
set(INSTALL_DATA_DIR "${CMAKE_INSTALL_PREFIX}/share/${PROJECT_NAME}")
configure_file(config.h.in config.h)
install(FILES ${CMAKE_BINARY_DIR}/config.h DESTINATION include/${PROJECT_NAME} COMPONENT Runtime)

# build settings
include_directories(
    ${CMAKE_SOURCE_DIR}/src
    ${PROJECT_BINARY_DIR}/src
    ${BOOSTNUMERICBINDINGS_INCLUDE_DIRS}
    ${Boost_INCLUDE_DIRS}
    )
add_definitions(-DBOOST_THREAD_USE_LIB)

# install data files
install(DIRECTORY "${PROJECT_SOURCE_DIR}/data" DESTINATION share/${PROJECT_NAME} COMPONENT Dev PATTERN "*.git*" EXCLUDE)

set(generalSources
    src/GeoMag.cpp
    src/utilities.cpp
    )

set(generalHeaders
    src/GeoMag.hpp
    src/GpsIns.hpp
    src/storage_adaptors.hpp
    src/utilities.hpp
    )

if (WITH_LAPACK)
    list(APPEND generalSources src/GpsIns.cpp)
    list(APPEND generalHeaders src/GpsIns.hpp)
endif()
file(GLOB  gen_cppHeaders "src/gen_cpp/*.h*")
file(GLOB  gen_fortranHeaders "src/gen_cpp/*.f*")
file(GLOB  gen_sciHeaders "src/gen_sci/*.sci")

# link libraries
set(ARKMATH_LINK_LIBS
    ${Boost_LIBRARIES} 
    ${LAPACK_LIBRARIES}
    m
    )
if (WITH_LAPACK)
    list(APPEND ARKMATH_LINK_LIBS gfortran)
endif()

# static library
add_library(arkmathStatic STATIC ${generalSources})
add_dependencies(arkmathStatic boost-numeric-bindings)
set(STATIC_LIBNAME_SUFFIX "")
if (MSVC)
    set(STATIC_LIBNAME_SUFFIX "static")
endif()
set_target_properties(arkmathStatic PROPERTIES
    OUTPUT_NAME arkmath${STATIC_LIBNAME_SUFFIX}
    VERSION ${LIBRARY_VERSION}
    PUBLIC_HEADER ""
    PRIVATE_HEADER ""
    )
target_link_libraries(arkmathStatic ${ARKMATH_LINK_LIBS})
list(APPEND INSTALLED_TARGETS arkmathStatic)

# shared library
if (WITH_BUILD_SHARED)
    add_library(arkmathShared STATIC ${generalSources})
    add_dependencies(arkmathShared boost-numeric-bindings)
    set_target_properties(arkmathShared PROPERTIES
        OUTPUT_NAME arkmath
        VERSION ${LIBRARY_VERSION}
        SOVERSION ${LIBRARY_SOVERSION}
        PUBLIC_HEADER ""
        PRIVATE_HEADER ""
        )
    target_link_libraries(arkmathShared ${ARKMATH_LINK_LIBS})
    list(APPEND INSTALLED_TARGETS arkmathShared)
endif()

# generated files/ headers install
install(FILES ${generalHeaders} DESTINATION include/${PROJECT_NAME} COMPONENT Dev)
install(FILES ${gen_cppHeaders} DESTINATION include/${PROJECT_NAME}/gen_cpp COMPONENT Dev)
install(FILES ${gen_fortranHeaders} DESTINATION include/${PROJECT_NAME}/gen_fortran COMPONENT Dev)
install(FILES ${gen_sciHeaders} DESTINATION include/${PROJECT_NAME}/gen_sciHeaders COMPONENT Dev)

# testing
if (WITH_BUILD_TESTING AND LAPACK_FOUND)
    add_executable(ins ins.cpp)
    target_link_libraries(ins arkmathStatic)
endif ()

# install
install(TARGETS  ${INSTALLED_TARGETS}
    RUNTIME DESTINATION "bin" COMPONENT Runtime
    LIBRARY DESTINATION "lib" COMPONENT Runtime
    ARCHIVE DESTINATION "lib" COMPONENT Dev
    BUNDLE DESTINATION "/Applications" COMPONENT Runtime
    FRAMEWORK DESTINATION "/Library/Frameworks" COMPONENT Runtime
    # where to put files on non-mac computers, mac overrides and uses default
    PRIVATE_HEADER DESTINATION "include/jsbsim" COMPONENT Runtime
    PUBLIC_HEADER DESTINATION "include/jsbsim" COMPONENT Runtime
    RESOURCE DESTINATION "share/jsbsim" COMPONENT Runtime
    )

# install external projects, if built
if (EXISTS ${EP_BASE_DIR}/${CMAKE_INSTALL_PREFIX}/)
    install(DIRECTORY ${EP_BASE_DIR}/${CMAKE_INSTALL_PREFIX}/ DESTINATION ${CMAKE_INSTALL_PREFIX} COMPONENT Runtime)
endif()

### packaging
# set icns file containing icons
if (APPLE)
    # set how it shows up in Info.plist
    set(MACOSX_BUNDLE_ICON_FILE arkmath.icns)
    # set where in the bundle to put the icns file
    set_source_files_properties(cmake/arkmath.icns PROPERTIES MACOSX_PACKAGE_LOCATION Resources)
    # include the icns file in the target
    #list(APPEND ARKMATH_TEST_SRCS cmake/arkmath.icns)
endif(APPLE)

# set NSIS image
if (WIN32)
    # nsis bug requuires atleast one file with 4 slashes to install correctly
    set(CPACK_PACKAGE_ICON "${CMAKE_SOURCE_DIR}\\\\/cmake/arkmath-nsis.bmp")
endif(WIN32)

# add file extensions and set resource files
configure_file("COPYING" "COPYING.txt" COPYONLY)
configure_file("README" "README.txt" COPYONLY)
set(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_BINARY_DIR}/COPYING.txt")
set(CPACK_RESOURCE_FILE_README "${CMAKE_BINARY_DIR}/README.txt")
set(CPACK_PACKAGE_DESCRIPTION_FILE "${CPACK_RESOURCE_FILE_README}")
set(CPACK_RESOURCE_FILE_WELCOME "${CMAKE_SOURCE_DIR}/cmake/WELCOME.txt")
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "arktools math library")
set(CPACK_PACKAGE_VENDOR ${PROJECT_CONTACT_VENDOR})
set(CPACK_PACKAGE_CONTACT "${PROJECT_CONTACT_EMAIL}")
set(CPACK_PACKAGE_VERSION ${PROJECT_VERSION})
set(CPACK_SET_DESTDIR TRUE)
set(CPACK_COMPONENTS_GROUPING "ALL_COMPONENTS_IN_ONE")
set(CPACK_PACKAGE_EXECUTABLES
    #"cmd" "Command Line"
    #"gui" "Gui"
    )
include(CPack)

# pkgconfig
configure_file(pc.in ${PROJECT_NAME}.pc)
install(FILES
    ${PROJECT_BINARY_DIR}/${PROJECT_NAME}.pc
    DESTINATION "lib/pkgconfig" COMPONENT Dev
    )
# vim:sw=4:ts=4:expandtab
