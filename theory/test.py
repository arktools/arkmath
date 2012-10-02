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

# state space
x = Matrix([phi, theta, psi, vn, ve, vd, l, L, h]) # state
u = Matrix([wx, wy, wz, fx, fy, fz]) # input

# frames
i = ReferenceFrame('i') # ECI
e = ReferenceFrame('e') # ECEF
e.set_ang_vel(i, omega*i.z)
n = e.orientnew('n', 'Body', [L, l, 0], '321')          # navigation
e.set_ang_vel(i, omega*i.z)
b = n.orientnew('b', 'Body', [phi, theta, psi], '321')  # body

# vectors
w_ib = wx*b.x + wy*b.y + wz*b.z
f_b = fx*b.x + fy*b.y + fz*b.z

o = Point('o') # inertially fixed in the earth
o.set_vel(i, 0) # no velocity wrt inertial frame
o.set_vel(e, 0) # no velocity wrt planet frame
o.set_vel(n, 0) # no velocity wrt nav frame

p = o.locatenew('p', (r0 + h)*n.x)
p.set_vel(n, vn*n.x + ve*n.y + vd*n.z)

# kinematics
v_op_nb = p.v1pt_theory(o,e,n)
dvn = dot(v_op_nb,n.x)
dve = dot(v_op_nb,n.y)
dvd = dot(v_op_nb,n.z)

# input

# dynamics
f = Matrix([dvn, dve, dvd])
F = f.jacobian(x)

print 'F = \n', mprint(F)

#print '\nc code\n'
#cprint_boost_matrix(F,'F')

#print b.dcm(i)

# quaternion
qnb = i.orientnew('bq', 'Quaternion', [q0, q1, q2, q3])
#print qnb.dcm(i)
