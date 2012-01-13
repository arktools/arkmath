include_directories(${BOOSTNUMERICBINDINGS_INCLUDE_DIRS} ${Boost_INCLUDE_DIRS})

file(GLOB  generalSources "*.c*")
file(GLOB  generalHeaders "*.h*")

file(GLOB  gen_cppHeaders "gen_cpp/*.h*")
file(GLOB  gen_fortranHeaders "gen_cpp/*.f*")
file(GLOB  gen_sciHeaders "gen_sci/*.sci")

add_library(${PROJECT_NAME}
	${generalSources}
	)

add_dependencies(${PROJECT_NAME} boost-numeric-bindings)
target_link_libraries(${PROJECT_NAME} ${Boost_LIBRARIES} ${LAPACK_LIBRARIES} gfortran)
set_target_properties(${PROJECT_NAME} PROPERTIES VERSION ${LIBRARY_VERSION}
	SOVERSION ${LIBRARY_SOVERSION})

install(FILES ${generalHeaders} DESTINATION include/${PROJECT_NAME})
install(FILES ${gen_cppHeaders} DESTINATION include/${PROJECT_NAME}/gen_cpp)
install(FILES ${gen_fortranHeaders} DESTINATION include/${PROJECT_NAME}/gen_fortran)
install(FILES ${gen_sciHeaders} DESTINATION include/${PROJECT_NAME}/gen_sciHeaders)

install(TARGETS ${PROJECT_NAME} DESTINATION lib EXPORT ${PROJECT_NAME}-targets)
install(EXPORT ${PROJECT_NAME}-targets DESTINATION lib/${PROJECT_NAME})
