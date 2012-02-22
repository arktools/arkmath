project (arkmath C CXX Fortran)

# settings
cmake_minimum_required (VERSION 2.6)
set(APPLICATION_NAME "${PROJECT_NAME}")
set(APPLICATION_VERSION_MAJOR "0")
set(APPLICATION_VERSION_MINOR "2")
set(APPLICATION_VERSION_PATCH "5")
set(APPLICATION_VERSION "${APPLICATION_VERSION_MAJOR}.${APPLICATION_VERSION_MINOR}.${APPLICATION_VERSION_PATCH}")
set(LIBRARY_VERSION ${APPLICATION_VERSION})
set(LIBRARY_SOVERSION "0.0.0")
set(BOOSTNUMERICBINDINGS_TAG "1f994e8a2e161cddb6577eacc76b7bc358701cbe")
set(PROJECT_CONTACT_EMAIL james.goppert@gmail.com)
set(PROJECT_CONTACT_VENDOR arkTools)

# modules
set(CMAKE_MODULE_PATH
	${CMAKE_SOURCE_DIR}/cmake
	${CMAKE_SOURCE_DIR}/cmake/arkcmake
)
include(ExternalProject)
include(DefineCMakeDefaults)
include(DefinePlatformDefaults)
include(DefineCompilerFlags)
include(DefineInstallationPaths)
include(FindBOOSTNUMERICBINDINGS)
include(CPackPackage)

# settings
option(WITH_BUILD_STATIC "Prefer static linking." ON)
option(WITH_BUILD_TESTING "Build test programs." ON)
option(WITH_BUILD_DEPS_FOUND "Build all external dependencies, even if found." OFF)
option(WITH_BUILD_DEPS "Build external dependencies." ON)

# enable languages
enable_language(C)
enable_language(CXX)
enable_language(Fortran)

# internal variables
set(BUILDING_DEPS OFF CACHE INTERNAL "Whether are not we are building the dependencies.")
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/bin)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/lib)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/lib)
if(NOT EP_BASE_DIR)
    set(EP_BASE_DIR "${CMAKE_BINARY_DIR}/CMakeExternals")
endif()
set(CMAKE_FIND_ROOT_PATH "${EP_BASE_DIR}")

# static lib options
if (WITH_BUILD_STATIC)
    set(BOOST_USE_STATIC_LIBS ON)
    # prefer static libs
    if(WIN32)
        set(CMAKE_FIND_LIBRARY_SUFFIXES .lib .a ${CMAKE_FIND_LIBRARY_SUFFIXES})
    else()
        set(CMAKE_FIND_LIBRARY_SUFFIXES .a ${CMAKE_FIND_LIBRARY_SUFFIXES})
    endif()
endif()

# add make dist target
add_custom_target(dist COMMAND ${CMAKE_MAKE_PROGRAM} package_source)

# build external dependencies automatically if make found
if ( NOT ("${CMAKE_MAKE_PROGRAM}" STREQUAL "") AND (NOT BUILDING_DEPS) AND (WITH_BUILD_DEPS) )
    execute_process(COMMAND ${CMAKE_COMMAND} ".." "-DBUILDING_DEPS=y")
    execute_process(COMMAND ${CMAKE_MAKE_PROGRAM} "-f${CMAKE_BINARY_DIR}/Makefile")
endif()

# find libraries with cmake modules
find_package(LAPACK)
if(WIN32)
    find_package(Boost 1.40.0 REQUIRED COMPONENTS system-mt thread_win32-mt)
else()
    find_package(Boost 1.40.0 REQUIRED COMPONENTS system-mt thread-mt)
endif()
find_package (BOOSTNUMERICBINDINGS)

# build external libraries if required
if (BUILDING_DEPS)
    set_property(DIRECTORY PROPERTY EP_BASE ${EP_BASE_DIR})
    if (WITH_BUILD_DEPS_FOUND OR (NOT MAVLINK_FOUND))
        set(ARGS_BOOSTNUMERICBINDINGS
        )
        build_boostnumericbindings(${BOOSTNUMERICBINDINGS_TAG} ${EP_BASE_DIR} "${ARGS_BOOSTNUMERICBINDINGS}")
    endif()
    # the return here terminates the cmake once all dependencies are built
    return()
endif()

# pkgconfig
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/pc.cmake ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}.pc)
install(FILES
	${PROJECT_BINARY_DIR}/${PROJECT_NAME}.pc
	DESTINATION lib/pkgconfig
	)

# project wide flags
include_directories( ${PROJECT_SOURCE_DIR}/src ${PROJECT_BINARY_DIR}/src)
add_definitions(-DBOOST_THREAD_USE_LIB)

# install data files
install(DIRECTORY "${PROJECT_SOURCE_DIR}/data" DESTINATION share/${PROJECT_NAME} PATTERN "*.git*" EXCLUDE)

# install external projects, if built
if (EXISTS ${EP_BASE_DIR}/${EP_INSTALL_PREFIX}/)
    install(DIRECTORY ${EP_BASE_DIR}/${EP_INSTALL_PREFIX}/ DESTINATION ${CMAKE_INSTALL_PREFIX})
endif()

# subdirectories
add_subdirectory(src)
if (WITH_BUILD_TESTING)
	add_subdirectory(test)
endif ()
