include_directories(${BOOSTNUMERICBINDINGS_INCLUDE_DIRS} ${Boost_INCLUDE_DIRS})

add_library(arkMath SHARED
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
	DESTINATION include/ark/math
	)
