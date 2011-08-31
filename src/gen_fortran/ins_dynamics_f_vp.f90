f_vp(1,1) = -Ve*(Ve*tan(L)/R+2*Omega*sin(L))+Vd*Vn/R+(2*b*d+2*a*c)*fz+(2*b*c-2*a*d)*fy+(-d**2-c**2+b**2+a**2)*fx
f_vp(2,1) = -Vn*(-Ve*tan(L)/R-2*Omega*sin(L))-Vd*(-Ve/R-2*Omega*cos(L))+(2*c*d-2*a*b)*fz+(-d**2+c**2-b**2+a**2)*fy+(2*a*d+2*b*c)*fx
f_vp(3,1) = -Ve*(Ve/R+2*Omega*cos(L))-Vn**2/R+g+(d**2-c**2-b**2+a**2)*fz+(2*c*d+2*a*b)*fy+(2*b*d-2*a*c)*fx
f_vp(4,1) = Vn/R
f_vp(5,1) = Ve/(cos(L)*R)
f_vp(6,1) = -Vd
