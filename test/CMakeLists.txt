include_directories(${PROJECT_SOURCE_DIR}/src ${BOOSTNUMERICBINDINGS_INCLUDE_DIRS} ${Boost_INCLUDE_DIRS})
link_directories(${PROJECT_BINARY_DIR})

if (LAPACK_FOUND)
	add_executable(ins ins.cpp)
	add_test(ins ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/ins)
	target_link_libraries(ins arkmath)
endif (LAPACK_FOUND)
