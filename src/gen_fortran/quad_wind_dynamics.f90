F_wind_quad(1,1) = -(4*%pi**2*%alpha**2*%rho*K_cd_cl+%rho*Cd0)*s_frame*Vt/m
F_wind_quad(1,2) = -((%pi**3*cos(%alpha)*cos(%beta)*rho*batVolt**2*dutycycle_R+%pi**3*cos(%alpha)*cos(%beta)*rho*batVolt**2*dutycycle_L+%pi**3*cos(%alpha)*cos(%beta)*rho*batVolt**2*dutycycle_F+%pi**3*cos(%alpha)*cos(%beta)*rho*batVolt**2*dutycycle_B)*KV**2*rBlade**4*C(T)+3600*%pi**2*%alpha*%rho*K_cd_cl*s_frame*Vt**2+(-900*sin(%alpha)*cos(%beta)*sin(%theta)-900*cos(%phi)*cos(%alpha)*cos(%beta)*cos(%theta))*g*m)/m/900.0
F_wind_quad(1,3) = ((-sin(%phi)*sin(%beta)-cos(%phi)*sin(%alpha)*cos(%beta))*sin(%theta)-cos(%alpha)*cos(%beta)*cos(%theta))*g
F_wind_quad(1,4) = 0
F_wind_quad(1,5) = ((%pi**3*sin(%alpha)*sin(%beta)*rho*batVolt**2*dutycycle_R+%pi**3*sin(%alpha)*sin(%beta)*rho*batVolt**2*dutycycle_L+%pi**3*sin(%alpha)*sin(%beta)*rho*batVolt**2*dutycycle_F+%pi**3*sin(%alpha)*sin(%beta)*rho*batVolt**2*dutycycle_B)*KV**2*rBlade**4*C(T)+(900*cos(%alpha)*sin(%beta)*sin(%theta)+(900*sin(%phi)*cos(%beta)-900*cos(%phi)*sin(%alpha)*sin(%beta))*cos(%theta))*g*m)/m/900.0
F_wind_quad(1,6) = (cos(%phi)*sin(%beta)-sin(%phi)*sin(%alpha)*cos(%beta))*cos(%theta)*g
F_wind_quad(1,7) = 0
F_wind_quad(1,8) = 0
F_wind_quad(1,9) = 0
F_wind_quad(1,10) = -%pi**3*sin(%alpha)*cos(%beta)*rho*batVolt**2*KV**2*rBlade**4*C(T)/m/900.0
F_wind_quad(1,11) = -%pi**3*sin(%alpha)*cos(%beta)*rho*batVolt**2*KV**2*rBlade**4*C(T)/m/900.0
F_wind_quad(1,12) = -%pi**3*sin(%alpha)*cos(%beta)*rho*batVolt**2*KV**2*rBlade**4*C(T)/m/900.0
F_wind_quad(1,13) = -%pi**3*sin(%alpha)*cos(%beta)*rho*batVolt**2*KV**2*rBlade**4*C(T)/m/900.0
F_wind_quad(2,1) = ((%pi**3*cos(%alpha)*rho*batVolt**2*dutycycle_R+%pi**3*cos(%alpha)*rho*batVolt**2*dutycycle_L+%pi**3*cos(%alpha)*rho*batVolt**2*dutycycle_F+%pi**3*cos(%alpha)*rho*batVolt**2*dutycycle_B)*KV**2*rBlade**4*C(T)-900*%pi*%alpha*%rho*s_frame*Vt**2+(-900*sin(%alpha)*sin(%theta)-900*cos(%phi)*cos(%alpha)*cos(%theta))*g*m)/(cos(%beta)*m*Vt**2)/900.0
F_wind_quad(2,2) = ((%pi**3*sin(%alpha)*rho*batVolt**2*dutycycle_R+%pi**3*sin(%alpha)*rho*batVolt**2*dutycycle_L+%pi**3*sin(%alpha)*rho*batVolt**2*dutycycle_F+%pi**3*sin(%alpha)*rho*batVolt**2*dutycycle_B)*KV**2*rBlade**4*C(T)-900*%pi*%rho*s_frame*Vt**2+(900*cos(%alpha)*sin(%theta)-900*cos(%phi)*sin(%alpha)*cos(%theta))*g*m)/(cos(%beta)*m*Vt)/900.0
F_wind_quad(2,3) = -(cos(%phi)*cos(%alpha)*sin(%theta)-sin(%alpha)*cos(%theta))*g/(cos(%beta)*Vt)
F_wind_quad(2,4) = 0
F_wind_quad(2,5) = -((%pi**3*cos(%alpha)*sin(%beta)*rho*batVolt**2*dutycycle_R+%pi**3*cos(%alpha)*sin(%beta)*rho*batVolt**2*dutycycle_L+%pi**3*cos(%alpha)*sin(%beta)*rho*batVolt**2*dutycycle_F+%pi**3*cos(%alpha)*sin(%beta)*rho*batVolt**2*dutycycle_B)*KV**2*rBlade**4*C(T)+900*%pi*%alpha*sin(%beta)*%rho*s_frame*Vt**2+(-900*sin(%alpha)*sin(%beta)*sin(%theta)-900*cos(%phi)*cos(%alpha)*sin(%beta)*cos(%theta))*g*m)/(cos(%beta)**2*m*Vt)/900.0
F_wind_quad(2,6) = -sin(%phi)*cos(%alpha)*cos(%theta)*g/(cos(%beta)*Vt)
F_wind_quad(2,7) = 0
F_wind_quad(2,8) = 0
F_wind_quad(2,9) = 0
F_wind_quad(2,10) = -%pi**3*cos(%alpha)*rho*batVolt**2*KV**2*rBlade**4*C(T)/(cos(%beta)*m*Vt)/900.0
F_wind_quad(2,11) = -%pi**3*cos(%alpha)*rho*batVolt**2*KV**2*rBlade**4*C(T)/(cos(%beta)*m*Vt)/900.0
F_wind_quad(2,12) = -%pi**3*cos(%alpha)*rho*batVolt**2*KV**2*rBlade**4*C(T)/(cos(%beta)*m*Vt)/900.0
F_wind_quad(2,13) = -%pi**3*cos(%alpha)*rho*batVolt**2*KV**2*rBlade**4*C(T)/(cos(%beta)*m*Vt)/900.0
F_wind_quad(3,1) = 0
F_wind_quad(3,2) = 0
F_wind_quad(3,3) = 0
F_wind_quad(3,4) = cos(%phi)
F_wind_quad(3,5) = 0
F_wind_quad(3,6) = -cos(%phi)*wz-sin(%phi)*wy
F_wind_quad(3,7) = 0
F_wind_quad(3,8) = 0
F_wind_quad(3,9) = -sin(%phi)
F_wind_quad(3,10) = 0
F_wind_quad(3,11) = 0
F_wind_quad(3,12) = 0
F_wind_quad(3,13) = 0
F_wind_quad(4,1) = 0
F_wind_quad(4,2) = 0
F_wind_quad(4,3) = 0
F_wind_quad(4,4) = 0
F_wind_quad(4,5) = 0
F_wind_quad(4,6) = 0
F_wind_quad(4,7) = (Jz-Jx)*wz/Jy
F_wind_quad(4,8) = 0
F_wind_quad(4,9) = (Jz-Jx)*wx/Jy
F_wind_quad(4,10) = 0
F_wind_quad(4,11) = 0
F_wind_quad(4,12) = %pi**3*dm*rho*batVolt**2*KV**2*rBlade**4*C(T)/Jy/900.0
F_wind_quad(4,13) = -%pi**3*dm*rho*batVolt**2*KV**2*rBlade**4*C(T)/Jy/900.0
F_wind_quad(5,1) = -((%pi**3*sin(%alpha)*sin(%beta)*rho*batVolt**2*dutycycle_R+%pi**3*sin(%alpha)*sin(%beta)*rho*batVolt**2*dutycycle_L+%pi**3*sin(%alpha)*sin(%beta)*rho*batVolt**2*dutycycle_F+%pi**3*sin(%alpha)*sin(%beta)*rho*batVolt**2*dutycycle_B)*KV**2*rBlade**4*C(T)+900*%pi*%beta*%rho*s_frame_side*Vt**2+(900*cos(%alpha)*sin(%beta)*sin(%theta)+(900*sin(%phi)*cos(%beta)-900*cos(%phi)*sin(%alpha)*sin(%beta))*cos(%theta))*g*m)/(m*Vt**2)/900.0
F_wind_quad(5,2) = ((%pi**3*cos(%alpha)*sin(%beta)*rho*batVolt**2*dutycycle_R+%pi**3*cos(%alpha)*sin(%beta)*rho*batVolt**2*dutycycle_L+%pi**3*cos(%alpha)*sin(%beta)*rho*batVolt**2*dutycycle_F+%pi**3*cos(%alpha)*sin(%beta)*rho*batVolt**2*dutycycle_B)*KV**2*rBlade**4*C(T)+(-900*sin(%alpha)*sin(%beta)*sin(%theta)-900*cos(%phi)*cos(%alpha)*sin(%beta)*cos(%theta))*g*m)/(m*Vt)/900.0
F_wind_quad(5,3) = ((cos(%phi)*sin(%alpha)*sin(%beta)-sin(%phi)*cos(%beta))*sin(%theta)+cos(%alpha)*sin(%beta)*cos(%theta))*g/Vt
F_wind_quad(5,4) = 0
F_wind_quad(5,5) = ((%pi**3*sin(%alpha)*cos(%beta)*rho*batVolt**2*dutycycle_R+%pi**3*sin(%alpha)*cos(%beta)*rho*batVolt**2*dutycycle_L+%pi**3*sin(%alpha)*cos(%beta)*rho*batVolt**2*dutycycle_F+%pi**3*sin(%alpha)*cos(%beta)*rho*batVolt**2*dutycycle_B)*KV**2*rBlade**4*C(T)-900*%pi*%rho*s_frame_side*Vt**2+(900*cos(%alpha)*cos(%beta)*sin(%theta)+(-900*sin(%phi)*sin(%beta)-900*cos(%phi)*sin(%alpha)*cos(%beta))*cos(%theta))*g*m)/(m*Vt)/900.0
F_wind_quad(5,6) = (sin(%phi)*sin(%alpha)*sin(%beta)+cos(%phi)*cos(%beta))*cos(%theta)*g/Vt
F_wind_quad(5,7) = 0
F_wind_quad(5,8) = 0
F_wind_quad(5,9) = 0
F_wind_quad(5,10) = %pi**3*sin(%alpha)*sin(%beta)*rho*batVolt**2*KV**2*rBlade**4*C(T)/(m*Vt)/900.0
F_wind_quad(5,11) = %pi**3*sin(%alpha)*sin(%beta)*rho*batVolt**2*KV**2*rBlade**4*C(T)/(m*Vt)/900.0
F_wind_quad(5,12) = %pi**3*sin(%alpha)*sin(%beta)*rho*batVolt**2*KV**2*rBlade**4*C(T)/(m*Vt)/900.0
F_wind_quad(5,13) = %pi**3*sin(%alpha)*sin(%beta)*rho*batVolt**2*KV**2*rBlade**4*C(T)/(m*Vt)/900.0
F_wind_quad(6,1) = 0
F_wind_quad(6,2) = 0
F_wind_quad(6,3) = (cos(%phi)*wz+sin(%phi)*wy)/cos(%theta)**2
F_wind_quad(6,4) = sin(%phi)*sin(%theta)/cos(%theta)
F_wind_quad(6,5) = 0
F_wind_quad(6,6) = -(sin(%phi)*sin(%theta)*wz-cos(%phi)*sin(%theta)*wy)/cos(%theta)
F_wind_quad(6,7) = 1
F_wind_quad(6,8) = 0
F_wind_quad(6,9) = cos(%phi)*sin(%theta)/cos(%theta)
F_wind_quad(6,10) = 0
F_wind_quad(6,11) = 0
F_wind_quad(6,12) = 0
F_wind_quad(6,13) = 0
F_wind_quad(7,1) = 0
F_wind_quad(7,2) = 0
F_wind_quad(7,3) = 0
F_wind_quad(7,4) = -(Jz-Jy)*wz/Jx
F_wind_quad(7,5) = 0
F_wind_quad(7,6) = 0
F_wind_quad(7,7) = 0
F_wind_quad(7,8) = 0
F_wind_quad(7,9) = -(Jz-Jy)*wy/Jx
F_wind_quad(7,10) = %pi**3*dm*rho*batVolt**2*KV**2*rBlade**4*C(T)/Jx/900.0
F_wind_quad(7,11) = -%pi**3*dm*rho*batVolt**2*KV**2*rBlade**4*C(T)/Jx/900.0
F_wind_quad(7,12) = 0
F_wind_quad(7,13) = 0
F_wind_quad(8,1) = 0
F_wind_quad(8,2) = 0
F_wind_quad(8,3) = (cos(%phi)*sin(%theta)*wz+sin(%phi)*sin(%theta)*wy)/cos(%theta)**2
F_wind_quad(8,4) = sin(%phi)/cos(%theta)
F_wind_quad(8,5) = 0
F_wind_quad(8,6) = -(sin(%phi)*wz-cos(%phi)*wy)/cos(%theta)
F_wind_quad(8,7) = 0
F_wind_quad(8,8) = 0
F_wind_quad(8,9) = cos(%phi)/cos(%theta)
F_wind_quad(8,10) = 0
F_wind_quad(8,11) = 0
F_wind_quad(8,12) = 0
F_wind_quad(8,13) = 0
F_wind_quad(9,1) = 0
F_wind_quad(9,2) = 0
F_wind_quad(9,3) = 0
F_wind_quad(9,4) = -(Jy-Jx)*wx/Jz
F_wind_quad(9,5) = 0
F_wind_quad(9,6) = 0
F_wind_quad(9,7) = -(Jy-Jx)*wy/Jz
F_wind_quad(9,8) = 0
F_wind_quad(9,9) = 0
F_wind_quad(9,10) = %pi**3*rho*batVolt**2*KV**2*C(Q)*rBlade**5/Jz/900.0
F_wind_quad(9,11) = %pi**3*rho*batVolt**2*KV**2*C(Q)*rBlade**5/Jz/900.0
F_wind_quad(9,12) = -%pi**3*rho*batVolt**2*KV**2*C(Q)*rBlade**5/Jz/900.0
F_wind_quad(9,13) = -%pi**3*rho*batVolt**2*KV**2*C(Q)*rBlade**5/Jz/900.0
F_wind_quad(10,1) = 0
F_wind_quad(10,2) = 0
F_wind_quad(10,3) = 0
F_wind_quad(10,4) = 0
F_wind_quad(10,5) = 0
F_wind_quad(10,6) = 0
F_wind_quad(10,7) = 0
F_wind_quad(10,8) = 0
F_wind_quad(10,9) = 0
F_wind_quad(10,10) = -%tau(motor)
F_wind_quad(10,11) = 0
F_wind_quad(10,12) = 0
F_wind_quad(10,13) = 0
F_wind_quad(11,1) = 0
F_wind_quad(11,2) = 0
F_wind_quad(11,3) = 0
F_wind_quad(11,4) = 0
F_wind_quad(11,5) = 0
F_wind_quad(11,6) = 0
F_wind_quad(11,7) = 0
F_wind_quad(11,8) = 0
F_wind_quad(11,9) = 0
F_wind_quad(11,10) = 0
F_wind_quad(11,11) = -%tau(motor)
F_wind_quad(11,12) = 0
F_wind_quad(11,13) = 0
F_wind_quad(12,1) = 0
F_wind_quad(12,2) = 0
F_wind_quad(12,3) = 0
F_wind_quad(12,4) = 0
F_wind_quad(12,5) = 0
F_wind_quad(12,6) = 0
F_wind_quad(12,7) = 0
F_wind_quad(12,8) = 0
F_wind_quad(12,9) = 0
F_wind_quad(12,10) = 0
F_wind_quad(12,11) = 0
F_wind_quad(12,12) = -%tau(motor)
F_wind_quad(12,13) = 0
F_wind_quad(13,1) = 0
F_wind_quad(13,2) = 0
F_wind_quad(13,3) = 0
F_wind_quad(13,4) = 0
F_wind_quad(13,5) = 0
F_wind_quad(13,6) = 0
F_wind_quad(13,7) = 0
F_wind_quad(13,8) = 0
F_wind_quad(13,9) = 0
F_wind_quad(13,10) = 0
F_wind_quad(13,11) = 0
F_wind_quad(13,12) = 0
F_wind_quad(13,13) = -%tau(motor)
G_wind_quad(1,1) = 0
G_wind_quad(1,2) = 0
G_wind_quad(1,3) = 0
G_wind_quad(1,4) = 0
G_wind_quad(2,1) = 0
G_wind_quad(2,2) = 0
G_wind_quad(2,3) = 0
G_wind_quad(2,4) = 0
G_wind_quad(3,1) = 0
G_wind_quad(3,2) = 0
G_wind_quad(3,3) = 0
G_wind_quad(3,4) = 0
G_wind_quad(4,1) = 0
G_wind_quad(4,2) = 0
G_wind_quad(4,3) = 0
G_wind_quad(4,4) = 0
G_wind_quad(5,1) = 0
G_wind_quad(5,2) = 0
G_wind_quad(5,3) = 0
G_wind_quad(5,4) = 0
G_wind_quad(6,1) = 0
G_wind_quad(6,2) = 0
G_wind_quad(6,3) = 0
G_wind_quad(6,4) = 0
G_wind_quad(7,1) = 0
G_wind_quad(7,2) = 0
G_wind_quad(7,3) = 0
G_wind_quad(7,4) = 0
G_wind_quad(8,1) = 0
G_wind_quad(8,2) = 0
G_wind_quad(8,3) = 0
G_wind_quad(8,4) = 0
G_wind_quad(9,1) = 0
G_wind_quad(9,2) = 0
G_wind_quad(9,3) = 0
G_wind_quad(9,4) = 0
G_wind_quad(10,1) = %tau(motor)/4.0
G_wind_quad(10,2) = 0
G_wind_quad(10,3) = %tau(motor)/2.0
G_wind_quad(10,4) = %tau(motor)/4.0
G_wind_quad(11,1) = %tau(motor)/4.0
G_wind_quad(11,2) = 0
G_wind_quad(11,3) = -%tau(motor)/2.0
G_wind_quad(11,4) = %tau(motor)/4.0
G_wind_quad(12,1) = %tau(motor)/4.0
G_wind_quad(12,2) = %tau(motor)/2.0
G_wind_quad(12,3) = 0
G_wind_quad(12,4) = -%tau(motor)/4.0
G_wind_quad(13,1) = %tau(motor)/4.0
G_wind_quad(13,2) = -%tau(motor)/2.0
G_wind_quad(13,3) = 0
G_wind_quad(13,4) = -%tau(motor)/4.0
C_wind_quad(1,1) = 1
C_wind_quad(1,2) = 0
C_wind_quad(1,3) = 0
C_wind_quad(1,4) = 0
C_wind_quad(1,5) = 0
C_wind_quad(1,6) = 0
C_wind_quad(1,7) = 0
C_wind_quad(1,8) = 0
C_wind_quad(1,9) = 0
C_wind_quad(1,10) = 0
C_wind_quad(1,11) = 0
C_wind_quad(1,12) = 0
C_wind_quad(1,13) = 0
C_wind_quad(2,1) = 0
C_wind_quad(2,2) = 0
C_wind_quad(2,3) = 1
C_wind_quad(2,4) = 0
C_wind_quad(2,5) = 0
C_wind_quad(2,6) = 0
C_wind_quad(2,7) = 0
C_wind_quad(2,8) = 0
C_wind_quad(2,9) = 0
C_wind_quad(2,10) = 0
C_wind_quad(2,11) = 0
C_wind_quad(2,12) = 0
C_wind_quad(2,13) = 0
C_wind_quad(3,1) = 0
C_wind_quad(3,2) = 0
C_wind_quad(3,3) = 0
C_wind_quad(3,4) = 1
C_wind_quad(3,5) = 0
C_wind_quad(3,6) = 0
C_wind_quad(3,7) = 0
C_wind_quad(3,8) = 0
C_wind_quad(3,9) = 0
C_wind_quad(3,10) = 0
C_wind_quad(3,11) = 0
C_wind_quad(3,12) = 0
C_wind_quad(3,13) = 0
C_wind_quad(4,1) = 0
C_wind_quad(4,2) = 0
C_wind_quad(4,3) = 0
C_wind_quad(4,4) = 0
C_wind_quad(4,5) = 0
C_wind_quad(4,6) = 0
C_wind_quad(4,7) = 0
C_wind_quad(4,8) = 0
C_wind_quad(4,9) = 0
C_wind_quad(4,10) = 0
C_wind_quad(4,11) = 0
C_wind_quad(4,12) = 0
C_wind_quad(4,13) = 0
C_wind_quad(5,1) = 0
C_wind_quad(5,2) = 0
C_wind_quad(5,3) = 0
C_wind_quad(5,4) = 0
C_wind_quad(5,5) = 0
C_wind_quad(5,6) = 1
C_wind_quad(5,7) = 0
C_wind_quad(5,8) = 0
C_wind_quad(5,9) = 0
C_wind_quad(5,10) = 0
C_wind_quad(5,11) = 0
C_wind_quad(5,12) = 0
C_wind_quad(5,13) = 0
C_wind_quad(6,1) = 0
C_wind_quad(6,2) = 0
C_wind_quad(6,3) = 0
C_wind_quad(6,4) = 0
C_wind_quad(6,5) = 0
C_wind_quad(6,6) = 0
C_wind_quad(6,7) = 1
C_wind_quad(6,8) = 0
C_wind_quad(6,9) = 0
C_wind_quad(6,10) = 0
C_wind_quad(6,11) = 0
C_wind_quad(6,12) = 0
C_wind_quad(6,13) = 0
C_wind_quad(7,1) = 0
C_wind_quad(7,2) = 0
C_wind_quad(7,3) = 0
C_wind_quad(7,4) = 0
C_wind_quad(7,5) = 0
C_wind_quad(7,6) = 0
C_wind_quad(7,7) = 0
C_wind_quad(7,8) = 1
C_wind_quad(7,9) = 0
C_wind_quad(7,10) = 0
C_wind_quad(7,11) = 0
C_wind_quad(7,12) = 0
C_wind_quad(7,13) = 0
C_wind_quad(8,1) = 0
C_wind_quad(8,2) = 0
C_wind_quad(8,3) = 0
C_wind_quad(8,4) = 0
C_wind_quad(8,5) = 0
C_wind_quad(8,6) = 0
C_wind_quad(8,7) = 0
C_wind_quad(8,8) = 0
C_wind_quad(8,9) = 1
C_wind_quad(8,10) = 0
C_wind_quad(8,11) = 0
C_wind_quad(8,12) = 0
C_wind_quad(8,13) = 0
D_wind_quad(1,1) = 0
D_wind_quad(1,2) = 0
D_wind_quad(1,3) = 0
D_wind_quad(1,4) = 0
D_wind_quad(2,1) = 0
D_wind_quad(2,2) = 0
D_wind_quad(2,3) = 0
D_wind_quad(2,4) = 0
D_wind_quad(3,1) = 0
D_wind_quad(3,2) = 0
D_wind_quad(3,3) = 0
D_wind_quad(3,4) = 0
D_wind_quad(4,1) = 0
D_wind_quad(4,2) = 0
D_wind_quad(4,3) = 0
D_wind_quad(4,4) = 0
D_wind_quad(5,1) = 0
D_wind_quad(5,2) = 0
D_wind_quad(5,3) = 0
D_wind_quad(5,4) = 0
D_wind_quad(6,1) = 0
D_wind_quad(6,2) = 0
D_wind_quad(6,3) = 0
D_wind_quad(6,4) = 0
D_wind_quad(7,1) = 0
D_wind_quad(7,2) = 0
D_wind_quad(7,3) = 0
D_wind_quad(7,4) = 0
D_wind_quad(8,1) = 0
D_wind_quad(8,2) = 0
D_wind_quad(8,3) = 0
D_wind_quad(8,4) = 0
