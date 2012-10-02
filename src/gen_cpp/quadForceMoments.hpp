F_b_T_quad(2,0) = -pi^3*rho*batVolt^2*(dutycycle_R+dutycycle_L+dutycycle_F+dutycycle_B)*KV^2*rBlade^4*C(T)/900.0;
F_w_A_quad(0,0) = 0.5*rho*(-4*pi^2*alpha^2*K_cd_cl-Cd0)*s_frame*Vt^2;
F_w_A_quad(1,0) = -1.0*pi*beta*rho*s_frame_side*Vt^2;
F_w_A_quad(2,0) = -1.0*pi*alpha*rho*s_frame*Vt^2;
M_b_T_quad(0,0) = -pi^3*dm*rho*batVolt^2*(dutycycle_R-dutycycle_L)*KV^2*rBlade^4*C(T)/900.0;
M_b_T_quad(1,0) = pi^3*dm*rho*batVolt^2*(dutycycle_F-dutycycle_B)*KV^2*rBlade^4*C(T)/900.0;
M_b_T_quad(2,0) = pi^3*rho*batVolt^2*(dutycycle_R+dutycycle_L-dutycycle_F-dutycycle_B)*KV^2*C(Q)*rBlade^5/900.0;
