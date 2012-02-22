/*
 * GpsIns.cpp
 * Copyright (C) Brandon Wampler <brandon.wampler@gmail.com>
 *
 * GpsIns.cpp is free software: you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * GpsIns.cpp is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 * See the GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
#include "GpsIns.hpp"
#include <boost/numeric/ublas/matrix_proxy.hpp>
#include <boost/numeric/ublas/vector_proxy.hpp>
#include "utilities.hpp"

namespace arkmath
{
	const double GpsIns::R0 = 6.3781e6; //earth radius in meters
	const double GpsIns::w = 7.292115e-5; //earth rotation rate in radians
	const double GpsIns::g0=9.81;

    GpsIns::GpsIns(double lat, double lon, double height, //
	   	double roll, double pitch, double yaw, //
		double Vn, double Ve, double Vd, //
		double sigmaPos, double sigmaAlt, double sigmaVel, //
		double sigmaAccelG, double sigmaGyro, bool useGravity): //
		sigmaDegLat(sigmaPos/111131.745*M_PI/180.0), sigmaH(sigmaAlt), sigmaV(sigmaVel), sigmaAccel(sigmaAccelG*g0), sigmaGyro(sigmaGyro)
{
    //sigmaDegLat = sigmaPos/111131.745*M_PI/180.0; //10 meters expressed as radians of latitude uncertainty
    //sigmaAccel = .01*g0; //1 milli g accell uncertainty
    //sigmaGyro = 2*M_PI/180; //1 deg/sec rate uncertainty
    //sigmaH = 10; //meters
    //sigmaV = 0.2; //meters/sec
    sigmaDeg = .001*M_PI/180; //1 deg attitude uncertainty

    jFreq = 500;
    kFreq = 100;
    lFreq = 10;
    gFreq = 1;
    integrateIndex=0;

    dt_j = dt_k = dt_l = dt_g = 0;
    kQuat = 1;
    g = zero_vector<double>(3);
    if(useGravity) g(2) = g0;

    v = zero_vector<double>(3);
    sigma = zero_vector<double>(3);
    alfa = zero_vector<double>(3);
    deltaAlfa = zero_vector<double>(3);
    zeta = zero_vector<double>(3);

    q = zero_vector<double>(4);
    vn(0) = Vn;
	vn(1) = Ve;
	vn(2) = Vd;
    vnk = zero_vector<double>(3);
    vnkMinus = zero_vector<double>(3);
    r = zero_vector<double>(4);
    p = zero_vector<double>(4);
    un = zero_vector<double>(3);
    unCrossIntegral = zero_vector<double>(3);
    xn = zero_vector<double>(3);
    xnk = zero_vector<double>(3);
    xnkMinus = zero_vector<double>(3);
    w_en = w_ie = zero_vector<double>(3);

    eulerAtt(0) = roll;
    eulerAtt(1) = pitch;
    eulerAtt(2) = yaw;
    q = euler2Quat(eulerAtt);

    latLonH(0) = lat;
    latLonH(1) = lon;
    latLonH(2) = height;

    qLatLon = latLon2Quat(lat, lon);

    //GPS-INS filter variables
    Sigma = zero_vector<double>(3); //incremental sum of body rotation
    Un = zero_vector<double>(3); //incremental sum of change in velocity
    Zeta = zero_vector<double>(3); //incremental sum of navigation frame rotation

    H = zero_matrix<double>(6,9);
    Fc = zero_matrix<double>(9,9);
    Fd = zero_matrix<double>(9,9);
    Frr = Frv = Fvr = Fvv = zero_matrix<double>(3,3);
    Fqr = zero_matrix<double>(3,3);
    Fqv = zero_matrix<double>(3,3);
    fnX = zero_matrix<double>(3,3);
    w_inX = zero_matrix<double>(3,3);

    //Noise Matrices

    G = zero_matrix<double>(9,6);
    Q = zero_matrix<double>(6,6);
    Qk = zero_matrix<double>(9,9);
    Rk = zero_matrix<double>(6,6);
    subrange(Q, 0,3, 0,3) = sigmaAccel*sigmaAccel*identity_matrix<double>(3);//accel noise
    subrange(Q, 3,6, 3,6) = sigmaGyro*sigmaGyro*identity_matrix<double>(3);//qyro noise

    P = zero_matrix<double>(9,9);
    P(0,0) = R0*R0*sigmaDegLat*sigmaDegLat;
    P(1,1) = R0*R0*sigmaDegLat*sigmaDegLat*cos(latLonH(0))*cos(latLonH(0));
    P(2,2) = sigmaH*sigmaH;
    P(3,3) = sigmaV*sigmaV;
    P(4,4) = sigmaV*sigmaV;
    P(5,5) = sigmaV*sigmaV;
    P(6,6) = sigmaDeg*sigmaDeg;
    P(7,7) = sigmaDeg*sigmaDeg;
    P(8,8) = sigmaDeg*sigmaDeg;

    //Time
    time = time_j = time_k = time_l= time_g = time_0 = boost::posix_time::microsec_clock::universal_time();
    elapsed=0;
    I3 = identity_matrix<double>(3);
}

void GpsIns::updateAll(double fbx, double fby, double fbz, double wbx, double wby, double wbz, double lat, double lon, double alt, double Vn, double Ve, double Vd)
{
	vector<double> fb(3), wb(3), z(6);
	fb(0) = fbx;
	fb(1) = fby;
	fb(2) = fbz;
	wb(0) = wbx;
	wb(1) = wby;
	wb(2) = wbz;
	z(0) = lat;
	z(1) = lon;
	z(2) = alt;
	z(3) = Vn;
	z(4) = Ve;
	z(5) = Vd;

	updateFast(fb,wb);
	updateMed();
	updateSlow();
	updateGps(z);
}

void GpsIns::updateFast(const ublas::vector<double> &fb, const ublas::vector<double> &wbIn)
{
    //calculate elapsed time for each cycle
    time = boost::posix_time::microsec_clock::universal_time();

    diff_j = time-time_j;
    dt_j = diff_j.total_microseconds()/1e6;

    if (dt_j >= 1.0/jFreq)
    {
        time_j=time;
		
		bounded_vector<double,3> wb;
		wb = wbIn ;//+ quatRotate(q,w_ie);

        alfa += wb*dt_j;
        deltaAlfa+=crossProd(alfa,wb)*dt_j;

        v+=fb*dt_j;
        unCrossIntegral+=(crossProd(alfa,fb)-crossProd(wb,v))*dt_j;
        //std::cout<<"j-cycle Hz: "<<1.0/dt_j<<std::endl;
    }
}

void GpsIns::updateMed()
{
    time = boost::posix_time::microsec_clock::universal_time();
    diff_k = time-time_k;
    dt_k = diff_k.total_microseconds()/1e6;

    if (dt_k>=1.0/kFreq)
    {
        h = latLonH(2);
        time_k=time;
        sigma = alfa+deltaAlfa;
        Sigma += sigma;

        sigmaNorm = norm_2(sigma);
        ac=cos(sigmaNorm/2.0);
        if (sigmaNorm<1e-100) as = 0;
        else as=sin(sigmaNorm/2.0)/sigmaNorm;
        r(0)=ac;
        r(1)=as*sigma(0);
        r(2)=as*sigma(1);
        r(3)=as*sigma(2);
        q = quatProd(q,r);
        //q+=q*kQuat*(1-(q(0)*q(0) + q(1)*q(1) + q(2)*q(2) + q(3)*q(3)));
        //std::cout<<"Euler: "<<quat2Euler(q)*180/M_PI<<std::endl;

        un = v + 0.5*crossProd(alfa,v) + 0.5*unCrossIntegral;
        un = quatRotate(q,un);
        Un += un;

        xnkMinus = xnk;
        xnk = xn;

        vnkMinus = vnk;
        vnk = vn;
        vn += un + g*(R0/(R0+h))*(R0/(R0+h))*dt_k;

        if (integrateIndex == 2)
        {
            xn = xnkMinus + ((vnkMinus + 4*vnk + vn)/3.0)*dt_k;
            //std::cout<<"vnkMinus: "<<vnkMinus<<std::endl;
            //std::cout<<"vnk: "<<vnk<<std::endl;
            //std::cout<<"vn: "<<vn<<std::endl;
        }
        else if (integrateIndex == 1) xn+= ((vnk+vn)/2.0)*dt_k, integrateIndex++;
        else if (integrateIndex == 0) xn+= vnk*dt_k, integrateIndex++;

        latLonH(0) += vn(0)*dt_k/(R0+h);
        latLonH(1) += vn(1)*dt_k/(cos(latLonH(0))*(R0+h));
        latLonH(2) += -vn(2)*dt_k;
        h = latLonH(2);

        w_en(0) = vn(1)/(R0+h);
        w_en(1) = -vn(0)/(R0+h);
        w_en(2) = -vn(1)*tan(latLonH(0))/(R0+h);
        zeta+=w_en*dt_k;
        Zeta+=zeta;
        //reset integrating terms
        alfa = deltaAlfa = v = unCrossIntegral = zero_vector<double>(3);

        //std::cout<<"k-cycle Hz: "<<1.0/dt_k<<std::endl;
    }
}

void GpsIns::updateSlow()
{
    time = boost::posix_time::microsec_clock::universal_time();
    diff_l = time-time_l;
    dt_l = diff_l.total_microseconds()/1e6;

    if(dt_l>=1.0/lFreq)
    {
        time_l=time;
        diff_0 = time - time_0;
        elapsed = diff_0.total_microseconds()/1e6;
        //std::cout<<"Elapsed: "<<elapsed<<std::endl;

        //coriolis correction
        w_ie(0) = w*cos(latLonH(0));
        w_ie(1) = 0;
        w_ie(2) = w*sin(latLonH(0));

        vn =  prod((I3 - 2.0*cross(w_ie)*dt_l - cross(zeta)),vn);

        //rotating navigation frame correction
        zetaNorm = norm_2(zeta);
        bc=cos(zetaNorm/2.0);
        if (zetaNorm<1e-100) bs = 0;
        else bs=sin(zetaNorm/2.0)/zetaNorm;
        p(0)=bc;
        p(1)=bs*zeta(0);
        p(2)=bs*zeta(1);
        p(3)=bs*zeta(2);
        q = quatProd(quatConj(p),q);
        qLatLon = quatProd(p,qLatLon);

        //std::cout<<"P Euler: "<<quat2Euler(p)<<std::endl;
        //std::cout<<"P Quat: "<<p<<std::endl;
        //std::cout<<"QLATLON: "<<quat2Euler(qLatLon)*180/M_PI<<std::endl;
        //std::cout<<"Q LAT LON H: "<<quat2LatLon(qLatLon)<<std::endl;
        //std::cout<<"LAT LON H: "<<latLonH*180/M_PI<<" "<<h<<std::endl;

        //quaternion normilatization
        q+=q*kQuat*(1-(q(0)*q(0) + q(1)*q(1) + q(2)*q(2) + q(3)*q(3)));
        qLatLon+=qLatLon*kQuat*(1-(qLatLon(0)*qLatLon(0) + qLatLon(1)*qLatLon(1) + qLatLon(2)*qLatLon(2) + qLatLon(3)*qLatLon(3)));
        subrange(latLonH, 0,2) = quat2LatLon(qLatLon);
        //std::cout<<"l-cycle Hz: "<<1.0/dt_l<<std::endl;

        //std::cout<<"Pos: "<<xn<<std::endl;
        //std::cout<<"LAT LON H: "<<latLonH(0)*180/M_PI<<" "<<latLonH(1)*180/M_PI<<" "<<latLonH(2)<<std::endl;
        //std::cout<<"Vel: "<<vn<<std::endl;
        //std::cout<<"Att: "<<quat2Euler(q)*180/M_PI<<std::endl;
        //std::cout<<std::endl;

        //reset integration term
        zeta = zero_vector<double>(3);
    }
}

void GpsIns::updateGps(const vector<double> &z)
{
    time = boost::posix_time::microsec_clock::universal_time();
    diff_g = time-time_g;
    dt_g = diff_g.total_microseconds()/1e6;
    if(dt_g>=gFreq)
    {
        time_g=time;
        double cosLat = cos(latLonH(0));
        double tanLat = tan(latLonH(0));
        double sinLat = sin(latLonH(0));
        double R = R0+latLonH(2);
        double vN = vn(0);
        double vE = vn(1);
        double vD = vn(2);

        //Fill out Fc and Fd
        Frr(0,0)=0 	,Frr(0,1)=0 	, Frr(0,2)=-vN/(R*R);
        Frr(1,0)=vE*sinLat/(R*cosLat*cosLat) 	, Frr(1,1)=0 	, Frr(1,2)= -vE/(R*R*cosLat*cosLat);
        Frr(2,0)=0 	,Frr(2,1)=0 	, Frr(2,2)=0 	;

        Frv(0,0)=1.0/R	, Frv(0,1)=0 	, Frv(0,2)= 0	;
        Frv(1,0)=0 	, Frv(1,1)= 1.0/(R*cosLat)	, Frv(1,2)=0 	;
        Frv(2,0)= 0	, Frv(2,1)= 0	, Frv(2,2)= -1 	;

        Fvr(0,0)= -2*w*vE*cosLat-vE*vE/(R*cosLat*cosLat)	, Fvr(0,1)=0 	, Fvr(0,2)= -vN*vD/(R*R) + vE*vE*tanLat/(R*R);
        Fvr(1,0)= -2*w*(sinLat*vD-vN*cosLat) - vE*vN/(R*cosLat*cosLat)	, Fvr(1,1)=0 	, Fvr(1,2)= -(vD*vE/(R*R) + vE*vN*tanLat/(R*R))	;
        Fvr(2,0)= 2*w*vE*sinLat	, Fvr(2,1)=0 	, Fvr(2,2)= vE*vE/(R*R) + vN*vN/(R*R) - 2*g0*((R0*R0/(R*R))/(R))	;

        Fvv(0,0)=vD/R 	, Fvv(0,1)=-2*w*sinLat-2*vE*tanLat/R 	, Fvv(0,2)=vN/R	;
        Fvv(1,0)= -(-2*w*sinLat-vE*tanLat/R) , Fvv(1,1)= -(-vD/R-vN*tanLat/R)	, Fvv(1,2)= -(-2*w*cosLat-vE/R)	;
        Fvv(2,0)= -2*vN/R	, Fvv(2,1)= -2*w*cosLat-2*vE/R	, Fvv(2,2)= 0	;
        //my derivation
        //Fvr(0,0)= -2*w*vE*cosLat-vE*vE/(R*cosLat*cosLat)	, Fvr(0,1)=0 	, Fvr(0,2)= -vN*vD/(R*R) + vE*vE*tanLat/(R*R);
        //Fvr(1,0)= 2*w*(sinLat*vD-vN*cosLat) - vE*vN/(R*cosLat*cosLat)	, Fvr(1,1)=0 	, Fvr(1,2)= vD*vE/(R*R) + vE*vN*tanLat/(R*R)	;
        //Fvr(2,0)= 2*w*vE*sinLat	, Fvr(2,1)=0 	, Fvr(2,2)= vE*vE/(R*R) + vN*vN/(R*R) - 2*g0*((R0*R0/(R*R))/(R))	;

        //Fvv(0,0)=vD/R 	, Fvv(0,1)=-2*w*sinLat-2*vE*tanLat/R 	, Fvv(0,2)=vN/R	;
        //Fvv(1,0)= -2*w*sinLat-vE*tanLat/R , Fvv(1,1)= -vD/R-vN*tanLat/R	, Fvv(1,2)= -2*w*cosLat-vE/R	;
        //Fvv(2,0)= -2*vN/R	, Fvv(2,1)= -2*w*cosLat-2*vE/R	, Fvv(2,2)= 0	;

        Fqr(0,0)=-w*sinLat	, Fqr(0,1)=0 	, Fqr(0,2)= -vE/(R*R)	;
        Fqr(1,0)=0 	, Fqr(1,1)= 1.0/(R*cosLat)	, Fqr(1,2)= vN/(R*R) 	;
        Fqr(2,0)= -w*cosLat-vE/(R*R*cosLat*cosLat)	, Fqr(2,1)= 0	, Fqr(2,2)= vE*tanLat/(R*R) 	;

        Fqv(0,0)=0	, Fqv(0,1)=1/R 	, Fqv(0,2)= 0	;
        Fqv(1,0)=0 	, Fqv(1,1)=0	, Fqv(1,2)= 0 	;
        Fqv(2,0)=0	, Fqv(2,1)=-tanLat/R	, Fqv(2,2)= 0 ;

        fnX = cross(Un/dt_g);
        w_inX = cross((Zeta+Sigma)/dt_g);

        subrange(Fc, 0,3,  0,3) = Frr, subrange(Fc, 0,3,  3,6) = Frv;
        subrange(Fc, 3,6,  0,3) = Fvr, subrange(Fc, 3,6,  3,6) = Fvv, subrange(Fc, 3,6,  6,9) = fnX;
        subrange(Fc, 6,9, 0,3) = Fqr, subrange(Fc, 6,9, 3,6) = Fqv, subrange(Fc, 6,9, 6,9) = -w_inX;

        Fd = identity_matrix<double>(Fc.size1(), Fc.size2()) + Fc*dt_g + 0.5*prod(Fc*dt_g,Fc*dt_g);

        //Fill out G and Rk
        subrange(G, 3,6, 0,3) = quat2Dcm(q);
        subrange(G, 6,9, 3,6) = -quat2Dcm(q);
        Qk = 0.5*(prod(Fd,prod3(G,Q,trans(G))) + prod(prod3(G,Q,trans(G)),trans(Fd)))*dt_g;

        //Fill out measurement matrix and Qk
        H(0,0) = R;
        H(1,1) = R*cosLat;
        H(2,2) = H(3,3) = H(4,4) = H(5,5) = 1.0;

        Rk(0,0) = R*R*sigmaDeg*sigmaDeg;
        Rk(1,1) = R*R*sigmaDeg*sigmaDeg*cosLat*cosLat;
        Rk(2,2) = sigmaH*sigmaH;
        Rk(3,3) = sigmaV*sigmaV;
        Rk(4,4) = sigmaV*sigmaV;
        Rk(5,5) = sigmaV*sigmaV;

        //Kalman Filter
        //Predict Covariance
        P =prod3(Fd,P,trans(Fd))+Qk;

        //kalman gain
        inverse = prod3(H,P,trans(H))+Rk;
        inverse = inv(inverse); // don't use pinv since it is square
        kalman = prod3(P,trans(H),inverse);

        //correct xErr and P
        //TODO
        xErr = prod(kalman,z);
        P =prod(identity_matrix<double>(9)-prod(kalman,H) , P);

        //std::cout<<"xErr: "<<xErr<<std::endl;
        qLatLonCorrection = latLon2Quat(xErr(0), xErr(1));
        qLatLon = quatProd(quatConj(qLatLonCorrection),qLatLon);
        subrange(latLonH, 0,2) = quat2LatLon(qLatLon);

        latLonH(2) -= xErr(2);

        vn -= subrange(xErr, 3,6);

        qCorrection = euler2Quat(subrange(xErr, 6,9));

        q = quatProd(qCorrection, q);

        Un = Sigma = Zeta = zero_vector<double>(3);
		//std::cout<<"Lat Lon H GpsUpdate: "<<latLonH(0)*180/M_PI<<" "<<latLonH(1)*180/M_PI<<" "<<latLonH(2)<<std::endl;
		//std::cout<<"Vel GpsUpdate: "<<vn<<std::endl;
		//std::cout<<"Att GpsUpdate: "<<quat2Euler(q)*180/M_PI<<std::endl;
    }
}

void GpsIns::getState(double *output)
{
	vector<double> eulerTemp = quat2Euler(q)*180/M_PI;
	output[0]=latLonH(0);
	output[1]=latLonH(1);
	output[2]=latLonH(2);
	output[3]=eulerTemp(0);
	output[4]=eulerTemp(1);
	output[5]=eulerTemp(2);
	output[6]=vn(0);
	output[7]=vn(1);
	output[8]=vn(2);
}
} // arkmath


// vim:ts=4:sw=4
