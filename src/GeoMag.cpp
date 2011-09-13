/*
 * GeoMag.cpp
 * Copyright (C) James Goppert 2009 <jgoppert@users.sourceforge.net>
 *
 * GeoMag.cpp is free software: you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * GeoMag.cpp is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 * See the GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#include "GeoMag.hpp"
#include <stdexcept>

namespace mavsim
{

GeoMag::GeoMag(std::string file, int maxDeg)
{
    wmmdat = fopen(file.c_str(),"r");
	if (wmmdat == NULL) throw std::runtime_error("unable to load magnetic coefficients file: " + file);
    p = snorm;

    /* INITIALIZE CONSTANTS */
    pi = 3.14159265359;
    maxord = maxDeg;
    sp[0] = 0.0;
    cp[0] = *p = pp[0] = 1.0;
    dp[0][0] = 0.0;
    a = 6378.137;
    b = 6356.7523142;
    re = 6371.2;
    a2 = a*a;
    b2 = b*b;
    c2 = a2-b2;
    a4 = a2*a2;
    b4 = b2*b2;
    c4 = a4 - b4;

    /* READ WORLD MAGNETIC MODEL SPHERICAL HARMONIC COEFFICIENTS */
    c[0][0] = 0.0;
    cd[0][0] = 0.0;

    fgets(c_str, 80, wmmdat);
    sscanf(c_str,"%f%s",&epoch,model);
S3:
    fgets(c_str, 80, wmmdat);
    /* CHECK FOR LAST LINE IN FILE */
    for (i=0; i<4 && (c_str[i] != '\0'); i++)
    {
        c_new[i] = c_str[i];
        c_new[i+1] = '\0';
    }
    icomp = strcmp("9999", c_new);
    if (icomp == 0) goto S4;
    /* END OF FILE NOT ENCOUNTERED, GET VALUES */
    sscanf(c_str,"%d%d%f%f%f%f",&n,&m,&gnm,&hnm,&dgnm,&dhnm);
    if (m <= n)
    {
        c[m][n] = gnm;
        cd[m][n] = dgnm;
        if (m != 0)
        {
            c[n][m-1] = hnm;
            cd[n][m-1] = dhnm;
        }
    }
    goto S3;

    /* CONVERT SCHMIDT NORMALIZED GAUSS COEFFICIENTS TO UNNORMALIZED */
S4:
    *snorm = 1.0;
    for (n=1; n<=maxord; n++)
    {
        *(snorm+n) = *(snorm+n-1)*(float)(2*n-1)/(float)n;
        j = 2;
        for (m=0,D1=1,D2=(n-m+D1)/D1; D2>0; D2--,m+=D1)
        {
            k[m][n] = (float)(((n-1)*(n-1))-(m*m))/(float)((2*n-1)*(2*n-3));
            if (m > 0)
            {
                flnmj = (float)((n-m+1)*j)/(float)(n+m);
                *(snorm+n+m*13) = *(snorm+n+(m-1)*13)*sqrt(flnmj);
                j = 1;
                c[n][m-1] = *(snorm+n+m*13)*c[n][m-1];
                cd[n][m-1] = *(snorm+n+m*13)*cd[n][m-1];
            }
            c[m][n] = *(snorm+n+m*13)*c[m][n];
            cd[m][n] = *(snorm+n+m*13)*cd[m][n];
        }
        fn[n] = (float)(n+1);
        fm[n] = (float)n;
    }
    k[1][1] = 0.0;

    otime = oalt = olat = olon = -1000.0;
    fclose(wmmdat);
}


