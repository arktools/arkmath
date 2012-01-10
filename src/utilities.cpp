/*
 * utilities.cpp
 * Copyright (C) James Goppert 2009 <jgoppert@purdue.edu>
 *
 * utilities.cpp is free software: you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * utilities.cpp is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 * See the GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#include "utilities.hpp"

#include <boost/numeric/ublas/vector_expression.hpp>
#include <boost/numeric/ublas/matrix_expression.hpp>

#include <boost/numeric/ublas/triangular.hpp>
using namespace boost::numeric::ublas;
using namespace boost::numeric::bindings;

extern "C"
{

    void LAPACK_DTRSEN (const char* JOB, const char* COMPZ,logical_t* select,
                        const int* N, double* T,const int* LDT,double *Q,
                        const int* LDQ,  double* WR, double* WI,int* M,
                        double* S,double* SEP,double* WORK,int* LWork,
                        int* IWORk,int* LIWORK,int* INFO);

}

namespace mavsim
{
matrix<double> cross(const vector<double> &vec)
{
    matrix<double> cross(3,3);
    cross(0,0) = 0 			,cross(0,1) = -vec(2) 	, cross(0,2) = vec(1);
    cross(1,0) = vec(2) 	,cross(1,1) = 0 	 	, cross(1,2) = -vec(0);
    cross(2,0) = -vec(1) 	,cross(2,1) = vec(0) 	, cross(2,2) = 0;
    return cross;
}
vector<double> latLon2Quat(const vector<double> &latLon)
{
    vector<double> quat(4);
    double clat = cos(-latLon(0)/2.0);
    double clon = cos(latLon(1)/2.0);
    double slat = sin(-latLon(0)/2.0);
    double slon = sin(latLon(1)/2.0);

    quat(0) =  clat * clon;
    quat(1) =  clat * slon;
    quat(2) =  slat * clon;
    quat(3) =  -slat * slon;

    return quat;
}

vector<double> latLon2Quat(const double &lat, const double &lon)
{
    vector<double> quat(4);
    double clat = cos(-lat/2.0);
    double clon = cos(lon/2.0);
    double slat = sin(-lat/2.0);
    double slon = sin(lon/2.0);

    quat(0) =  clat * clon;
    quat(1) =  clat * slon;
    quat(2) =  slat * clon;
    quat(3) =  -slat * slon;

    return quat;
}

vector<double> quat2LatLon(const vector<double> &quat)
{
    vector<double> latLon(2);
    vector<double> euler(3);
    euler = quat2Euler(quat);
    latLon(0) = -euler(1);
    latLon(1) = euler(0);

    return latLon;
}


bool fileExists(const char * filename)
{
    if (FILE * file = fopen(filename, "r"))
    {
        fclose(file);
        return true;
    }
    return false;
}
std::string doubleToString(double val)
{
    std::ostringstream out;
    out << val;
    return out.str();
}

std::string intToString(int val)
{
    std::ostringstream out;
    out << std::setfill('0') << std::setw(3) << val;
    return out.str();
}


void lowPass(const double &freq, const vector<double> &freqCut,
             const vector<double> &x, vector<double> &y)
{
    double alpha, dt;
    dt = 1/freq;
    for (int i=0; i<y.size(); i++)
    {
        alpha = dt / (1/ (freqCut(i)*M_PI) + dt);
        y(i) = alpha*x(i) + (1-alpha)*y(i);
    }
}

double signum(double in)
{
    if (in>=0.0) return 1.0;
    else return -1.0;
}

vector<double> ones(int n)
{
    vector<double> ones(n);
    for(int i=0; i<n; i++) ones(i) = 1;
    return ones;
}

matrix<double> ones(int m, int n)
{
    matrix<double> A(m,n);
    for (int i=0; i<m; i++)
        for (int j=0; j<n; j++)
            A(i,j) = 1;
    return A;
}

vector<double> dcm2Quat(const matrix<double> &dcm)
{
    vector<double> quat(4);
    quat(0) = sqrt((1+dcm(0,0)+dcm(1,1)+dcm(2,2))/4.0);
    quat(1) = sqrt((1+dcm(0,0)-dcm(1,1)-dcm(2,2))/4.0);
    quat(2) = sqrt((1-dcm(0,0)+dcm(1,1)-dcm(2,2))/4.0);
    quat(3) = sqrt((1-dcm(0,0)-dcm(1,1)+dcm(2,2))/4.0);
    double maxVal = max(quat);
    if(quat(0)==maxVal)
    {
        quat(1) = signum(dcm(1,2)-dcm(2,1))*quat(1);
        quat(2) = signum(dcm(2,0)-dcm(0,2))*quat(2);
        quat(3) = signum(dcm(0,1)-dcm(1,0))*quat(3);
    }
    else if(quat(1)==maxVal)
    {
        quat(0) = signum(dcm(1,2)-dcm(2,1))*quat(0);
        quat(2) = signum(dcm(0,1)+dcm(1,0))*quat(2);
        quat(3) = signum(dcm(0,2)+dcm(2,0))*quat(3);
    }
    else if(quat(2)==maxVal)
    {
        quat(0) = signum(dcm(2,0)-dcm(0,2))*quat(0);
        quat(1) = signum(dcm(0,1)+dcm(1,0))*quat(1);
        quat(3) = signum(dcm(1,2)+dcm(2,1))*quat(3);
    }
    else if(quat(3)==maxVal)
    {
        quat(0) = signum(dcm(0,1)-dcm(1,0))*quat(0);
        quat(1) = signum(dcm(0,2)+dcm(2,0))*quat(1);
        quat(2) = signum(dcm(1,2)+dcm(2,1))*quat(2);
    }
    return quat;
}

matrix<double> quat2Dcm(const vector<double> &quat)
{
    matrix<double>DCM(3,3);
    double qr, qi, qj, qk, qr2, qi2, qj2, qk2;
    qr=quat(0), qi=quat(1), qj=quat(2), qk=quat(3);
    qr2 = qr*qr, qi2=qi*qi, qj2=qj*qj, qk2=qk*qk;
    DCM(0,0) = qr2+qi2-qj2-qk2, 	DCM(0,1) = 2*(qi*qj-qr*qk), 	DCM(0,2) = 2*(qi*qk+qr*qj);
    DCM(1,0) = 2*(qr*qk+qi*qj), 	DCM(1,1) = qr2-qi2+qj2-qk2, 	DCM(1,2) = 2*(qj*qk-qr*qi);
    DCM(2,0) = 2*(qi*qk-qr*qj), 	DCM(2,1) = 2*(qr*qi+qj*qk), 	DCM(2,2) = qr2-qi2-qj2+qk2;
    return DCM;
}


matrix<double> skew(const vector<double> &v)
{
    matrix<double> m(3,3);
    m(0,0) = 0;
    m(1,0) = -v(2);
    m(2,0) = v(1);
    m(0,1) = v(2);
    m(1,1) = 0;
    m(2,1) = -v(0);
    m(0,2) = -v(1);
    m(1,2) = v(0);
    m(2,2) = 0;
    return m;
}

double max(const vector<double> &v)
{
    double max = v(0);
    for (int i=1; i<v.size(); i++)
    {
        if (v(i) > max) max = v(i);
    }
    return max;
}

double min(const vector<double> &v)
{
    double min = v(0);
    for (int i=1; i<v.size(); i++)
    {
        if (v(i) < min) min = v(i);
    }
    return min;
}


/**
 * Matrix inversion routine.
 * Uses lu_factorize and lu_substitute in uBLAS to invert a matrix
 */
