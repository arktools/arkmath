#!/bin/bash

function usage
{
	echo usage: 
	echo $0 m : run with maxima and generate $f90Path
	echo $0 n : generated $f90Path
}

sciPath=../src/gen_sci
outPath=../src/gen_cpp
f90Path=../src/gen_fortran

if [ $# == 1 ]
then
	if [ $1 == 'm' ]
	then
		echo running maxima
		if [ -d $f90Path ]; then rm -rf $f90Path; fi
		mkdir $f90Path
		maxima -b dynamicsWindFrame.wxm
		maxima -b dyanmicsBodyFrame.wxm
		maxima -b navigation.wxm
		maxima -b navigationEquations.wxm
		maxima -b quadrotorWindFrame.wxm
		maxima -b quadrotorBodyFrame.wxm
		maxima -b quadrotorForceMoment.wxm
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

if [ -d $outPath ]; then rm -rf $outPath; fi
mkdir $outPath
if [ -d $sciPath ]; then rm -rf $sciPath; fi
mkdir $sciPath

cat $f90Path/ins_dynamics_f.f90 | sed \
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
	> ${outPath}/ins_dynamics_f.hpp

cat $f90Path/ins_dynamics_f_att.f90 | sed \
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
	> ${outPath}/ins_dynamics_f_att.hpp

cat $f90Path/ins_dynamics_f_vp.f90 | sed \
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
	> ${outPath}/ins_dynamics_f_vp.hpp

cat $f90Path/ins_error_dynamics_F.f90 | sed \
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
	> ${outPath}/ins_error_dynamics_F.hpp

cat $f90Path/ins_error_dynamics_F_att.f90 | sed \
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
	> ${outPath}/ins_error_dynamics_F_att.hpp

cat $f90Path/ins_error_dynamics_F_vp.f90 | sed \
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
	> ${outPath}/ins_error_dynamics_F_vp.hpp

cat $f90Path/ins_error_dynamics_G.f90 | sed \
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
	> ${outPath}/ins_error_dynamics_G.hpp

cat $f90Path/ins_error_dynamics_G_att.f90 | sed \
	-e "s/$/;/g" \
	-e "/^.*) = 0;$/d" \
	-e "s/a\*\*2/aa/g" -e "s/b\*\*2/bb/g" -e "s/c\*\*2/cc/g" -e "s/d\*\*2/dd/g" \
	-e "s/a\*\*3/aaa/g" -e "s/b\*\*3/bbb/g" -e "s/c\*\*3/ccc/g" -e "s/d\*\*3/ddd/g" \
	-e "s/cos(L)/cosL/g" -e "s/sin(L)/sinL/g" -e "s/tan(L)/tanL/g" \
	-e "s/sec(L)/secL/g" \
	-e "s/secL\**2/secLsecL/g" \
	-e "s/R\*\*2/RR/g" \
	-e "s/cosL\*\*2/cosLcosL/g" \
	> ${outPath}/ins_error_dynamics_G_att.hpp

cat $f90Path/ins_error_dynamics_G_vp.f90 | sed \
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
	> ${outPath}/ins_error_dynamics_G_vp.hpp

cat $f90Path/z_mag.f90 | sed \
	-e "s/$/;/g" \
	-e "/^.*) = 0;$/d" \
	-e "s/a\*\*2/aa/g" -e "s/b\*\*2/bb/g" -e "s/c\*\*2/cc/g" -e "s/d\*\*2/dd/g" \
	-e "s/(1,/(0,/g" -e "s/,1)/,0)/g" \
	-e "s/(2,/(1,/g" -e "s/,2)/,1)/g" \
	-e "s/(3,/(2,/g" -e "s/,3)/,2)/g" \
	> ${outPath}/z_mag.hpp

cat $f90Path/mag_dec_dip.f90 | sed \
	-e "s/$/;/g" \
	-e "/^.*) = 0;$/d" \
	-e "s/cos(dec)/cosDec/g" -e "s/sin(dec)/sinDec/g" \
	-e "s/cos(dip)/cosDip/g" -e "s/sin(dip)/sinDip/g" \
	-e "s/a\*\*2/aa/g" -e "s/b\*\*2/bb/g" -e "s/c\*\*2/cc/g" -e "s/d\*\*2/dd/g" \
	-e "s/(1,/(0,/g" -e "s/,1)/,0)/g" \
	-e "s/(2,/(1,/g" -e "s/,2)/,1)/g" \
	-e "s/(3,/(2,/g" -e "s/,3)/,2)/g" \
	> ${outPath}/mag_dec_dip.hpp

cat $f90Path/ins_H_mag.f90 | sed \
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
	> ${outPath}/ins_H_mag.hpp


cat $f90Path/ins_H_mag_att.f90 | sed \
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
	> ${outPath}/ins_H_mag_att.hpp

cat $f90Path/ins_R_mag_n.f90 | sed \
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
	> ${outPath}/ins_R_mag_n.hpp

cat $f90Path/ins_H_gps.f90 | sed \
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
	> ${outPath}/ins_H_gps.hpp

cat $f90Path/ins_H_gps_vp.f90 | sed \
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
	> ${outPath}/ins_H_gps_vp.hpp

cat $f90Path/ins_R_gps.f90 | sed \
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
	> ${outPath}/ins_R_gps.hpp

cat $f90Path/ins_C_nb_quat.f90 | sed \
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
	> ${outPath}/ins_C_nb_quat.hpp

cat $f90Path/ins_C_nb_euler.f90 | sed \
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
	> ${outPath}/ins_C_nb_euler.hpp

cat $f90Path/quad_wind_dynamics.f90 | sed \
	-e "s/$/;/g" \
	-e "s/(motor)/_motor/g" \
	-e "s/(T)/_T/g" \
	-e "s/(Q)/_Q/g" \
	-e "s/%//g" \
	-e "s/pi/%pi/g" \
	> ${sciPath}/quad_wind_dynamics.sci

cat $f90Path/quad_body_dynamics.f90 | sed \
	-e "s/$/;/g" \
	-e "s/(motor)/_motor/g" \
	-e "s/(T)/_T/g" \
	-e "s/(Q)/_Q/g" \
	-e "s/%//g" \
	-e "s/pi/%pi/g" \
	> ${sciPath}/quad_body_dynamics.sci

cat $f90Path/quadForceMoments.f90 | sed \
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
	> ${outPath}/quadForceMoments.hpp


cat $f90Path/d_x_wind.f90 | sed \
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
	> ${outPath}/windDynamics.hpp


cat $f90Path/dynamicsBodyFrame.f90 | sed \
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
	> ${outPath}/dynamicsBodyFrame.hpp

cat $f90Path/navigationEquations.f90 | sed \
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
	> ${outPath}/navigationEquations.hpp
