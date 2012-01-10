/*
 * utilities.hpp
 * Copyright (C) James Goppert 2009 <jgoppert@purdue.edu>
 *
 * utilities.hpp is free software: you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * utilities.hpp is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 * See the GNU General Public License for more details.
 * * You should have received a copy of the GNU General Public License along * with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef utilities_H
#define utilities_H

// boost ublas
#include <boost/numeric/ublas/triangular.hpp>
#include <boost/numeric/ublas/lu.hpp>
#include <boost/numeric/ublas/io.hpp>
#include <boost/numeric/ublas/vector.hpp>
#include <boost/numeric/ublas/vector_proxy.hpp>
#include <boost/numeric/ublas/matrix.hpp>
#include <boost/numeric/ublas/matrix_proxy.hpp>

// boost bindings
#include <boost/numeric/bindings/traits/ublas_matrix.hpp>
#include <boost/numeric/bindings/traits/ublas_vector.hpp>
#include <boost/numeric/bindings/lapack/gesvd.hpp>
#include <boost/numeric/bindings/lapack/gees.hpp>
#include <boost/numeric/bindings/lapack/geev.hpp>
#include <boost/numeric/bindings/lapack/hseqr.hpp>
#include <boost/numeric/bindings/lapack/syev.hpp>
#include <boost/numeric/bindings/lapack/posv.hpp>
#include <boost/numeric/bindings/lapack/workspace.hpp>

// std
#include <string>
#include <iostream>
#include <sstream>
#include <iomanip>
#include <unistd.h>
#include <cmath>
#include <limits>
#include <stdio.h>
#include <complex>


namespace mavsim
{

using namespace boost::numeric::ublas;

// data path
const char * dataPath(std::string path);

// control functions
void lowPass(const double &freq, const vector<double> &freqCut,
             const vector<double> &x, vector<double> &y);
void discretize(matrix<double>& Ac, matrix<double>& Bc, matrix<double>& Ad, matrix<double>& Bd, double T, int order);

//Unions

// checksum/ size union
union int16_uint8
{
    int16_t asInt16;
    unsigned char asUint8[2];
};

//declare unions
union longUnion
{
    long int sum;
    unsigned char byte[4];
};//end union
union shortUnion
{
    short int sum;
    unsigned char byte[2];
};//end union
union longUnionUnsigned
{
    unsigned long int sum;
    unsigned char byte[4];
};
union shortUnionUnsigned
{
    unsigned short int sum;
    unsigned char byte[2];
};//end union
union floatUnion
{
    float sum;
    unsigned char byte[4];
};//end union


// basic math
template <class T>
T abs(T x)
{
    if (x<0) return -x;
    else return x;
}

// matrix math
matrix<double> cross(const vector<double> &vec);
matrix<double> ones(int m, int n);
matrix<double> skew(const vector<double> &v);
matrix<double> inv(const matrix<double>& input);
matrix<double> pinv(const matrix<double> &A);
bool select(double real, double imag);
matrix<double> dare(const matrix<double> &A, const matrix<double> &B, const matrix<double> &R, const matrix<double> &Q);
matrix<double> dlqr(const matrix<double> &A, const matrix<double> &B, const matrix<double> &R, const matrix<double>&Q);
matrix<double> prod(const matrix<double> &A, const matrix<double> &B, const matrix<double> &C);
double max(const vector<double> &v);
double min(const vector<double> &v);


//Quaternion and Vector Operations
vector<double> quat2LatLon(const vector<double> &quat);
vector<double> latLon2Quat(const vector<double> &latLon);
vector<double> latLon2Quat(const double &lat, const double &lon);
double dotProd(const vector<double> &v1, const vector<double> &v2);
vector<double> quatProd(const vector<double> &q1, const vector<double> &q2);
vector<double> quatRotate(const vector<double> &q, const vector<double> &vec);
void quatRotate(const vector<double> &q, const matrix<double> &mat);
vector<double> crossProd(const vector<double> &v1, const vector<double> &v2);
vector<double> quatConj(const vector<double> &q);
vector<double> quat2Euler(const vector<double> &q);
vector<double> euler2Quat(const vector<double> &euler);
vector<double> axisAngle2Quat(const vector<double> &axis, double angle);
vector<double> norm(const vector<double> &vec);
vector<double> ones(int n);
vector<double> dcm2Quat(const matrix<double> &dcm);
matrix<double> quat2Dcm(const vector<double> &quat);
double signum(double in);
matrix<double> matSqrt(const matrix<double>& A);
matrix<double> vectorToMatrix(const vector<double> &A);
matrix<double> prod3(const matrix<double> &a, const matrix<double> &b, const matrix<double> &c);


template <class MAT>
int choleskyDecomp(MAT& A)
{
using namespace boost::numeric::bindings;
	int n = A.size1();
	int info;
	info = lapack::potrf('L', A);
	for (int i = 0; i<A.size1();i++) for(int j=i+1;j<A.size2();j++) A(i,j) = 0;
	return info;
}

template<class MAT>
void printMat(MAT& mat, std::string label="", int precision=2)
{
	int width = precision + 7;
	std::cout<<label<<"["<<mat.size1()<<","<<mat.size2()<<"] "<<"\n";
	std::cout<<"[";
	for(int i=0;i<mat.size1();i++)
	{
		if ( i != 0) std::cout<<" ";
		for(int j=0;j<mat.size2();j++)
		{
			printf("%*.*e",width,precision,mat(i,j));
			//std::cout<<mat(i,j);
			if(j!=mat.size2()-1) std::cout<<", ";
		}
		std::cout<<";";
		if ( i == mat.size1()-1) std::cout<<"]";
		std::cout<<std::endl<<std::endl;
	}
}
template <class MAT, class VEC>
void eig(const MAT& A, VEC& Sig)
{
	using namespace boost::numeric::bindings;
	matrix<double, column_major> Ac = A;
    int m = A.size1(), n = A.size2();
    int maxDim = std::max(m,n), minDim = std::min(m,n);
    Sig.resize(minDim);
    matrix<double, column_major> U(m,m), SigI(n,m), VT(n,n);
    lapack::gesvd('A','A', Ac, Sig, U, VT);
}

template <class MAT>
void swapColumns(MAT& mat, int i, int j)
{
	typedef matrix_column< MAT > col;

	vector<double> temp = col(mat, i);
    col(mat, i) = col(mat,j);
    col(mat, j) = temp;
}

template <class MAT>
void swapRows(MAT& mat, int i, int j)
{
	typedef matrix_row< MAT > row;

	vector<double> temp = row(mat, i);
    row(mat, i) = row(mat,j);
    row(mat, j) = temp;
}


// general
bool fileExists(const char * filename);
std::string doubleToString(double val);
std::string intToString(int val);
void cursorxy( int col, int line );
void clear( bool gohome = true );

// integration
vector<double> integrate(vector<double> i1,
                         vector<double> i0, vector<double> initial, double freq);
double integrate(double i1, double i0, double initial, double freq);

}


#endif

// vim:ts=4:sw=4
