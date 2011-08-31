F_b_T_quad(2,0) = -piPiPi*rho*batVoltBatVolt*(dutycycle_R+dutycycle_L+dutycycle_F+dutycycle_B)*KVKV*rBladeRBladeRBladeRBlade*CT/900.0;
F_w_A_quad(0,0) = 0.5*rho*(-4*piPi*alphaAlpha*K_cd_cl-Cd0)*s_frame*VtVt;
F_w_A_quad(1,0) = -1.0*pi*beta*rho*s_frame_side*VtVt;
F_w_A_quad(2,0) = -1.0*pi*alpha*rho*s_frame*VtVt;
M_b_T_quad(0,0) = -piPiPi*dm*rho*batVoltBatVolt*(dutycycle_R-dutycycle_L)*KVKV*rBladeRBladeRBladeRBlade*CT/900.0;
M_b_T_quad(1,0) = piPiPi*dm*rho*batVoltBatVolt*(dutycycle_F-dutycycle_B)*KVKV*rBladeRBladeRBladeRBlade*CT/900.0;
M_b_T_quad(2,0) = piPiPi*rho*batVoltBatVolt*(dutycycle_R+dutycycle_L-dutycycle_F-dutycycle_B)*KVKV*CQ*rBladeRBladeRBladeRBladeRBlade/900.0;
