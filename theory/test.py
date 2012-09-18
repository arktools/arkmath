#!/usr/bin/env python
from sympy import init_printing, ccode, sin, cos, Matrix, pprint, diff
from sympy.abc import rho, phi
from sympy.matrices import *

init_printing()

def cprint_boost_matrix(m,name):
    for i in range(m.rows):
        for j in range(m.cols):
            print '%s[%d,%d] = %s;' % (name,i,j,ccode(Jxy[i,j]))

X = Matrix([rho*cos(phi), rho*sin(phi), rho**2])
Y = Matrix([rho, phi])
Jxy = X.jacobian(Y)

print 'Jxy = \n', Jxy

print '\nc code\n'
cprint_boost_matrix(Jxy,'Jxy')


from sympy.physics.mechanics import Point, ReferenceFrame, outer
from sympy.physics.mechanics import RigidBody, dynamicsymbols, mprint, mlatex
from sympy import diff
from sympy.abc import x
M, v = dynamicsymbols('M v')
N = ReferenceFrame('N')
P = Point('P')
P.set_vel(N, v * N.x)
I = outer (N.x, N.x)
Inertia_tuple = (I, P)
B = RigidBody('B', P, N, M, Inertia_tuple)
M = B.linear_momentum(N)
print M.diff(v,N)
