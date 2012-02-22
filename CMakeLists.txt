project (arkmath)

# settings
cmake_minimum_required (VERSION 2.6)
set(APPLICATION_VERSION_MAJOR "0")
set(APPLICATION_VERSION_MINOR "2")
set(APPLICATION_VERSION_PATCH "5")
set(LIBRARY_SOVERSION "0.0.0")
set(BOOSTNUMERICBINDINGS_TAG "1f994e8a2e161cddb6577eacc76b7bc358701cbe")
set(PROJECT_CONTACT_EMAIL james.goppert@gmail.com)
set(PROJECT_CONTACT_VENDOR arkTools)

# modules
set(CMAKE_MODULE_PATH
	${CMAKE_SOURCE_DIR}/cmake
	${CMAKE_SOURCE_DIR}/cmake/arkcmake
)
include(FindBOOSTNUMERICBINDINGS)

# use common setup
include(CommonSetup)
set(LIBRARY_VERSION ${APPLICATION_VERSION})

# cpack
if(WIN32)
	set(CPACK_GENERATOR "NSIS")
	set(CPACK_SOURCE_GENERATOR "ZIP")
    set(CMAKE_INSTALL_PREFIX "/usr/local")
    # There is a bug in NSI that does not handle full unix paths properly. Make
    # sure there is at least one set of four (4) backlasshes.
    #set(CPACK_PACKAGE_ICON "${CMake_SOURCE_DIR}/Utilities/Release\\\\InstallIcon.bmp")
    #set(CPACK_NSIS_INSTALLED_ICON_NAME "bin\\\\arkmath.exe")
    set(CPACK_NSIS_DISPLAY_NAME "${PROJECT_NAME}-${APPLICATION_VERSION}")
    set(CPACK_NSIS_HELP_LINK "http:\\\\\\\\github.com/arktools/arkmath")
    set(CPACK_NSIS_URL_INFO_ABOUT "http:\\\\\\\\github.com/arktools/arkmath")
    set(CPACK_NSIS_CONTACT ${PROJECT_CONTACT_EMAIL})
    set(CPACK_NSIS_MODIFY_PATH ON)
else()
    #set(CPACK_STRIP_FILES "bin/ins")
    #set(CPACK_SOURCE_STRIP_FILES "")
    if(APPLE)
        set(CPACK_GENERATOR "PackageMaker")
        set(CPACK_SOURCE_GENERATOR "TGZ")
            elseif(UNIX)
        set(CPACK_GENERATOR "DEB")
        set(CPACK_SOURCE_GENERATOR "ZIP")
    else()
        message(FATAL_ERROR "unknown operating system")
    endif()
endif()
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "arkTools math module")
set(CPACK_PACKAGE_VENDOR ${PROJECT_VENDOR})
set(CPACK_PACKAGE_CONTACT ${PROJECT_CONTACT_EMAIL})
set(CPACK_PACKAGE_DESCRIPTION_FILE "${CMAKE_CURRENT_SOURCE_DIR}/README")
set(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_CURRENT_SOURCE_DIR}/COPYING")
set(CPACK_PACKAGE_VERSION_MAJOR "${APPLICATION_VERSION_MAJOR}") 
set(CPACK_PACKAGE_VERSION_MINOR "${APPLICATION_VERSION_MINOR}")
set(CPACK_PACKAGE_VERSION_PATCH "${APPLICATION_VERSION_PATCH}")
set(CPACK_PACKAGE_INSTALL_DIRECTORY "${PROJECT_NAME}-${APPLICATION_VERSION}")
set(CPACK_SET_DESTDIR TRUE)
set(CPACK_SOURCE_IGNORE_FILES ${CPACK_SOURCE_IGNORE_FILES}
	/.git/;/build/;~$;.*\\\\.bin$;.*\\\\.swp$)
set(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_SOURCE_DIR}/COPYING")
set(CPACK_RESOURCE_FILE_README "${CMAKE_SOURCE_DIR}/README")
set(CPACK_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")
#set(CPACK_PACKAGE_EXECUTABLES "MyExecutable" "My Executable")
include(CPack)

# enable languages
enable_language(C)
enable_language(CXX)
enable_language(Fortran)

# find libraries with cmake modules
find_package(LAPACK)
if(WIN32)
find_package(Boost 1.40.0 REQUIRED COMPONENTS system-mt thread_win32-mt)
else()
find_package(Boost 1.40.0 REQUIRED COMPONENTS system-mt thread-mt)
endif()

find_package (BOOSTNUMERICBINDINGS)
if (NOT BOOSTNUMERICBINDINGS_FOUND)
    build_boostnumericbindings(${BOOSTNUMERICBINDINGS_TAG} ${EP_BASE_DIR} ${EP_INSTALL_PREFIX} ${EP_DATADIR})
endif()

# install data files
install(DIRECTORY "${PROJECT_SOURCE_DIR}/data" DESTINATION share/${PROJECT_NAME} PATTERN "*.git*" EXCLUDE)

# pkgconfig
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/pc.cmake ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}.pc)
install(FILES
	${PROJECT_BINARY_DIR}/${PROJECT_NAME}.pc
	DESTINATION lib/pkgconfig
	)

# project wide flags
include_directories( ${PROJECT_SOURCE_DIR}/src ${PROJECT_BINARY_DIR}/src)

# subdirectories
add_definitions(-DBOOST_THREAD_USE_LIB)
add_subdirectory(src)

if (BUILD_TESTING)
	add_subdirectory(test)
endif ()
