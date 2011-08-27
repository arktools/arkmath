R_gps(0,0) = sigVel**2;
R_gps(1,1) = sigVel**2;
R_gps(2,2) = sigVel**2;
R_gps(3,3) = sigPos**2/R**2;
R_gps(4,4) = sigPos**2/(cos(L)**2*R**2);
R_gps(5,5) = sigAlt**2;
