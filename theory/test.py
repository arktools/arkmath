#!/usr/bin/env python
from sympy import *
from sympy.physics.mechanics import *
from sympy.matrices import *

print 'setup'

def cprint_boost_matrix(m,name):
    for i in range(m.rows):
        for j in range(m.cols):
            if not m[i,j] == 0:
                print '%s(%d,%d) = %s;' % (name,i,j,ccode(m[i,j]))

def mpprint_matrix(m,name):
    for i in range(m.rows):
        for j in range(m.cols):
            if not m[i,j] == 0:
                print '%s(%d,%d) = ' % (name,i,j), mpprint(m[i,j])

# variables
r0 = symbols('r0') # radius of planet
r = dynamicsymbols('r') # distance from center of planet
omega = symbols('omega') # rotation rate of planet
def gamma(t):
    return omega*t
phi, theta, psi = dynamicsymbols('phi theta psi')  # euler angles
vn, ve, vd = dynamicsymbols('vn ve vd') # navigation frame velocities
l, L, h = dynamicsymbols('l L h') # geodetic coordinates
q0, q1, q2, q3 = symbols('q0 q1 q2 q3') # quaternions
wx, wy, wz = symbols('wx wy wz') # body angular vel components
fx, fy, fz = symbols('fx fy fz') # body specific force components
fn, fe, fd = symbols('fn fe fd') # body specific force components
t = Symbol('t')

# state space
x = Matrix([phi, theta, psi, vn, ve, vd, l, L, h]) # state
u = Matrix([wx, wy, wz, fx, fy, fz]) # input

# frames
print 'frame definition'
i = ReferenceFrame('i') # ECI
e = i.orientnew('e', 'Axis', [gamma(t), i.z]) # ECEF
n = e.orientnew('n', 'Body', [l, -(L+pi/2), 0], '321')     # navigation
#print 'C_ne: \n', n.dcm(e)
#print 'w_en: \n', n.ang_vel_in(e)
b = n.orientnew('b', 'Body', [phi, theta, psi], '321')  # body

print 'point definition'

# vectors
o = Point('o') # inertially fixed in the earth
o.set_vel(i, 0) # no velocity wrt inertial frame

p = o.locatenew('p', r*n.x)
p.set_vel(e, vn*n.x + ve*n.y + vd*n.z)
p.set_vel(i, p.v1pt_theory(o,i,e))
a_ip = p.acc(i)

# kinematics

print 'position kinematics'
dL = solve(Eq(dot(n.ang_vel_in(e),n.y),-vn/r),diff(L,t))[0]
dl = solve(Eq(dot(n.ang_vel_in(e),n.x),ve/r),diff(l,t))[0]

w_ib = b.ang_vel_in(i)

print 'attitude kinematics'
eulerDot = [diff(phi,t),diff(theta,t),diff(psi,t)]
att_sol = solve(
    [
        collect(Eq(dot(w_ib,b.x),wx),eulerDot),
        collect(Eq(dot(w_ib,b.y),wy),eulerDot),
        collect(Eq(dot(w_ib,b.z),wz),eulerDot),
    ],
    eulerDot,
    manual=True,
    simplify=False,
)[0]

print 'simplifying attitude kinematics'

#dphi = att_sol[diff(phi,t)]
#dtheta = att_sol[diff(theta,t)]
#dpsi = att_sol[diff(psi,t)]

#w_ib = (b.ang_vel_in(i)).subs({diff(L,t):dL,diff(l,t):dl})

def mysimp(e):
    e = simplify(e)
    #e = factor(e)
    #e = trigsimp(e) 
    return e

dphi = mysimp(att_sol[diff(phi,t)])
print 'dphi:\n', mprint(dphi)
dtheta = mysimp(att_sol[diff(theta,t)])
print 'dtheta:\n', mprint(dtheta)
dpsi = mysimp(att_sol[diff(psi,t)])
print 'dpsi:\n', mprint(dpsi)

print 'velocity kinematics'
dvn = solve(Eq(dot(a_ip,n.x),fn),diff(vn,t))[0]
dve = solve(Eq(dot(a_ip,n.y),fe),diff(ve,t))[0]
dvd = solve(Eq(dot(a_ip,n.z),fd),diff(vd,t))[0]

print 'position kinematics'
dh = -vd
# solve for lat/lon deriv assuming nav frame fixed w/ vehicle

# dynamics
print 'state space'
f_simp = Matrix([dphi, dtheta, dpsi, dvn, dve, dvd, dL, dl, dh])
f = f_simp.subs({diff(L,t):dL,diff(l,t):dl,r:r0+h})
F = f.jacobian(x)
G = f.jacobian(u)

mpprint_matrix(F,'F')
mpprint_matrix(G,'G')

#print '\nc code\n'
#cprint_boost_matrix(F,'F')

#print b.dcm(i)

# quaternion
#qnb = i.orientnew('bq', 'Quaternion', [q0, q1, q2, q3])
#print qnb.dcm(i)
