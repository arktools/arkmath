include_directories(${BOOSTNUMERICBINDINGS_INCLUDE_DIRS} ${Boost_INCLUDE_DIRS})

file(GLOB  generalSources "*.c*")
file(GLOB  generalHeaders "*.h*")

file(GLOB  navigationSources "gen/navigation/*.c*")
file(GLOB  navigationHeaders "gen/navigation/*.h*")

file(GLOB  dynamicsSources "gen/dynamics/*.c*")
file(GLOB  dynamicsHeaders "gen/dynamics/*.h*")

add_library(${PROJECT_NAME}
	${navigationSources}
	${dynamicsSources}
	${generalSources}
	)

add_dependencies(${PROJECT_NAME} boost-numeric-bindings)
target_link_libraries(${PROJECT_NAME} ${Boost_LIBRARIES} ${LAPACK_LIBRARIES})
set_target_properties(${PROJECT_NAME} PROPERTIES VERSION ${LIBRARY_VERSION}
	SOVERSION ${LIBRARY_SOVERSION})

install(FILES ${generalHeaders} DESTINATION include/${PROJECT_NAME})
install(FILES ${navigationHeaders} DESTINATION include/${PROJECT_NAME}/gen/navigation)
install(FILES ${dynamicsHeaders} DESTINATION include/${PROJECT_NAME}/gen/dynamics)

install(TARGETS ${PROJECT_NAME} DESTINATION lib EXPORT ${PROJECT_NAME}-targets)
install(EXPORT ${PROJECT_NAME}-targets DESTINATION lib/${PROJECT_NAME})
