f_vp(0,0) = -Ve*(Ve*tanL/(R0+h)+2*Omega*sinL)+Vd*Vn/(R0+h)+(2*b*d+2*a*c)*fz+(2*b*c-2*a*d)*fy+(-dd-cc+bb+aa)*fx;
f_vp(1,0) = -Vn*(-Ve*tanL/(R0+h)-2*Omega*sinL)-Vd*(-Ve/(R0+h)-2*Omega*cosL)+(2*c*d-2*a*b)*fz+(-dd+cc-bb+aa)*fy+(2*a*d+2*b*c)*fx;
f_vp(2,0) = -Ve*(Ve/(R0+h)+2*Omega*cosL)-Vn*Vn/(R0+h)+g+(dd-cc-bb+aa)*fz+(2*c*d+2*a*b)*fy+(2*b*d-2*a*c)*fx;
f_vp(3,0) = Vn/(R0+h);
f_vp(4,0) = Ve/(cosL*(R0+h));
f_vp(5,0) = -Vd;