matrix<double> inv(const matrix<double>& input)
{
    typedef permutation_matrix<std::size_t> pmatrix;
    // create a working copy of the input
    int n = input.size1();
    if (input.size2() != n) std::cout << "Error: matrix must be square." << std::endl;
    matrix<double> A(input), inverse(n,n);
    // create a permutation matrix for the LU-factorization
    pmatrix pm(A.size1());

    // perform LU-factorization
    int res = lu_factorize(A,pm);
    if ( res != 0 ) std::cout << "Error in inverse" << std::endl;

    // create identity matrix of "inverse"
    inverse.assign(identity_matrix<double>(n));

    // backsubstitute to get the inverse
    lu_substitute(A, pm, inverse);
    return inverse;
}

matrix<double> pinv(const matrix<double>& A)
{
    matrix<double, column_major> Ac = A;
    int m = A.size1(), n = A.size2();
    int maxDim = std::max(m,n), minDim = std::min(m,n);
    vector<double> Sig(minDim);
    matrix<double, column_major> U(m,m), SigI(n,m), VT(n,n);
    lapack::gesvd('A','A', Ac, Sig, U, VT);

    // Computer pseudo inverse of Sigma
    double tol = std::numeric_limits<double>::epsilon()*maxDim*max(Sig);
    //std::cout << "epsilon: " << std::numeric_limits<double>::epsilon() << std::endl;
    //std::cout << "maxDim: " << maxDim << std::endl;
    //std::cout << "maxSig: " << max(Sig) << std::endl;
    //std::cout << "tol: " << tol << std::endl;

    SigI = zero_matrix<double>(n,m);
    for (int i=0; i<minDim; i++)
    {
        if (Sig(i) > tol)
        {
            SigI(i,i) = 1/Sig(i);
        }
        else
        {
            SigI(i,i) = 0;
        }
    }

    // Debug
    //std::cout << "U: " << U << std::endl;
    //std::cout << "Sig: " << Sig << std::endl;
    //std::cout << "SigI: " << SigI << std::endl;
    //std::cout << "V: " << trans(VT) << std::endl;

    // Computer pseudo inverse of A
    matrix<double> temp = prod(trans(VT),SigI);
    return prod(temp,trans(U));
}

