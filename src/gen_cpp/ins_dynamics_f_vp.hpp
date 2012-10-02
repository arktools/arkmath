f_vp(0,0) = -Ve*(Ve*tanL/(R0+h)+2*Omega*sinL)+Vd*Vn/(R0+h)+fn;
f_vp(1,0) = -Vn*(-Ve*tanL/(R0+h)-2*Omega*sinL)-Vd*(-Ve/(R0+h)-2*Omega*cosL)+fe;
f_vp(2,0) = -Ve*(Ve/(R0+h)+2*Omega*cosL)-Vn^2/(R0+h)+g+fd;
f_vp(3,0) = Vn/(R0+h);
f_vp(4,0) = Ve/(cosL*(R0+h));
f_vp(5,0) = -Vd;
