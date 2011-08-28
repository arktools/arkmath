/*
 * GeoMag.hpp
 * Copyright (C) James Goppert 2009 <jgoppert@users.sourceforge.net>
 *
 * GeoMag.hpp is free software: you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * GeoMag.hpp is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 * See the GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

/* PROGRAM MAGPOINT (GEOMAG DRIVER) */
/************************************************************************
     Contact Information

     Software and Model Support
     	National Geophysical Data Center
     	NOAA EGC/2
     	325 Broadway
     	Boulder, CO 80303 USA
     	Attn: Susan McLean or Stefan Maus
     	Phone:  (303) 497-6478 or -6522
     	Email:  Susan.McLean@noaa.gov or Stefan.Maus@noaa.gov
		Web: http://www.ngdc.noaa.gov/seg/WMM/

     Sponsoring Government Agency
	   National Geospatial-Intelligence Agency
    	   PRG / CSAT, M.S. L-41
    	   3838 Vogel Road
    	   Arnold, MO 63010
    	   Attn: Craig Rollins
    	   Phone:  (314) 263-4186
    	   Email:  Craig.M.Rollins@Nga.Mil

      Original Program By:
        Dr. John Quinn
        FLEET PRODUCTS DIVISION, CODE N342
        NAVAL OCEANOGRAPHIC OFFICE (NAVOCEANO)
        STENNIS SPACE CENTER (SSC), MS 39522-5001

        3/25/05 Stefan Maus corrected 2 bugs:
         - use %c instead of %s for character read
         - help text: positive inclination is downward
		8/9/09 James Goppert
		 - restructured file into a C++ class
*/

#ifndef GeoMag_H
#define GeoMag_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <string>
#define NaN log(-1.0)

namespace mavsim
{

class GeoMag
{
private:
    // Variables
    int maxord,i,icomp,n,m,j,D1,D2,D3,D4;
    float c[13][13],cd[13][13],tc[13][13],dp[13][13],snorm[169],
    sp[13],cp[13],fn[13],fm[13],pp[13],k[13][13],pi,dtr,a,b,re,
    a2,b2,c2,a4,b4,c4,epoch,gnm,hnm,dgnm,dhnm,flnmj,otime,oalt,
    olat,olon,dt,rlon,rlat,srlon,srlat,crlon,crlat,srlat2,
    crlat2,q,q1,q2,ct,st,r2,r,d,ca,sa,aor,ar,br,bt,bp,bpp,
    par,temp1,temp2,parp,bx,by,bz,bh;
    char model[20], c_str[81], c_new[5];
    float *p;
    FILE * wmmdat;
public:
    GeoMag(std::string file, int maxDeg);
    virtual ~GeoMag();
    void update(float alt, float glat, float glon, float time);
    float dec, dip; // in degrees
	float ti, gv;
};

}

#endif

// vim:ts=4:sw=4