bool select(double real, double imag)
{


    if ( real*real + imag*imag < 1) return 1;
    else return 0;
}

matrix<double> dare(const matrix<double> &A, const matrix<double> &B, const matrix<double> &R, const matrix<double> &Q)
{
    //A,Q,X:n*n, B:n*m, R:m*m

    int n=A.size1(),m=B.size2();
    matrix<double,column_major>Z11(n,n);
    matrix<double,column_major>Z12(n,n);
    matrix<double,column_major>Z21(n,n);
    matrix<double,column_major>Z22(n,n);
    matrix<double,column_major>temp1(m,m);
    matrix<double,column_major>temp2(n,n);
    matrix<double,column_major>temp3(m,n);

    Z11=inv(A);                       //inv(A)
    temp1=inv(R);                     //inv(R)
    Z21=prod(Q,Z11);                  //Q*inv(A)
    temp2=prod3(B,temp1,trans(B));     //B*inv(R)*B'
    Z12=prod(Z11,temp2);
    Z22=trans(A)+prod(Z21,temp2);

    //construct the Z with Z11,Z12,Z21,Z22
    matrix<double,column_major>Z(2*n,2*n);
    subrange(Z,0,n,0,n)=Z11;
    subrange(Z,n,2*n,0,n)=Z21;
    subrange(Z,0,n,n,2*n)=Z12;
    subrange(Z,n,2*n,n,2*n)=Z22;

    vector<std::complex<double> >eig(2*n);

    int n_Z=traits::matrix_size1(Z);
    matrix<double,column_major> VL(n_Z,n_Z);
    matrix<double,column_major> VR(n_Z,n_Z);

    lapack::geev(Z,eig,&VL,&VR,lapack::optimal_workspace());

    //Order the eigenvectors
    //move e-vectors correspnding to e-value outside the unite circle to the left
    matrix<double,column_major>U11(n,n);
    matrix<double,column_major>U21(n,n);
    matrix<double,column_major>tempZ(n_Z,n);

    int c1=0;

    for (int i=0; i<n_Z; i++)
    {
        if ((eig(i).real()*eig(i).real()+eig(i).imag()*eig(i).imag())>1) //outside the unite cycle
        {
            column(tempZ,c1)=column(VR,i);
            c1++;
        }
    }

    U11=subrange(tempZ,0,n,0,n);
    U21=subrange(tempZ,n,n_Z,0,n);

    return prod(U21,inv(U11));

}
matrix<double> dlqr(const matrix<double> &A, const matrix<double> &B, const matrix<double> &R, const matrix<double> &Q)
{
    //A,Q,X:n*n, B:n*m, R:m*m

    int n=A.size1(),m=B.size2();
    matrix<double,column_major>P(n,n);
    matrix<double,column_major>temp1(m,n);
    matrix<double,column_major>temp2(m,m);

    P=dare(A,B,R,Q); 				//Solution of DARE
    temp1=prod(trans(B),P); 		//B'*P,m*n
    temp2=R+prod(temp1,B); 			//R+(B'*P)*B,m*m
    temp1=prod(trans(temp2),temp1); //m*n
    //std::cout<<"Gain matrix K="<<prod(temp1,A)<<std::endl;
    return prod(temp1,A);
}
matrix<double> prod(matrix<double> A, matrix<double> B, matrix<double> C)
{
    return prod(A, matrix<double> (prod(B,C)));
}

