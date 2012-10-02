f_vp(1,1) = -Ve*(Ve*tan(L)/(R0+h)+2*Omega*sin(L))+Vd*Vn/(R0+h)+fn
f_vp(2,1) = -Vn*(-Ve*tan(L)/(R0+h)-2*Omega*sin(L))-Vd*(-Ve/(R0+h)-2*Omega*cos(L))+fe
f_vp(3,1) = -Ve*(Ve/(R0+h)+2*Omega*cos(L))-Vn**2/(R0+h)+g+fd
f_vp(4,1) = Vn/(R0+h)
f_vp(5,1) = Ve/(cos(L)*(R0+h))
f_vp(6,1) = -Vd
