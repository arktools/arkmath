f_vp(0,0) = -Ve*(Ve*tanL/R+2*Omega*sinL)+Vd*Vn/R+fn;
f_vp(1,0) = -Vn*(-Ve*tanL/R-2*Omega*sinL)-Vd*(-Ve/R-2*Omega*cosL)+fe;
f_vp(2,0) = -Ve*(Ve/R+2*Omega*cosL)-Vn^2/R+g+fd;
f_vp(3,0) = Vn/R;
f_vp(4,0) = Ve/(cosL*R);
f_vp(5,0) = -Vd;