void discretize(matrix<double>& Ac, matrix<double>& Bc, matrix<double>& Ad, matrix<double>& Bd, double T, int order)
{
    Ad.resize(Ac.size1(), Ac.size2());
    Bd.resize(Bc.size1(), Bc.size2());

    Ad = identity_matrix<double>(Ac.size1(), Ac.size2()) + T*Ac;
    Bd = T*Bc;

    double T_power = T;
    matrix<double> Ac_power = Ac;
    int ifac = 1;

    for (int i = 2; i <= order; i++)
    {
        T_power *= T;
        ifac *= ifac+1;

        Bd = Bd + T_power/ifac * prod(Ac_power, Bc);
        Ac_power = prod(Ac_power, Ac);
        Ad = Ad + T_power/ifac * Ac_power;

    }

}

// Vector Integration
vector<double> integrate(vector<double> i1, vector<double> i0, vector<double> initial, double freq)
{
    vector<double> ans;
    ans = (i0 + i1)/2;
    ans = ans/freq;
    ans = ans + initial;
    return ans;
}

// Integration
double integrate (double i1, double i0, double initial, double freq)
{
    double ans;
    ans = (i0 + i1) / 2;
    ans = ans/freq;
    ans = ans + initial ;
    return ans;
}

// Quaternion utilities
vector<double> quatProd(const vector<
                        double> &q1, const vector<double> &q2)
{
    vector<double> prod(4);
    prod(0) = (q2(0) * q1(0) - q2(1) * q1(1) - q2(2) * q1(2) - q2(3) * q1(3));
    prod(1) = (q2(0) * q1(1) + q2(1) * q1(0) - q2(2) * q1(3) + q2(3) * q1(2));
    prod(2) = (q2(0) * q1(2) + q2(1) * q1(3) + q2(2) * q1(0) - q2(3) * q1(1));
    prod(3) = (q2(0) * q1(3) - q2(1) * q1(2) + q2(2) * q1(1) + q2(3) * q1(0));
    return prod;
}

vector<double> quatRotate(const vector<double> &q, const vector<double> &vec)
{
    vector<double> vec4(4);
    vector<double> qConj(4);
    vector<double> vec4Rotated(4);
    vector<double> vec3Rotated(3);
    vec4(0) = 0;
    subrange(vec4, 1, 4) = subrange(vec, 0, 3);
    vec4Rotated = quatProd(q,vec4);
    qConj = quatConj(q);
    vec4Rotated = quatProd(vec4Rotated, qConj);
    subrange(vec3Rotated, 0, 3) = subrange(vec4Rotated, 1, 4);
    return vec3Rotated;
}

void quatRotate(const vector<double> &q, matrix<double> &mat)
{
    if (mat.size1() != 3) std::cout<<"Matrix should be of size 3xn for matrix column quaternion rotation"<<std::endl;
    vector<double> vec4(4);
    vector<double> qConj(4);
    vector<double> vec4Rotated(4);
    vector<double> vec3Rotated(3);
    matrix<double> mat1;
    vec4(0) = 0;

    for (int i = 0; i < mat.size2(); i++)
    {
        subrange(vec4, 1, 4) = column(mat, i);
        vec4Rotated = quatProd(q,vec4);
        qConj = quatConj(q);
        vec4Rotated = quatProd(vec4Rotated, qConj);
        subrange(vec3Rotated, 0, 3) = subrange(vec4, 1, 4);
        column(mat, i) = vec3Rotated;
    }
}

vector<double> crossProd(const vector<
                         double> &v1, const vector<double> &v2)
{
    vector<double> prod(3);
    prod(0) = v1(1) * v2(2) - v1(2) * v2(1);
    prod(1) = v1(2) * v2(0) - v1(0) * v2(2);
    prod(2) = v1(0) * v2(1) - v1(1) * v2(0);
    return prod;
}

double dotProd(const vector<double> &v1, const vector<double> &v2)
{
    return inner_prod(v1,v2);
}
vector<double> quatConj(const vector<double> &q)
{
    vector<double> qConj(4);
    qConj(0) = q(0);
    qConj(1) = -q(1);
    qConj(2) = -q(2);
    qConj(3) = -q(3);
    return qConj;
}

