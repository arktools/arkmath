F_wind_quad(0,0) = -(4*pi^2*alpha^2*rho*K_cd_cl+rho*Cd0)*s_frame*Vt/m;
F_wind_quad(0,1) = -((pi^3*cosAlpha*cosBeta*rho*batVolt^2*dutycycle_R+pi^3*cosAlpha*cosBeta*rho*batVolt^2*dutycycle_L+pi^3*cosAlpha*cosBeta*rho*batVolt^2*dutycycle_F+pi^3*cosAlpha*cosBeta*rho*batVolt^2*dutycycle_B)*KV^2*rBlade^4*C(T)+3600*pi^2*alpha*rho*K_cd_cl*s_frame*Vt^2+(-900*sinAlpha*cosBeta*sinTheta-900*cosPhi*cosAlpha*cosBeta*cosTheta)*g*m)/m/900.0;
F_wind_quad(0,2) = ((-sinPhi*sinBeta-cosPhi*sinAlpha*cosBeta)*sinTheta-cosAlpha*cosBeta*cosTheta)*g;
F_wind_quad(0,4) = ((pi^3*sinAlpha*sinBeta*rho*batVolt^2*dutycycle_R+pi^3*sinAlpha*sinBeta*rho*batVolt^2*dutycycle_L+pi^3*sinAlpha*sinBeta*rho*batVolt^2*dutycycle_F+pi^3*sinAlpha*sinBeta*rho*batVolt^2*dutycycle_B)*KV^2*rBlade^4*C(T)+(900*cosAlpha*sinBeta*sinTheta+(900*sinPhi*cosBeta-900*cosPhi*sinAlpha*sinBeta)*cosTheta)*g*m)/m/900.0;
F_wind_quad(0,5) = (cosPhi*sinBeta-sinPhi*sinAlpha*cosBeta)*cosTheta*g;
F_wind_quad(1,10) = -pi^3*sinAlpha*cosBeta*rho*batVolt^2*KV^2*rBlade^4*C(T)/m/900.0;
F_wind_quad(1,11) = -pi^3*sinAlpha*cosBeta*rho*batVolt^2*KV^2*rBlade^4*C(T)/m/900.0;
F_wind_quad(1,12) = -pi^3*sinAlpha*cosBeta*rho*batVolt^2*KV^2*rBlade^4*C(T)/m/900.0;
F_wind_quad(1,13) = -pi^3*sinAlpha*cosBeta*rho*batVolt^2*KV^2*rBlade^4*C(T)/m/900.0;
F_wind_quad(1,0) = ((pi^3*cosAlpha*rho*batVolt^2*dutycycle_R+pi^3*cosAlpha*rho*batVolt^2*dutycycle_L+pi^3*cosAlpha*rho*batVolt^2*dutycycle_F+pi^3*cosAlpha*rho*batVolt^2*dutycycle_B)*KV^2*rBlade^4*C(T)-900*pi*alpha*rho*s_frame*Vt^2+(-900*sinAlpha*sinTheta-900*cosPhi*cosAlpha*cosTheta)*g*m)/(cosBeta*m*Vt^2)/900.0;
F_wind_quad(1,1) = ((pi^3*sinAlpha*rho*batVolt^2*dutycycle_R+pi^3*sinAlpha*rho*batVolt^2*dutycycle_L+pi^3*sinAlpha*rho*batVolt^2*dutycycle_F+pi^3*sinAlpha*rho*batVolt^2*dutycycle_B)*KV^2*rBlade^4*C(T)-900*pi*rho*s_frame*Vt^2+(900*cosAlpha*sinTheta-900*cosPhi*sinAlpha*cosTheta)*g*m)/(cosBeta*m*Vt)/900.0;
F_wind_quad(1,2) = -(cosPhi*cosAlpha*sinTheta-sinAlpha*cosTheta)*g/(cosBeta*Vt);
F_wind_quad(1,4) = -((pi^3*cosAlpha*sinBeta*rho*batVolt^2*dutycycle_R+pi^3*cosAlpha*sinBeta*rho*batVolt^2*dutycycle_L+pi^3*cosAlpha*sinBeta*rho*batVolt^2*dutycycle_F+pi^3*cosAlpha*sinBeta*rho*batVolt^2*dutycycle_B)*KV^2*rBlade^4*C(T)+900*pi*alpha*sinBeta*rho*s_frame*Vt^2+(-900*sinAlpha*sinBeta*sinTheta-900*cosPhi*cosAlpha*sinBeta*cosTheta)*g*m)/(cosBeta^2*m*Vt)/900.0;
F_wind_quad(1,5) = -sinPhi*cosAlpha*cosTheta*g/(cosBeta*Vt);
F_wind_quad(2,10) = -pi^3*cosAlpha*rho*batVolt^2*KV^2*rBlade^4*C(T)/(cosBeta*m*Vt)/900.0;
F_wind_quad(2,11) = -pi^3*cosAlpha*rho*batVolt^2*KV^2*rBlade^4*C(T)/(cosBeta*m*Vt)/900.0;
F_wind_quad(2,12) = -pi^3*cosAlpha*rho*batVolt^2*KV^2*rBlade^4*C(T)/(cosBeta*m*Vt)/900.0;
F_wind_quad(2,13) = -pi^3*cosAlpha*rho*batVolt^2*KV^2*rBlade^4*C(T)/(cosBeta*m*Vt)/900.0;
F_wind_quad(2,3) = cosPhi;
F_wind_quad(2,5) = -cosPhi*wz-sinPhi*wy;
F_wind_quad(2,8) = -sinPhi;
F_wind_quad(3,6) = (Jz-Jx)*wz/Jy;
F_wind_quad(3,8) = (Jz-Jx)*wx/Jy;
F_wind_quad(4,12) = pi^3*dm*rho*batVolt^2*KV^2*rBlade^4*C(T)/Jy/900.0;
F_wind_quad(4,13) = -pi^3*dm*rho*batVolt^2*KV^2*rBlade^4*C(T)/Jy/900.0;
F_wind_quad(4,0) = -((pi^3*sinAlpha*sinBeta*rho*batVolt^2*dutycycle_R+pi^3*sinAlpha*sinBeta*rho*batVolt^2*dutycycle_L+pi^3*sinAlpha*sinBeta*rho*batVolt^2*dutycycle_F+pi^3*sinAlpha*sinBeta*rho*batVolt^2*dutycycle_B)*KV^2*rBlade^4*C(T)+900*pi*beta*rho*s_frame_side*Vt^2+(900*cosAlpha*sinBeta*sinTheta+(900*sinPhi*cosBeta-900*cosPhi*sinAlpha*sinBeta)*cosTheta)*g*m)/(m*Vt^2)/900.0;
F_wind_quad(4,1) = ((pi^3*cosAlpha*sinBeta*rho*batVolt^2*dutycycle_R+pi^3*cosAlpha*sinBeta*rho*batVolt^2*dutycycle_L+pi^3*cosAlpha*sinBeta*rho*batVolt^2*dutycycle_F+pi^3*cosAlpha*sinBeta*rho*batVolt^2*dutycycle_B)*KV^2*rBlade^4*C(T)+(-900*sinAlpha*sinBeta*sinTheta-900*cosPhi*cosAlpha*sinBeta*cosTheta)*g*m)/(m*Vt)/900.0;
F_wind_quad(4,2) = ((cosPhi*sinAlpha*sinBeta-sinPhi*cosBeta)*sinTheta+cosAlpha*sinBeta*cosTheta)*g/Vt;
F_wind_quad(4,4) = ((pi^3*sinAlpha*cosBeta*rho*batVolt^2*dutycycle_R+pi^3*sinAlpha*cosBeta*rho*batVolt^2*dutycycle_L+pi^3*sinAlpha*cosBeta*rho*batVolt^2*dutycycle_F+pi^3*sinAlpha*cosBeta*rho*batVolt^2*dutycycle_B)*KV^2*rBlade^4*C(T)-900*pi*rho*s_frame_side*Vt^2+(900*cosAlpha*cosBeta*sinTheta+(-900*sinPhi*sinBeta-900*cosPhi*sinAlpha*cosBeta)*cosTheta)*g*m)/(m*Vt)/900.0;
F_wind_quad(4,5) = (sinPhi*sinAlpha*sinBeta+cosPhi*cosBeta)*cosTheta*g/Vt;
F_wind_quad(5,10) = pi^3*sinAlpha*sinBeta*rho*batVolt^2*KV^2*rBlade^4*C(T)/(m*Vt)/900.0;
F_wind_quad(5,11) = pi^3*sinAlpha*sinBeta*rho*batVolt^2*KV^2*rBlade^4*C(T)/(m*Vt)/900.0;
F_wind_quad(5,12) = pi^3*sinAlpha*sinBeta*rho*batVolt^2*KV^2*rBlade^4*C(T)/(m*Vt)/900.0;
F_wind_quad(5,13) = pi^3*sinAlpha*sinBeta*rho*batVolt^2*KV^2*rBlade^4*C(T)/(m*Vt)/900.0;
F_wind_quad(5,2) = (cosPhi*wz+sinPhi*wy)/cosTheta^2;
F_wind_quad(5,3) = sinPhi*sinTheta/cosTheta;
F_wind_quad(5,5) = -(sinPhi*sinTheta*wz-cosPhi*sinTheta*wy)/cosTheta;
F_wind_quad(5,6) = 1;
F_wind_quad(5,8) = cosPhi*sinTheta/cosTheta;
F_wind_quad(6,3) = -(Jz-Jy)*wz/Jx;
F_wind_quad(6,8) = -(Jz-Jy)*wy/Jx;
F_wind_quad(7,10) = pi^3*dm*rho*batVolt^2*KV^2*rBlade^4*C(T)/Jx/900.0;
F_wind_quad(7,11) = -pi^3*dm*rho*batVolt^2*KV^2*rBlade^4*C(T)/Jx/900.0;
F_wind_quad(7,2) = (cosPhi*sinTheta*wz+sinPhi*sinTheta*wy)/cosTheta^2;
F_wind_quad(7,3) = sinPhi/cosTheta;
F_wind_quad(7,5) = -(sinPhi*wz-cosPhi*wy)/cosTheta;
F_wind_quad(7,8) = cosPhi/cosTheta;
F_wind_quad(8,3) = -(Jy-Jx)*wx/Jz;
F_wind_quad(8,6) = -(Jy-Jx)*wy/Jz;
F_wind_quad(9,10) = pi^3*rho*batVolt^2*KV^2*C(Q)*rBlade^5/Jz/900.0;
F_wind_quad(9,11) = pi^3*rho*batVolt^2*KV^2*C(Q)*rBlade^5/Jz/900.0;
F_wind_quad(9,12) = -pi^3*rho*batVolt^2*KV^2*C(Q)*rBlade^5/Jz/900.0;
F_wind_quad(9,13) = -pi^3*rho*batVolt^2*KV^2*C(Q)*rBlade^5/Jz/900.0;
F_wind_quad(10,10) = -tau(motor);
F_wind_quad(11,11) = -tau(motor);
F_wind_quad(12,12) = -tau(motor);
F_wind_quad(13,13) = -tau(motor);
G_wind_quad(10,1) = tau(motor)/4.0;
G_wind_quad(10,3) = tau(motor)/2.0;
G_wind_quad(10,4) = tau(motor)/4.0;
G_wind_quad(11,1) = tau(motor)/4.0;
G_wind_quad(11,3) = -tau(motor)/2.0;
G_wind_quad(11,4) = tau(motor)/4.0;
G_wind_quad(12,1) = tau(motor)/4.0;
G_wind_quad(12,2) = tau(motor)/2.0;
G_wind_quad(12,4) = -tau(motor)/4.0;
G_wind_quad(13,1) = tau(motor)/4.0;
G_wind_quad(13,2) = -tau(motor)/2.0;
G_wind_quad(13,4) = -tau(motor)/4.0;
C_wind_quad(0,0) = 1;
C_wind_quad(1,2) = 1;
C_wind_quad(2,3) = 1;
C_wind_quad(4,5) = 1;
C_wind_quad(5,6) = 1;
C_wind_quad(6,7) = 1;
C_wind_quad(7,8) = 1;