void GeoMag::update(float alt, float glat, float glon, float time)
{
    alt = alt/1000; // conver altitude to km
    dt = time - epoch;
    if (otime < 0.0 && (dt < 0.0 || dt > 5.0))
    {
        printf("\n\n WARNING - TIME EXTENDS BEYOND MODEL 5-YEAR LIFE SPAN");
        printf("\n CONTACT NGDC FOR PRODUCT UPDATES:");
        printf("\n         National Geophysical Data Center");
        printf("\n         NOAA EGC/2");
        printf("\n         325 Broadway");
        printf("\n         Boulder, CO 80303 USA");
        printf("\n         Attn: Susan McLean or Stefan Maus");
        printf("\n         Phone:  (303) 497-6478 or -6522");
        printf("\n         Email:  Susan.McLean@noaa.gov");
        printf("\n         or");
        printf("\n         Stefan.Maus@noaa.gov");
        printf("\n         Web: http://www.ngdc.noaa.gov/seg/WMM/");
        printf("\n\n EPOCH  = %.3lf",epoch);
        printf("\n TIME   = %.3lf",time);
    }

    dtr = pi/180.0;
    rlon = glon*dtr;
    rlat = glat*dtr;
    srlon = sin(rlon);
    srlat = sin(rlat);
    crlon = cos(rlon);
    crlat = cos(rlat);
    srlat2 = srlat*srlat;
    crlat2 = crlat*crlat;
    sp[1] = srlon;
    cp[1] = crlon;

    /* CONVERT FROM GEODETIC COORDS. TO SPHERICAL COORDS. */
    if (alt != oalt || glat != olat)
    {
        q = sqrt(a2-c2*srlat2);
        q1 = alt*q;
        q2 = ((q1+a2)/(q1+b2))*((q1+a2)/(q1+b2));
        ct = srlat/sqrt(q2*crlat2+srlat2);
        st = sqrt(1.0-(ct*ct));
        r2 = (alt*alt)+2.0*q1+(a4-c4*srlat2)/(q*q);
        r = sqrt(r2);
        d = sqrt(a2*crlat2+b2*srlat2);
        ca = (alt+d)/r;
        sa = c2*crlat*srlat/(r*d);
    }
    if (glon != olon)
    {
        for (m=2; m<=maxord; m++)
        {
            sp[m] = sp[1]*cp[m-1]+cp[1]*sp[m-1];
            cp[m] = cp[1]*cp[m-1]-sp[1]*sp[m-1];
        }
    }
    aor = re/r;
    ar = aor*aor;
    br = bt = bp = bpp = 0.0;
    for (n=1; n<=maxord; n++)
    {
        ar = ar*aor;
        for (m=0,D3=1,D4=(n+m+D3)/D3; D4>0; D4--,m+=D3)
        {
            /*
               COMPUTE UNNORMALIZED ASSOCIATED LEGENDRE POLYNOMIALS
               AND DERIVATIVES VIA RECURSION RELATIONS
            */
            if (alt != oalt || glat != olat)
            {
                if (n == m)
                {
                    *(p+n+m*13) = st**(p+n-1+(m-1)*13);
                    dp[m][n] = st*dp[m-1][n-1]+ct**(p+n-1+(m-1)*13);
                    goto S50;
                }
                if (n == 1 && m == 0)
                {
                    *(p+n+m*13) = ct**(p+n-1+m*13);
                    dp[m][n] = ct*dp[m][n-1]-st**(p+n-1+m*13);
                    goto S50;
                }
                if (n > 1 && n != m)
                {
                    if (m > n-2) *(p+n-2+m*13) = 0.0;
                    if (m > n-2) dp[m][n-2] = 0.0;
                    *(p+n+m*13) = ct**(p+n-1+m*13)-k[m][n]**(p+n-2+m*13);
                    dp[m][n] = ct*dp[m][n-1] - st**(p+n-1+m*13)-k[m][n]*dp[m][n-2];
                }
            }
S50:
            /*
                TIME ADJUST THE GAUSS COEFFICIENTS
            */
            if (time != otime)
            {
                tc[m][n] = c[m][n]+dt*cd[m][n];
                if (m != 0) tc[n][m-1] = c[n][m-1]+dt*cd[n][m-1];
            }
            /*
                ACCUMULATE TERMS OF THE SPHERICAL HARMONIC EXPANSIONS
            */
            par = ar**(p+n+m*13);
            if (m == 0)
            {
                temp1 = tc[m][n]*cp[m];
                temp2 = tc[m][n]*sp[m];
            }
            else
            {
                temp1 = tc[m][n]*cp[m]+tc[n][m-1]*sp[m];
                temp2 = tc[m][n]*sp[m]-tc[n][m-1]*cp[m];
            }
            bt = bt-ar*temp1*dp[m][n];
            bp += (fm[m]*temp2*par);
            br += (fn[n]*temp1*par);
            /*
                SPECIAL CASE:  NORTH/SOUTH GEOGRAPHIC POLES
            */
            if (st == 0.0 && m == 1)
            {
                if (n == 1) pp[n] = pp[n-1];
                else pp[n] = ct*pp[n-1]-k[m][n]*pp[n-2];
                parp = ar*pp[n];
                bpp += (fm[m]*temp2*parp);
            }
        }
    }
    if (st == 0.0) bp = bpp;
    else bp /= st;
    /*
        ROTATE MAGNETIC VECTOR COMPONENTS FROM SPHERICAL TO
        GEODETIC COORDINATES
    */
    bx = -bt*ca-br*sa;
    by = bp;
    bz = bt*sa-br*ca;
    /*
        COMPUTE DECLINATION (DEC), INCLINATION (DIP) AND
        TOTAL INTENSITY (TI)
    */
    bh = sqrt((bx*bx)+(by*by));
    ti = sqrt((bh*bh)+(bz*bz));
    dec = atan2(by,bx)/dtr;
    dip = atan2(bz,bh)/dtr;
    /*
        COMPUTE MAGNETIC GRID VARIATION IF THE CURRENT
        GEODETIC POSITION IS IN THE ARCTIC OR ANTARCTIC
        (I.E. GLAT > +55 DEGREES OR GLAT < -55 DEGREES)

    TO -999.0
    */
    gv = -999.0;
    if (fabs(glat) >= 55.)
    {
        if (glat > 0.0 && glon >= 0.0) gv = dec-glon;
        if (glat > 0.0 && glon < 0.0) gv = dec+fabs(glon);
        if (glat < 0.0 && glon >= 0.0) gv = dec+glon;
        if (glat < 0.0 && glon < 0.0) gv = dec-fabs(glon);
        if (gv > +180.0) gv -= 360.0;
        if (gv < -180.0) gv += 360.0;
    }
    otime = time;
    oalt = alt;
    olat = glat;
    olon = glon;
    return;
}

GeoMag::~GeoMag()
{
}

}
// vim:ts=4:sw=4
