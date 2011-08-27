include_directories(${BOOSTNUMERICBINDINGS_INCLUDE_DIRS} ${Boost_INCLUDE_DIRS})

file(GLOB  navigationSources "gen/navigation/*.c*")
file(GLOB  navigationHeaders "gen/navigation/*.h*")

file(GLOB  dynamicsSources "gen/dynamics/*.c*")
file(GLOB  dynamicsHeaders "gen/dynamics/*.h*")

add_library(${PROJECT_NAME} SHARED
	${navigationSources}
	${dynamicsSources}
	utilities.cpp
	GpsIns.cpp
	)
add_dependencies(${PROJECT_NAME} BOOSTNUMERICBINDINGS)
target_link_libraries(${PROJECT_NAME} ${Boost_LIBRARIES} ${LAPACK_LIBRARIES})
set_target_properties(${PROJECT_NAME} PROPERTIES VERSION ${LIBRARY_VERSION}
	SOVERSION ${LIBRARY_SOVERSION})

install(TARGETS ${PROJECT_NAME} DESTINATION lib)

install(FILES
	utilities.hpp
	GpsIns.hpp
	DESTINATION include/${PROJECT_NAME}
	)

install(FILES
	${navigationHeaders}
	DESTINATION include/${PROJECT_NAME}/gen/navigation
	)

install(FILES
	${dynamicsHeaders}
	DESTINATION include/${PROJECT_NAME}/gen/dynamics
	)
