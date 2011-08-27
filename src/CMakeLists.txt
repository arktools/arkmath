include_directories(${BOOSTNUMERICBINDINGS_INCLUDE_DIRS} ${Boost_INCLUDE_DIRS})

file(GLOB  navigationSources "gen/navigation/*.c*")
file(GLOB  navigationHeaders "gen/navigation/*.h*")

file(GLOB  dynamicsSources "gen/dynamics/*.c*")
file(GLOB  dynamicsHeaders "gen/dynamics/*.h*")

add_library(arkMath SHARED
	${navigationSources}
	${dynamicsSources}
	utilities.cpp
	GpsIns.cpp
	)
add_dependencies(arkMath BOOSTNUMERICBINDINGS)
target_link_libraries(arkMath ${Boost_LIBRARIES} ${LAPACK_LIBRARIES})
set_target_properties(arkMath PROPERTIES VERSION ${LIBRARY_VERSION}
	SOVERSION ${LIBRARY_SOVERSION})

install(TARGETS arkMath DESTINATION lib)

install(FILES
	utilities.hpp
	GpsIns.hpp
	DESTINATION include/arkMath
	)

install(FILES
	${navigationHeaders}
	DESTINATION include/arkMath/gen/navigation
	)

install(FILES
	${dynamicsHeaders}
	DESTINATION include/arkMath/gen/dynamics
	)
