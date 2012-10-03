#!/usr/bin/env python
from sympy import *
from sympy.physics.mechanics import *
from sympy.matrices import *
from sympy import symbols

def cprint_boost_matrix(m,name):
    for i in range(m.rows):
        for j in range(m.cols):
            print '%s[%d,%d] = %s;' % (name,i,j,ccode(m[i,j]))

# variables
r0 = symbols('r0') # radius of planet
omega = symbols('omega') # rotation rate of planet

phi, theta, psi = dynamicsymbols('phi theta psi')  # euler angles
vn, ve, vd = dynamicsymbols('vn ve vd') # navigation frame velocities
l, L, h = dynamicsymbols('l L h') # geodetic coordinates
q0, q1, q2, q3 = symbols('q0 q1 q2 q3') # quaternions
wx, wy, wz = symbols('wx wy wz') # body angular vel components
fx, fy, fz = symbols('fx fy fz') # body specific force components
fn, fe, fd = symbols('fn fe fd') # body specific force components

# state space
x = Matrix([phi, theta, psi, vn, ve, vd, l, L, h]) # state
u = Matrix([wx, wy, wz, fx, fy, fz]) # input

# frames
r = r0 + h

i = ReferenceFrame('i') # ECI
e = i.orientnew('e', 'Axis', [theta, i.z]) # ECEF
e.set_ang_vel(i, omega*i.z)
#n = e.orientnew('n', 'Body', [0, -(L+pi/2), l], '321')     # navigation
n = e.orientnew('n', 'Body', [l, -(L+pi/2), 0], '321')     # navigation
print 'C_ne: \n', n.dcm(e)
print 'w_en: \n', n.ang_vel_in(e)
b = n.orientnew('b', 'Body', [phi, theta, psi], '321')  # body

t = Symbol('t')

#print diff(L,t)


# vectors
w_ib = wx*b.x + wy*b.y + wz*b.z
f_b = fx*b.x + fy*b.y + fz*b.z

o = Point('o') # inertially fixed in the earth
o.set_vel(i, 0) # no velocity wrt inertial frame

p = o.locatenew('p', r*n.x)
p.set_vel(e, vn*n.x + ve*n.y + vd*n.z)
p.set_vel(i, p.v1pt_theory(o,i,e))

# kinematics
dphi = 0
dtheta = 0
dpsi = 0
dvn = solve(Eq(dot(p.acc(i),n.x),fn),diff(vn,t))[0]
dve = solve(Eq(dot(p.acc(i),n.y),fe),diff(ve,t))[0]
dvd = solve(Eq(dot(p.acc(i),n.z),fd),diff(vd,t))[0]
dh = -vd
# solve for lat/lon deriv assuming nav frame fixed w/ vehicle
dL = solve(Eq(dot(n.ang_vel_in(e),n.y),-vn/r),diff(L,t))[0]
dl = solve(Eq(dot(n.ang_vel_in(e),n.x),ve/r),diff(l,t))[0]

# dynamics
t = Symbol('t')
f = Matrix([dphi, dtheta, dpsi, dvn, dve, dvd, dL, dl, dh])
mprint(f)
F = f.jacobian(x)
G = f.jacobian(u)

print 'F = \n', mprint(F)
print 'G = \n', mprint(G)

#print '\nc code\n'
#cprint_boost_matrix(F,'F')

#print b.dcm(i)

# quaternion
qnb = i.orientnew('bq', 'Quaternion', [q0, q1, q2, q3])
#print qnb.dcm(i)