vector<double> quat2Euler(const vector<double> &q)
{
    vector<double> eul(3);
    double roll, pitch, yaw;
    double sq0 = q(0) * q(0);
    double sq1 = q(1) * q(1);
    double sq2 = q(2) * q(2);
    double sq3 = q(3) * q(3);
    double test = q(0) * q(2) - q(3) * q(1);


    if (test > 0.499999)   // singularity at north pole
    {
        yaw = 2 * atan2(q(1), q(0));
        pitch = M_PI / 2.;
        roll = 0;

    }
    else if (test < -0.499999)   // singularity at south pole
    {
        yaw = -2 * atan2(q(1), q(0));
        pitch = -M_PI / 2;
        roll = 0;

    }
    else
    {
        roll = 	atan2(2 * (q(0) * q(1) + q(2) * q(3)), sq0 - sq1 - sq2 + sq3);
        pitch = asin( 2 * (q(0) * q(2) - q(1) * q(3)));
        yaw = 	atan2(2 * (q(1) * q(2) + q(0) * q(3)), sq0 + sq1 - sq2 - sq3);
    }
    eul(0) = roll;
    eul(1) = pitch;
    eul(2) = yaw;
    return eul;
}

vector<double> euler2Quat(const vector<double> &euler)
{
    vector<double> quat(4);
    double phi = euler(0), th = euler(1), psi = euler(2);
    quat(0) = cos(phi/2)*cos(th/2)*cos(psi/2)+sin(phi/2)*sin(th/2)*sin(psi/2);
    quat(1) = sin(phi/2)*cos(th/2)*cos(psi/2)-cos(phi/2)*sin(th/2)*sin(psi/2);
    quat(2) = cos(phi/2)*sin(th/2)*cos(psi/2)+sin(phi/2)*cos(th/2)*sin(psi/2);
    quat(3) = cos(phi/2)*cos(th/2)*sin(psi/2)-sin(phi/2)*sin(th/2)*cos(psi/2);
    return norm(quat);
}

vector<double> axisAngle2Quat(vector<double> axis, const double &angle)
{
    axis = norm(axis);
    vector<double> quat(4);

    quat(0) = cos(angle/2);
    quat(1) = sin(angle/2)*axis(0);
    quat(2) = sin(angle/2)*axis(1);
    quat(3) = sin(angle/2)*axis(2);
    return norm(quat);
}

vector<double> norm(const vector<double> &vec)
{
    double mag = norm_2(vec);
    if (mag == 0)
    {
        return zero_vector<double>(vec.size());
    }
    else
    {
        return vec*(1/norm_2(vec));
    }
}
/**
 * Matrix square root function.
 */
matrix<double> matSqrt(const matrix<double>& A)
{
    matrix<double,column_major> a(A);
    int n = A.size1();
    vector<double> w(n);
    matrix<double> W(n,n);
    lapack::syev('V','U',a,w,lapack::minimal_workspace());
    for (int i=0; i<n; i++) W(i,i)=sqrt(w(i));
    matrix<double> tmp = prod(a,W);
    matrix<double> result = prod(tmp,trans(a));
    return result;
}


/**
 * Convert a column vector to a matrix.
 */
matrix<double> vectorToMatrix(const vector<double> &v)
{
    using namespace boost::numeric::ublas;
    int n = v.size();
    matrix<double> m(n,1);
    for (int i=0; i<n; i++) m(i,0) = v(i);
    return m;
}

matrix<double> prod3(const matrix<double> &a, const matrix<double> &b, const matrix<double> &c)
{
    using namespace boost::numeric::ublas;
    return prod(matrix<double>(prod(a,b)),c);
}

//Used for re-arranging according to a permutation matrix
//matrix<double> permutation = identity_matrix<double>(vSize+lSize*trackingMin, vSize+lSize*trackingMin);
//for(int i=0;i<trackingMin-1;i++)
//{
//for(int j=0;j<3;j++)
//{
//std::cout<<"i: "<<permutation.size1()-(i+1)*lSize-3+j<<"   j: "<< permutation.size1()-(i+1)*lSize+3*i+j<<std::endl;
//swapRows(permutation, permutation.size1()-(i+1)*lSize-3+j, permutation.size1()-(i+1)*lSize+3*i+j);
//}
//}
//printMat(permutation,"Permutation",0);

} //namespace mavsim
// vim:ts=4:sw=4
