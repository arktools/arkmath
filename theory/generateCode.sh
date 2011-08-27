#!/bin/bash

function usage
{
	echo usage: 
	echo $0 m : run with maxima and generate code
	echo $0 n : generated code
}

if [ $# == 1 ]
then
	if [ $1 == 'm' ]
	then
		echo running maxima
		if [ ! -d code ]; then mkdir code; fi
		maxima -b navigation.wxm
		maxima -b navigationEquations.wxm
		maxima -b quadrotorWindFrame.wxm
		maxima -b quadrotorBodyFrame.wxm
	elif [ $1 == 'n' ] 
	then
		echo running without maxima
	else
		usage
		exit
	fi
else
	usage
	exit
fi

navPath=../src/gen/navigation
sciPath=.
dynPath=../src/gen/dynamics

if [ ! -d $navPath ]; then mkdir $navPath; fi
if [ ! -d $dynPath ]; then mkdir $dynPath; fi

cat code/ins_dynamics_f.f90 | sed \
	-e "s/$/;/g" \
	-e "/^.*) = 0;$/d" \
	-e "s/a\*\*2/aa/g" -e "s/b\*\*2/bb/g" -e "s/c\*\*2/cc/g" -e "s/d\*\*2/dd/g" \
	-e "s/cos(L)/cosL/g" -e "s/sin(L)/sinL/g" -e "s/tan(L)/tanL/g" \
	-e "s/sec(L)/secL/g" \
	-e "s/Vn\*\*2/Vn*Vn/g" \
	-e "s/(1,/(0,/g" -e "s/,1)/,0)/g" \
	-e "s/(2,/(1,/g" -e "s/,2)/,1)/g" \
	-e "s/(3,/(2,/g" -e "s/,3)/,2)/g" \
	-e "s/(4,/(3,/g" -e "s/,4)/,3)/g" \
	-e "s/(5,/(4,/g" -e "s/,5)/,4)/g" \
	-e "s/(6,/(5,/g" -e "s/,6)/,5)/g" \
	-e "s/(7,/(6,/g" -e "s/,7)/,6)/g" \
	-e "s/(8,/(7,/g" -e "s/,8)/,7)/g" \
	-e "s/(9,/(8,/g" -e "s/,9)/,8)/g" \
	-e "s/(10,/(9,/g" -e "s/,10)/,9)/g" \
	-e "s/(11,/(10,/g" -e "s/,11)/,10)/g" \
	-e "s/(12,/(11,/g" -e "s/,12)/,11)/g" \
	-e "s/(13,/(12,/g" -e "s/,13)/,12)/g" \
	-e "s/(14,/(13,/g" -e "s/,14)/,13)/g" \
	-e "s/(15,/(14,/g" -e "s/,15)/,14)/g" \
	-e "s/(16,/(15,/g" -e "s/,16)/,15)/g" \
	-e "s/(17,/(16,/g" -e "s/,17)/,16)/g" \
	-e "s/(18,/(17,/g" -e "s/,18)/,17)/g" \
	-e "s/(19,/(18,/g" -e "s/,19)/,18)/g" \
	> ${navPath}/ins_dynamics_f.hpp

cat code/ins_dynamics_f_att.f90 | sed \
	-e "s/$/;/g" \
	-e "/^.*) = 0;$/d" \
	-e "s/a\*\*2/aa/g" -e "s/b\*\*2/bb/g" -e "s/c\*\*2/cc/g" -e "s/d\*\*2/dd/g" \
	-e "s/cos(L)/cosL/g" -e "s/sin(L)/sinL/g" -e "s/tan(L)/tanL/g" \
	-e "s/sec(L)/secL/g" \
	-e "s/Vn\*\*2/Vn*Vn/g" \
	-e "s/(1,/(0,/g" -e "s/,1)/,0)/g" \
	-e "s/(2,/(1,/g" -e "s/,2)/,1)/g" \
	-e "s/(3,/(2,/g" -e "s/,3)/,2)/g" \
	-e "s/(4,/(3,/g" -e "s/,4)/,3)/g" \
	-e "s/(5,/(4,/g" -e "s/,5)/,4)/g" \
	-e "s/(6,/(5,/g" -e "s/,6)/,5)/g" \
	-e "s/(7,/(6,/g" -e "s/,7)/,6)/g" \
	-e "s/(8,/(7,/g" -e "s/,8)/,7)/g" \
	-e "s/(9,/(8,/g" -e "s/,9)/,8)/g" \
	-e "s/(10,/(9,/g" -e "s/,10)/,9)/g" \
	-e "s/(11,/(10,/g" -e "s/,11)/,10)/g" \
	-e "s/(12,/(11,/g" -e "s/,12)/,11)/g" \
	-e "s/(13,/(12,/g" -e "s/,13)/,12)/g" \
	-e "s/(14,/(13,/g" -e "s/,14)/,13)/g" \
	-e "s/(15,/(14,/g" -e "s/,15)/,14)/g" \
	-e "s/(16,/(15,/g" -e "s/,16)/,15)/g" \
	-e "s/(17,/(16,/g" -e "s/,17)/,16)/g" \
	-e "s/(18,/(17,/g" -e "s/,18)/,17)/g" \
	-e "s/(19,/(18,/g" -e "s/,19)/,18)/g" \
	> ${navPath}/ins_dynamics_f_att.hpp

cat code/ins_dynamics_f_vp.f90 | sed \
	-e "s/$/;/g" \
	-e "/^.*) = 0;$/d" \
	-e "s/a\*\*2/aa/g" -e "s/b\*\*2/bb/g" -e "s/c\*\*2/cc/g" -e "s/d\*\*2/dd/g" \
	-e "s/cos(L)/cosL/g" -e "s/sin(L)/sinL/g" -e "s/tan(L)/tanL/g" \
	-e "s/sec(L)/secL/g" \
	-e "s/Vn\*\*2/Vn*Vn/g" \
	-e "s/(1,/(0,/g" -e "s/,1)/,0)/g" \
	-e "s/(2,/(1,/g" -e "s/,2)/,1)/g" \
	-e "s/(3,/(2,/g" -e "s/,3)/,2)/g" \
	-e "s/(4,/(3,/g" -e "s/,4)/,3)/g" \
	-e "s/(5,/(4,/g" -e "s/,5)/,4)/g" \
	-e "s/(6,/(5,/g" -e "s/,6)/,5)/g" \
	-e "s/(7,/(6,/g" -e "s/,7)/,6)/g" \
	-e "s/(8,/(7,/g" -e "s/,8)/,7)/g" \
	-e "s/(9,/(8,/g" -e "s/,9)/,8)/g" \
	-e "s/(10,/(9,/g" -e "s/,10)/,9)/g" \
	-e "s/(11,/(10,/g" -e "s/,11)/,10)/g" \
	-e "s/(12,/(11,/g" -e "s/,12)/,11)/g" \
	-e "s/(13,/(12,/g" -e "s/,13)/,12)/g" \
	-e "s/(14,/(13,/g" -e "s/,14)/,13)/g" \
	-e "s/(15,/(14,/g" -e "s/,15)/,14)/g" \
	-e "s/(16,/(15,/g" -e "s/,16)/,15)/g" \
	-e "s/(17,/(16,/g" -e "s/,17)/,16)/g" \
	-e "s/(18,/(17,/g" -e "s/,18)/,17)/g" \
	-e "s/(19,/(18,/g" -e "s/,19)/,18)/g" \
	> ${navPath}/ins_dynamics_f_vp.hpp

cat code/ins_error_dynamics_F.f90 | sed \
	-e "s/$/;/g" \
	-e "/^.*) = 0;$/d" \
	-e "s/a\*\*2/aa/g" -e "s/b\*\*2/bb/g" -e "s/c\*\*2/cc/g" -e "s/d\*\*2/dd/g" \
	-e "s/cos(L)/cosL/g" -e "s/sin(L)/sinL/g" -e "s/tan(L)/tanL/g" \
	-e "s/sec(L)/secL/g" \
	-e "s/secL\*\*2/secLsecL/g" \
	-e "s/R\*\*2/RR/g" \
	-e "s/cosL\*\*2/cosLcosL/g" \
	-e "s/(1,/(0,/g" -e "s/,1)/,0)/g" \
	-e "s/(2,/(1,/g" -e "s/,2)/,1)/g" \
	-e "s/(3,/(2,/g" -e "s/,3)/,2)/g" \
	-e "s/(4,/(3,/g" -e "s/,4)/,3)/g" \
	-e "s/(5,/(4,/g" -e "s/,5)/,4)/g" \
	-e "s/(6,/(5,/g" -e "s/,6)/,5)/g" \
	-e "s/(7,/(6,/g" -e "s/,7)/,6)/g" \
	-e "s/(8,/(7,/g" -e "s/,8)/,7)/g" \
	-e "s/(9,/(8,/g" -e "s/,9)/,8)/g" \
	-e "s/(10,/(9,/g" -e "s/,10)/,9)/g" \
	-e "s/(11,/(10,/g" -e "s/,11)/,10)/g" \
	-e "s/(12,/(11,/g" -e "s/,12)/,11)/g" \
	-e "s/(13,/(12,/g" -e "s/,13)/,12)/g" \
	-e "s/(14,/(13,/g" -e "s/,14)/,13)/g" \
	-e "s/(15,/(14,/g" -e "s/,15)/,14)/g" \
	-e "s/(16,/(15,/g" -e "s/,16)/,15)/g" \
	-e "s/(17,/(16,/g" -e "s/,17)/,16)/g" \
	-e "s/(18,/(17,/g" -e "s/,18)/,17)/g" \
	-e "s/(19,/(18,/g" -e "s/,19)/,18)/g" \
	> ${navPath}/ins_error_dynamics_F.hpp

cat code/ins_error_dynamics_F_att.f90 | sed \
	-e "s/$/;/g" \
	-e "/^.*) = 0;$/d" \
	-e "s/a\*\*2/aa/g" -e "s/b\*\*2/bb/g" -e "s/c\*\*2/cc/g" -e "s/d\*\*2/dd/g" \
	-e "s/cos(L)/cosL/g" -e "s/sin(L)/sinL/g" -e "s/tan(L)/tanL/g" \
	-e "s/sec(L)/secL/g" \
	-e "s/secL\*\*2/secLsecL/g" \
	-e "s/R\*\*2/RR/g" \
	-e "s/cosL\*\*2/cosLcosL/g" \
	-e "s/(1,/(0,/g" -e "s/,1)/,0)/g" \
	-e "s/(2,/(1,/g" -e "s/,2)/,1)/g" \
	-e "s/(3,/(2,/g" -e "s/,3)/,2)/g" \
	-e "s/(4,/(3,/g" -e "s/,4)/,3)/g" \
	-e "s/(5,/(4,/g" -e "s/,5)/,4)/g" \
	-e "s/(6,/(5,/g" -e "s/,6)/,5)/g" \
	-e "s/(7,/(6,/g" -e "s/,7)/,6)/g" \
	-e "s/(8,/(7,/g" -e "s/,8)/,7)/g" \
	-e "s/(9,/(8,/g" -e "s/,9)/,8)/g" \
	-e "s/(10,/(9,/g" -e "s/,10)/,9)/g" \
	-e "s/(11,/(10,/g" -e "s/,11)/,10)/g" \
	-e "s/(12,/(11,/g" -e "s/,12)/,11)/g" \
	-e "s/(13,/(12,/g" -e "s/,13)/,12)/g" \
	-e "s/(14,/(13,/g" -e "s/,14)/,13)/g" \
	-e "s/(15,/(14,/g" -e "s/,15)/,14)/g" \
	-e "s/(16,/(15,/g" -e "s/,16)/,15)/g" \
	-e "s/(17,/(16,/g" -e "s/,17)/,16)/g" \
	-e "s/(18,/(17,/g" -e "s/,18)/,17)/g" \
	-e "s/(19,/(18,/g" -e "s/,19)/,18)/g" \
	> ${navPath}/ins_error_dynamics_F_att.hpp

cat code/ins_error_dynamics_F_vp.f90 | sed \
	-e "s/$/;/g" \
	-e "/^.*) = 0;$/d" \
	-e "s/a\*\*2/aa/g" -e "s/b\*\*2/bb/g" -e "s/c\*\*2/cc/g" -e "s/d\*\*2/dd/g" \
	-e "s/cos(L)/cosL/g" -e "s/sin(L)/sinL/g" -e "s/tan(L)/tanL/g" \
	-e "s/sec(L)/secL/g" \
	-e "s/secL\*\*2/secLsecL/g" \
	-e "s/R\*\*2/RR/g" \
	-e "s/cosL\*\*2/cosLcosL/g" \
	-e "s/(1,/(0,/g" -e "s/,1)/,0)/g" \
	-e "s/(2,/(1,/g" -e "s/,2)/,1)/g" \
	-e "s/(3,/(2,/g" -e "s/,3)/,2)/g" \
	-e "s/(4,/(3,/g" -e "s/,4)/,3)/g" \
	-e "s/(5,/(4,/g" -e "s/,5)/,4)/g" \
	-e "s/(6,/(5,/g" -e "s/,6)/,5)/g" \
	-e "s/(7,/(6,/g" -e "s/,7)/,6)/g" \
	-e "s/(8,/(7,/g" -e "s/,8)/,7)/g" \
	-e "s/(9,/(8,/g" -e "s/,9)/,8)/g" \
	-e "s/(10,/(9,/g" -e "s/,10)/,9)/g" \
	-e "s/(11,/(10,/g" -e "s/,11)/,10)/g" \
	-e "s/(12,/(11,/g" -e "s/,12)/,11)/g" \
	-e "s/(13,/(12,/g" -e "s/,13)/,12)/g" \
	-e "s/(14,/(13,/g" -e "s/,14)/,13)/g" \
	-e "s/(15,/(14,/g" -e "s/,15)/,14)/g" \
	-e "s/(16,/(15,/g" -e "s/,16)/,15)/g" \
	-e "s/(17,/(16,/g" -e "s/,17)/,16)/g" \
	-e "s/(18,/(17,/g" -e "s/,18)/,17)/g" \
	-e "s/(19,/(18,/g" -e "s/,19)/,18)/g" \
	> ${navPath}/ins_error_dynamics_F_vp.hpp

cat code/ins_error_dynamics_G.f90 | sed \
	-e "s/$/;/g" \
	-e "/^.*) = 0;$/d" \
	-e "s/a\*\*2/aa/g" -e "s/b\*\*2/bb/g" -e "s/c\*\*2/cc/g" -e "s/d\*\*2/dd/g" \
	-e "s/a\*\*3/aaa/g" -e "s/b\*\*3/bbb/g" -e "s/c\*\*3/ccc/g" -e "s/d\*\*3/ddd/g" \
	-e "s/cos(L)/cosL/g" -e "s/sin(L)/sinL/g" -e "s/tan(L)/tanL/g" \
	-e "s/sec(L)/secL/g" \
	-e "s/secL\**2/secLsecL/g" \
	-e "s/R\*\*2/RR/g" \
	-e "s/cosL\*\*2/cosLcosL/g" \
	-e "s/(1,/(0,/g" -e "s/,1)/,0)/g" \
	-e "s/(2,/(1,/g" -e "s/,2)/,1)/g" \
	-e "s/(3,/(2,/g" -e "s/,3)/,2)/g" \
	-e "s/(4,/(3,/g" -e "s/,4)/,3)/g" \
	-e "s/(5,/(4,/g" -e "s/,5)/,4)/g" \
	-e "s/(6,/(5,/g" -e "s/,6)/,5)/g" \
	-e "s/(7,/(6,/g" -e "s/,7)/,6)/g" \
	-e "s/(8,/(7,/g" -e "s/,8)/,7)/g" \
	-e "s/(9,/(8,/g" -e "s/,9)/,8)/g" \
	-e "s/(10,/(9,/g" -e "s/,10)/,9)/g" \
	-e "s/(11,/(10,/g" -e "s/,11)/,10)/g" \
	-e "s/(12,/(11,/g" -e "s/,12)/,11)/g" \
	-e "s/(13,/(12,/g" -e "s/,13)/,12)/g" \
	-e "s/(14,/(13,/g" -e "s/,14)/,13)/g" \
	-e "s/(15,/(14,/g" -e "s/,15)/,14)/g" \
	-e "s/(16,/(15,/g" -e "s/,16)/,15)/g" \
	-e "s/(17,/(16,/g" -e "s/,17)/,16)/g" \
	-e "s/(18,/(17,/g" -e "s/,18)/,17)/g" \
	-e "s/(19,/(18,/g" -e "s/,19)/,18)/g" \
	> ${navPath}/ins_error_dynamics_G.hpp

cat code/ins_error_dynamics_G_att.f90 | sed \
	-e "s/$/;/g" \
	-e "/^.*) = 0;$/d" \
	-e "s/a\*\*2/aa/g" -e "s/b\*\*2/bb/g" -e "s/c\*\*2/cc/g" -e "s/d\*\*2/dd/g" \
	-e "s/a\*\*3/aaa/g" -e "s/b\*\*3/bbb/g" -e "s/c\*\*3/ccc/g" -e "s/d\*\*3/ddd/g" \
	-e "s/cos(L)/cosL/g" -e "s/sin(L)/sinL/g" -e "s/tan(L)/tanL/g" \
	-e "s/sec(L)/secL/g" \
	-e "s/secL\**2/secLsecL/g" \
	-e "s/R\*\*2/RR/g" \
	-e "s/cosL\*\*2/cosLcosL/g" \
	> ${navPath}/ins_error_dynamics_G_att.hpp

cat code/ins_error_dynamics_G_vp.f90 | sed \
	-e "s/$/;/g" \
	-e "/^.*) = 0;$/d" \
	-e "s/a\*\*2/aa/g" -e "s/b\*\*2/bb/g" -e "s/c\*\*2/cc/g" -e "s/d\*\*2/dd/g" \
	-e "s/a\*\*3/aaa/g" -e "s/b\*\*3/bbb/g" -e "s/c\*\*3/ccc/g" -e "s/d\*\*3/ddd/g" \
	-e "s/cos(L)/cosL/g" -e "s/sin(L)/sinL/g" -e "s/tan(L)/tanL/g" \
	-e "s/sec(L)/secL/g" \
	-e "s/secL\**2/secLsecL/g" \
	-e "s/R\*\*2/RR/g" \
	-e "s/cosL\*\*2/cosLcosL/g" \
	-e "s/(1,/(0,/g" -e "s/,1)/,0)/g" \
	-e "s/(2,/(1,/g" -e "s/,2)/,1)/g" \
	-e "s/(3,/(2,/g" -e "s/,3)/,2)/g" \
	-e "s/(4,/(3,/g" -e "s/,4)/,3)/g" \
	-e "s/(5,/(4,/g" -e "s/,5)/,4)/g" \
	-e "s/(6,/(5,/g" -e "s/,6)/,5)/g" \
	-e "s/(7,/(6,/g" -e "s/,7)/,6)/g" \
	-e "s/(8,/(7,/g" -e "s/,8)/,7)/g" \
	-e "s/(9,/(8,/g" -e "s/,9)/,8)/g" \
	-e "s/(10,/(9,/g" -e "s/,10)/,9)/g" \
	-e "s/(11,/(10,/g" -e "s/,11)/,10)/g" \
	-e "s/(12,/(11,/g" -e "s/,12)/,11)/g" \
	-e "s/(13,/(12,/g" -e "s/,13)/,12)/g" \
	-e "s/(14,/(13,/g" -e "s/,14)/,13)/g" \
	-e "s/(15,/(14,/g" -e "s/,15)/,14)/g" \
	-e "s/(16,/(15,/g" -e "s/,16)/,15)/g" \
	-e "s/(17,/(16,/g" -e "s/,17)/,16)/g" \
	-e "s/(18,/(17,/g" -e "s/,18)/,17)/g" \
	-e "s/(19,/(18,/g" -e "s/,19)/,18)/g" \
	> ${navPath}/ins_error_dynamics_G_vp.hpp

cat code/ins_H_mag.f90 | sed \
	-e "s/$/;/g" \
	-e "/^.*) = 0;$/d" \
	-e "s/a\*\*2/aa/g" -e "s/b\*\*2/bb/g" -e "s/c\*\*2/cc/g" -e "s/d\*\*2/dd/g" \
	-e "s/a\*\*3/aaa/g" -e "s/b\*\*3/bbb/g" -e "s/c\*\*3/ccc/g" -e "s/d\*\*3/ddd/g" \
	-e "s/cos(L)/cosL/g" -e "s/sin(L)/sinL/g" -e "s/tan(L)/tanL/g" \
	-e "s/sec(L)/secL/g" \
	-e "s/secL\**2/secLsecL/g" \
	-e "s/R\*\*2/RR/g" \
	-e "s/cosL\*\*2/cosLcosL/g" \
	-e "s/(1,/(0,/g" -e "s/,1)/,0)/g" \
	-e "s/(2,/(1,/g" -e "s/,2)/,1)/g" \
	-e "s/(3,/(2,/g" -e "s/,3)/,2)/g" \
	-e "s/(4,/(3,/g" -e "s/,4)/,3)/g" \
	-e "s/(5,/(4,/g" -e "s/,5)/,4)/g" \
	-e "s/(6,/(5,/g" -e "s/,6)/,5)/g" \
	-e "s/(7,/(6,/g" -e "s/,7)/,6)/g" \
	-e "s/(8,/(7,/g" -e "s/,8)/,7)/g" \
	-e "s/(9,/(8,/g" -e "s/,9)/,8)/g" \
	-e "s/(10,/(9,/g" -e "s/,10)/,9)/g" \
	-e "s/(11,/(10,/g" -e "s/,11)/,10)/g" \
	-e "s/(12,/(11,/g" -e "s/,12)/,11)/g" \
	-e "s/(13,/(12,/g" -e "s/,13)/,12)/g" \
	-e "s/(14,/(13,/g" -e "s/,14)/,13)/g" \
	-e "s/(15,/(14,/g" -e "s/,15)/,14)/g" \
	-e "s/(16,/(15,/g" -e "s/,16)/,15)/g" \
	-e "s/(17,/(16,/g" -e "s/,17)/,16)/g" \
	-e "s/(18,/(17,/g" -e "s/,18)/,17)/g" \
	-e "s/(19,/(18,/g" -e "s/,19)/,18)/g" \
	> ${navPath}/ins_H_mag.hpp

cat code/ins_H_mag_att.f90 | sed \
	-e "s/$/;/g" \
	-e "/^.*) = 0;$/d" \
	-e "s/a\*\*2/aa/g" -e "s/b\*\*2/bb/g" -e "s/c\*\*2/cc/g" -e "s/d\*\*2/dd/g" \
	-e "s/a\*\*3/aaa/g" -e "s/b\*\*3/bbb/g" -e "s/c\*\*3/ccc/g" -e "s/d\*\*3/ddd/g" \
	-e "s/cos(L)/cosL/g" -e "s/sin(L)/sinL/g" -e "s/tan(L)/tanL/g" \
	-e "s/sec(L)/secL/g" \
	-e "s/secL\**2/secLsecL/g" \
	-e "s/R\*\*2/RR/g" \
	-e "s/cosL\*\*2/cosLcosL/g" \
	-e "s/(1,/(0,/g" -e "s/,1)/,0)/g" \
	-e "s/(2,/(1,/g" -e "s/,2)/,1)/g" \
	-e "s/(3,/(2,/g" -e "s/,3)/,2)/g" \
	-e "s/(4,/(3,/g" -e "s/,4)/,3)/g" \
	-e "s/(5,/(4,/g" -e "s/,5)/,4)/g" \
	-e "s/(6,/(5,/g" -e "s/,6)/,5)/g" \
	-e "s/(7,/(6,/g" -e "s/,7)/,6)/g" \
	-e "s/(8,/(7,/g" -e "s/,8)/,7)/g" \
	-e "s/(9,/(8,/g" -e "s/,9)/,8)/g" \
	-e "s/(10,/(9,/g" -e "s/,10)/,9)/g" \
	-e "s/(11,/(10,/g" -e "s/,11)/,10)/g" \
	-e "s/(12,/(11,/g" -e "s/,12)/,11)/g" \
	-e "s/(13,/(12,/g" -e "s/,13)/,12)/g" \
	-e "s/(14,/(13,/g" -e "s/,14)/,13)/g" \
	-e "s/(15,/(14,/g" -e "s/,15)/,14)/g" \
	-e "s/(16,/(15,/g" -e "s/,16)/,15)/g" \
	-e "s/(17,/(16,/g" -e "s/,17)/,16)/g" \
	-e "s/(18,/(17,/g" -e "s/,18)/,17)/g" \
	-e "s/(19,/(18,/g" -e "s/,19)/,18)/g" \
	> ${navPath}/ins_H_mag_att.hpp

cat code/ins_R_mag_n.f90 | sed \
	-e "s/$/;/g" \
	-e "/^.*) = 0;$/d" \
	-e "s/cos(dec)\*\*2/cosDec2/g" -e "s/sin(dec)\*\*2/sinDec2/g" \
	-e "s/cos(dip)\*\*2/cosDip2/g" -e "s/sin(dip)\*\*2/sinDip2/g" \
	-e "s/cos(dec)/cosDec/g" -e "s/sin(dec)/sinDec/g" \
	-e "s/cos(dip)/cosDip/g" -e "s/sin(dip)/sinDip/g" \
	-e "s/sigDec\*\*2/sigDec2/g" -e "s/sigDip\*\*2/sigDip2/g" \
	-e "s/(1,/(0,/g" -e "s/,1)/,0)/g" \
	-e "s/(2,/(1,/g" -e "s/,2)/,1)/g" \
	-e "s/(3,/(2,/g" -e "s/,3)/,2)/g" \
	-e "s/(4,/(3,/g" -e "s/,4)/,3)/g" \
	-e "s/(5,/(4,/g" -e "s/,5)/,4)/g" \
	-e "s/(6,/(5,/g" -e "s/,6)/,5)/g" \
	-e "s/(7,/(6,/g" -e "s/,7)/,6)/g" \
	-e "s/(8,/(7,/g" -e "s/,8)/,7)/g" \
	-e "s/(9,/(8,/g" -e "s/,9)/,8)/g" \
	-e "s/(10,/(9,/g" -e "s/,10)/,9)/g" \
	-e "s/(11,/(10,/g" -e "s/,11)/,10)/g" \
	-e "s/(12,/(11,/g" -e "s/,12)/,11)/g" \
	-e "s/(13,/(12,/g" -e "s/,13)/,12)/g" \
	-e "s/(14,/(13,/g" -e "s/,14)/,13)/g" \
	-e "s/(15,/(14,/g" -e "s/,15)/,14)/g" \
	-e "s/(16,/(15,/g" -e "s/,16)/,15)/g" \
	-e "s/(17,/(16,/g" -e "s/,17)/,16)/g" \
	-e "s/(18,/(17,/g" -e "s/,18)/,17)/g" \
	-e "s/(19,/(18,/g" -e "s/,19)/,18)/g" \
	> ${navPath}/ins_R_mag_n.hpp

cat code/ins_H_gps.f90 | sed \
	-e "s/$/;/g" \
	-e "/^.*) = 0;$/d" \
	-e "s/(1,/(0,/g" -e "s/,1)/,0)/g" \
	-e "s/(2,/(1,/g" -e "s/,2)/,1)/g" \
	-e "s/(3,/(2,/g" -e "s/,3)/,2)/g" \
	-e "s/(4,/(3,/g" -e "s/,4)/,3)/g" \
	-e "s/(5,/(4,/g" -e "s/,5)/,4)/g" \
	-e "s/(6,/(5,/g" -e "s/,6)/,5)/g" \
	-e "s/(7,/(6,/g" -e "s/,7)/,6)/g" \
	-e "s/(8,/(7,/g" -e "s/,8)/,7)/g" \
	-e "s/(9,/(8,/g" -e "s/,9)/,8)/g" \
	-e "s/(10,/(9,/g" -e "s/,10)/,9)/g" \
	-e "s/(11,/(10,/g" -e "s/,11)/,10)/g" \
	-e "s/(12,/(11,/g" -e "s/,12)/,11)/g" \
	-e "s/(13,/(12,/g" -e "s/,13)/,12)/g" \
	-e "s/(14,/(13,/g" -e "s/,14)/,13)/g" \
	-e "s/(15,/(14,/g" -e "s/,15)/,14)/g" \
	-e "s/(16,/(15,/g" -e "s/,16)/,15)/g" \
	-e "s/(17,/(16,/g" -e "s/,17)/,16)/g" \
	-e "s/(18,/(17,/g" -e "s/,18)/,17)/g" \
	-e "s/(19,/(18,/g" -e "s/,19)/,18)/g" \
	> ${navPath}/ins_H_gps.hpp

cat code/ins_H_gps_vp.f90 | sed \
	-e "s/$/;/g" \
	-e "/^.*) = 0;$/d" \
	-e "s/(1,/(0,/g" -e "s/,1)/,0)/g" \
	-e "s/(2,/(1,/g" -e "s/,2)/,1)/g" \
	-e "s/(3,/(2,/g" -e "s/,3)/,2)/g" \
	-e "s/(4,/(3,/g" -e "s/,4)/,3)/g" \
	-e "s/(5,/(4,/g" -e "s/,5)/,4)/g" \
	-e "s/(6,/(5,/g" -e "s/,6)/,5)/g" \
	-e "s/(7,/(6,/g" -e "s/,7)/,6)/g" \
	-e "s/(8,/(7,/g" -e "s/,8)/,7)/g" \
	-e "s/(9,/(8,/g" -e "s/,9)/,8)/g" \
	-e "s/(10,/(9,/g" -e "s/,10)/,9)/g" \
	-e "s/(11,/(10,/g" -e "s/,11)/,10)/g" \
	-e "s/(12,/(11,/g" -e "s/,12)/,11)/g" \
	-e "s/(13,/(12,/g" -e "s/,13)/,12)/g" \
	-e "s/(14,/(13,/g" -e "s/,14)/,13)/g" \
	-e "s/(15,/(14,/g" -e "s/,15)/,14)/g" \
	-e "s/(16,/(15,/g" -e "s/,16)/,15)/g" \
	-e "s/(17,/(16,/g" -e "s/,17)/,16)/g" \
	-e "s/(18,/(17,/g" -e "s/,18)/,17)/g" \
	-e "s/(19,/(18,/g" -e "s/,19)/,18)/g" \
	> ${navPath}/ins_H_gps_vp.hpp

cat code/ins_R_gps.f90 | sed \
	-e "s/$/;/g" \
	-e "/^.*) = 0;$/d" \
	-e "s/(1,/(0,/g" -e "s/,1)/,0)/g" \
	-e "s/(2,/(1,/g" -e "s/,2)/,1)/g" \
	-e "s/(3,/(2,/g" -e "s/,3)/,2)/g" \
	-e "s/(4,/(3,/g" -e "s/,4)/,3)/g" \
	-e "s/(5,/(4,/g" -e "s/,5)/,4)/g" \
	-e "s/(6,/(5,/g" -e "s/,6)/,5)/g" \
	-e "s/(7,/(6,/g" -e "s/,7)/,6)/g" \
	-e "s/(8,/(7,/g" -e "s/,8)/,7)/g" \
	-e "s/(9,/(8,/g" -e "s/,9)/,8)/g" \
	-e "s/(10,/(9,/g" -e "s/,10)/,9)/g" \
	-e "s/(11,/(10,/g" -e "s/,11)/,10)/g" \
	-e "s/(12,/(11,/g" -e "s/,12)/,11)/g" \
	-e "s/(13,/(12,/g" -e "s/,13)/,12)/g" \
	-e "s/(14,/(13,/g" -e "s/,14)/,13)/g" \
	-e "s/(15,/(14,/g" -e "s/,15)/,14)/g" \
	-e "s/(16,/(15,/g" -e "s/,16)/,15)/g" \
	-e "s/(17,/(16,/g" -e "s/,17)/,16)/g" \
	-e "s/(18,/(17,/g" -e "s/,18)/,17)/g" \
	-e "s/(19,/(18,/g" -e "s/,19)/,18)/g" \
	> ${navPath}/ins_R_gps.hpp

cat code/ins_C_nb_quat.f90 | sed \
	-e "s/$/;/g" \
	-e "/^.*) = 0;$/d" \
	-e "s/a\*\*2/aa/g" -e "s/b\*\*2/bb/g" -e "s/c\*\*2/cc/g" -e "s/d\*\*2/dd/g" \
	-e "s/(1,/(0,/g" -e "s/,1)/,0)/g" \
	-e "s/(2,/(1,/g" -e "s/,2)/,1)/g" \
	-e "s/(3,/(2,/g" -e "s/,3)/,2)/g" \
	-e "s/(4,/(3,/g" -e "s/,4)/,3)/g" \
	-e "s/(5,/(4,/g" -e "s/,5)/,4)/g" \
	-e "s/(6,/(5,/g" -e "s/,6)/,5)/g" \
	-e "s/(7,/(6,/g" -e "s/,7)/,6)/g" \
	-e "s/(8,/(7,/g" -e "s/,8)/,7)/g" \
	-e "s/(9,/(8,/g" -e "s/,9)/,8)/g" \
	-e "s/(10,/(9,/g" -e "s/,10)/,9)/g" \
	-e "s/(11,/(10,/g" -e "s/,11)/,10)/g" \
	-e "s/(12,/(11,/g" -e "s/,12)/,11)/g" \
	-e "s/(13,/(12,/g" -e "s/,13)/,12)/g" \
	-e "s/(14,/(13,/g" -e "s/,14)/,13)/g" \
	-e "s/(15,/(14,/g" -e "s/,15)/,14)/g" \
	-e "s/(16,/(15,/g" -e "s/,16)/,15)/g" \
	-e "s/(17,/(16,/g" -e "s/,17)/,16)/g" \
	-e "s/(18,/(17,/g" -e "s/,18)/,17)/g" \
	-e "s/(19,/(18,/g" -e "s/,19)/,18)/g" \
	> ${navPath}/ins_C_nb_quat.hpp

cat code/ins_C_nb_euler.f90 | sed \
	-e "s/$/;/g" \
	-e "/^.*) = 0;$/d" \
	-e "s/a\*\*2/aa/g" -e "s/b\*\*2/bb/g" -e "s/c\*\*2/cc/g" -e "s/d\*\*2/dd/g" \
	-e "s/(1,/(0,/g" -e "s/,1)/,0)/g" \
	-e "s/(2,/(1,/g" -e "s/,2)/,1)/g" \
	-e "s/(3,/(2,/g" -e "s/,3)/,2)/g" \
	-e "s/(4,/(3,/g" -e "s/,4)/,3)/g" \
	-e "s/(5,/(4,/g" -e "s/,5)/,4)/g" \
	-e "s/(6,/(5,/g" -e "s/,6)/,5)/g" \
	-e "s/(7,/(6,/g" -e "s/,7)/,6)/g" \
	-e "s/(8,/(7,/g" -e "s/,8)/,7)/g" \
	-e "s/(9,/(8,/g" -e "s/,9)/,8)/g" \
	-e "s/(10,/(9,/g" -e "s/,10)/,9)/g" \
	-e "s/(11,/(10,/g" -e "s/,11)/,10)/g" \
	-e "s/(12,/(11,/g" -e "s/,12)/,11)/g" \
	-e "s/(13,/(12,/g" -e "s/,13)/,12)/g" \
	-e "s/(14,/(13,/g" -e "s/,14)/,13)/g" \
	-e "s/(15,/(14,/g" -e "s/,15)/,14)/g" \
	-e "s/(16,/(15,/g" -e "s/,16)/,15)/g" \
	-e "s/(17,/(16,/g" -e "s/,17)/,16)/g" \
	-e "s/(18,/(17,/g" -e "s/,18)/,17)/g" \
	-e "s/(19,/(18,/g" -e "s/,19)/,18)/g" \
	> ${navPath}/ins_C_nb_euler.hpp

cat code/quad_wind_dynamics.f90 | sed \
	-e "s/$/;/g" \
	-e "s/(motor)/_motor/g" \
	-e "s/(T)/_T/g" \
	-e "s/(Q)/_Q/g" \
	-e "s/%//g" \
	-e "s/pi/%pi/g" \
	> ${sciPath}/quad_wind_dynamics.sci

cat code/quad_body_dynamics.f90 | sed \
	-e "s/$/;/g" \
	-e "s/(motor)/_motor/g" \
	-e "s/(T)/_T/g" \
	-e "s/(Q)/_Q/g" \
	-e "s/%//g" \
	-e "s/pi/%pi/g" \
	> ${sciPath}/quad_body_dynamics.sci

cat code/quadForceMoments.f90 | sed \
	-e "s/$/;/g" \
	-e "/^.*) = 0;$/d" \
	-e "s/%//g" \
	-e "s/(1,/(0,/g" -e "s/,1)/,0)/g" \
	-e "s/(2,/(1,/g" -e "s/,2)/,1)/g" \
	-e "s/(3,/(2,/g" -e "s/,3)/,2)/g" \
	-e "s/(4,/(3,/g" -e "s/,4)/,3)/g" \
	-e "s/(5,/(4,/g" -e "s/,5)/,4)/g" \
	-e "s/(6,/(5,/g" -e "s/,6)/,5)/g" \
	-e "s/(7,/(6,/g" -e "s/,7)/,6)/g" \
	-e "s/(8,/(7,/g" -e "s/,8)/,7)/g" \
	-e "s/(9,/(8,/g" -e "s/,9)/,8)/g" \
	-e "s/(10,/(9,/g" -e "s/,10)/,9)/g" \
	-e "s/(11,/(10,/g" -e "s/,11)/,10)/g" \
	-e "s/(12,/(11,/g" -e "s/,12)/,11)/g" \
	-e "s/(13,/(12,/g" -e "s/,13)/,12)/g" \
	-e "s/(14,/(13,/g" -e "s/,14)/,13)/g" \
	-e "s/(15,/(14,/g" -e "s/,15)/,14)/g" \
	-e "s/(16,/(15,/g" -e "s/,16)/,15)/g" \
	-e "s/(17,/(16,/g" -e "s/,17)/,16)/g" \
	-e "s/(18,/(17,/g" -e "s/,18)/,17)/g" \
	-e "s/(19,/(18,/g" -e "s/,19)/,18)/g" \
    -e "s/pi\*\*3/piPiPi/g" -e "s/pi\*\*2/piPi/g" -e "s/batVolt\*\*2/batVoltBatVolt/g" -e "s/KV\*\*2/KVKV/g" \
	-e "s/rBlade\*\*4/rBladeRBladeRBladeRBlade/g" -e "s/rBlade\*\*5/rBladeRBladeRBladeRBladeRBlade/g" -e "s/Vt\*\*2/VtVt/g" -e "s/(Q)/Q/g" \
    -e "s/(T)/T/g" -e "s/alpha\*\*2/alphaAlpha/g" \
	> ${dynPath}/quadForceMoments.hpp


cat code/d_x_wind.f90 | sed \
	-e "s/$/;/g" \
	-e "/^.*) = 0;$/d" \
	-e "s/%//g" \
	-e "s/(1,/(0,/g" -e "s/,1)/,0)/g" \
	-e "s/(2,/(1,/g" -e "s/,2)/,1)/g" \
	-e "s/(3,/(2,/g" -e "s/,3)/,2)/g" \
	-e "s/(4,/(3,/g" -e "s/,4)/,3)/g" \
	-e "s/(5,/(4,/g" -e "s/,5)/,4)/g" \
	-e "s/(6,/(5,/g" -e "s/,6)/,5)/g" \
	-e "s/(7,/(6,/g" -e "s/,7)/,6)/g" \
	-e "s/(8,/(7,/g" -e "s/,8)/,7)/g" \
	-e "s/(9,/(8,/g" -e "s/,9)/,8)/g" \
	-e "s/(10,/(9,/g" -e "s/,10)/,9)/g" \
	-e "s/(11,/(10,/g" -e "s/,11)/,10)/g" \
	-e "s/(12,/(11,/g" -e "s/,12)/,11)/g" \
	-e "s/(13,/(12,/g" -e "s/,13)/,12)/g" \
	-e "s/(14,/(13,/g" -e "s/,14)/,13)/g" \
	-e "s/(15,/(14,/g" -e "s/,15)/,14)/g" \
	-e "s/(16,/(15,/g" -e "s/,16)/,15)/g" \
	-e "s/(17,/(16,/g" -e "s/,17)/,16)/g" \
	-e "s/(18,/(17,/g" -e "s/,18)/,17)/g" \
	-e "s/(19,/(18,/g" -e "s/,19)/,18)/g" \
	-e "s/Jxy\*\*2/JxyJxy/g" -e "s/Jxz\*\*2/JxzJxz/g" -e "s/Jyz\*\*2/Jyz/g" -e "s/KV\*\*2/KVKV/g" \
    -e "s/(phi)/Phi/g" -e "s/(theta)/Theta/g" -e "s/(alpha)/Alpha/g" -e "s/(beta)/Beta/g" \
	> ${dynPath}/windDynamics.hpp


cat code/dynamicsBodyFrame.f90 | sed \
	-e "s/$/;/g" \
	-e "/^.*) = 0;$/d" \
	-e "s/%//g" \
	-e "s/(1,/(0,/g" -e "s/,1)/,0)/g" \
	-e "s/(2,/(1,/g" -e "s/,2)/,1)/g" \
	-e "s/(3,/(2,/g" -e "s/,3)/,2)/g" \
	-e "s/(4,/(3,/g" -e "s/,4)/,3)/g" \
	-e "s/(5,/(4,/g" -e "s/,5)/,4)/g" \
	-e "s/(6,/(5,/g" -e "s/,6)/,5)/g" \
	-e "s/(7,/(6,/g" -e "s/,7)/,6)/g" \
	-e "s/(8,/(7,/g" -e "s/,8)/,7)/g" \
	-e "s/(9,/(8,/g" -e "s/,9)/,8)/g" \
	-e "s/(10,/(9,/g" -e "s/,10)/,9)/g" \
	-e "s/(11,/(10,/g" -e "s/,11)/,10)/g" \
	-e "s/(12,/(11,/g" -e "s/,12)/,11)/g" \
	-e "s/(13,/(12,/g" -e "s/,13)/,12)/g" \
	-e "s/(14,/(13,/g" -e "s/,14)/,13)/g" \
	-e "s/(15,/(14,/g" -e "s/,15)/,14)/g" \
	-e "s/(16,/(15,/g" -e "s/,16)/,15)/g" \
	-e "s/(17,/(16,/g" -e "s/,17)/,16)/g" \
	-e "s/(18,/(17,/g" -e "s/,18)/,17)/g" \
	-e "s/(19,/(18,/g" -e "s/,19)/,18)/g" \
	-e "s/Jxy\*\*2/JxyJxy/g" -e "s/Jxz\*\*2/JxzJxz/g" -e "s/Jyz\*\*2/Jyz/g" -e "s/KV\*\*2/KVKV/g" \
	-e "s/(phi)/Phi/g" -e "s/(theta)/Theta/g" -e "s/(alpha)/Alpha/g" -e "s/(beta)/Beta/g" \
	> ${dynPath}/dynamicsBodyFrame.hpp

cat code/navigationEquations.f90 | sed \
	-e "s/$/;/g" \
	-e "/^.*) = 0;$/d" \
	-e "s/%//g" \
	-e "s/(1,/(0,/g" -e "s/,1)/,0)/g" \
	-e "s/(2,/(1,/g" -e "s/,2)/,1)/g" \
	-e "s/(3,/(2,/g" -e "s/,3)/,2)/g" \
	-e "s/(4,/(3,/g" -e "s/,4)/,3)/g" \
	-e "s/(5,/(4,/g" -e "s/,5)/,4)/g" \
	-e "s/(6,/(5,/g" -e "s/,6)/,5)/g" \
	-e "s/(7,/(6,/g" -e "s/,7)/,6)/g" \
	-e "s/(8,/(7,/g" -e "s/,8)/,7)/g" \
	-e "s/(9,/(8,/g" -e "s/,9)/,8)/g" \
	-e "s/(10,/(9,/g" -e "s/,10)/,9)/g" \
	-e "s/(11,/(10,/g" -e "s/,11)/,10)/g" \
	-e "s/(12,/(11,/g" -e "s/,12)/,11)/g" \
	-e "s/(13,/(12,/g" -e "s/,13)/,12)/g" \
	-e "s/(14,/(13,/g" -e "s/,14)/,13)/g" \
	-e "s/(15,/(14,/g" -e "s/,15)/,14)/g" \
	-e "s/(16,/(15,/g" -e "s/,16)/,15)/g" \
	-e "s/(17,/(16,/g" -e "s/,17)/,16)/g" \
	-e "s/(18,/(17,/g" -e "s/,18)/,17)/g" \
	-e "s/(19,/(18,/g" -e "s/,19)/,18)/g" \
    -e "s/(phi)/Phi/g" -e "s/(theta)/Theta/g" -e "s/(psi)/Psi/g" \
	> ${dynPath}/navigationEquations.hpp
