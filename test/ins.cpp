#include "GpsIns.hpp"
#include <boost/numeric/ublas/io.hpp>
#include <boost/thread/thread.hpp>
int main (int argc, char const* argv[])
{
    boost::numeric::ublas::bounded_vector<double,3> fb;
    boost::numeric::ublas::bounded_vector<double,3> wb;
    fb = wb = boost::numeric::ublas::zero_vector<double>(3);
    //fb(0) = 1;
    //wb(0) = .001;

    double lat = 45*M_PI/180.0;
    double lon = -86*M_PI/180.0;
    double height = 100;
    double roll = 0*M_PI/180.0;
    double pitch = 0*M_PI/180.0;
    double yaw = 0*M_PI/180.0;
    double sigmaPos = 10;
    double sigmaAlt = 5;
    double sigmaVel = 1;
    double sigmaAccelG = .001;
    double sigmaGyro = .001;
    bool useGravity = false;

    arkmath::GpsIns gpsIns(lat,lon,height,roll,pitch,yaw,0,0,0,sigmaPos,sigmaAlt,sigmaVel,sigmaAccelG,sigmaGyro,useGravity);
    arkmath::GpsIns gpsInsError(lat,lon,height,roll,pitch,yaw,0,0,0,sigmaPos,sigmaAlt,sigmaVel,sigmaAccelG,sigmaGyro,useGravity);

    double fbNoiseFreq = 1330;
    double fbNoiseMag = .01*9.81;
    double fbNoise;

    double wbNoiseFreq = 1300;
    double wbNoiseMag = 2*M_PI/180;
    double wbNoise;
    boost::numeric::ublas::bounded_vector<double,3> ones3;
    for(int i=0; i<ones3.size(); i++) ones3(i) = 1.0;

    boost::numeric::ublas::bounded_vector<double,6> z;

    for (int i=0;i<1000;i++)
    {
        //No noise
        gpsIns.updateFast(fb,wb);
        gpsIns.updateMed();
        gpsIns.updateSlow();

        //Noisy
        fbNoise = fbNoiseMag*sin(gpsIns.elapsed*2*M_PI*fbNoiseFreq);
        wbNoise = wbNoiseMag*sin(gpsIns.elapsed*2*M_PI*wbNoiseFreq);

        gpsInsError.updateFast(fb+fbNoise*ones3,wb+wbNoise*ones3);
        gpsInsError.updateMed();
        gpsInsError.updateSlow();

        z(0) = (gpsInsError.latLonH(0) - gpsIns.latLonH(0)) * (gpsInsError.latLonH(2)+gpsInsError.R0);
        z(1) = (gpsInsError.latLonH(1) - gpsIns.latLonH(1)) * (gpsInsError.latLonH(2)+gpsInsError.R0)*cos(gpsInsError.latLonH(0));
        z(2) = (gpsInsError.latLonH(2) - gpsIns.latLonH(2));
        z(3) = gpsInsError.vn(0) - gpsIns.vn(0);
        z(4) = gpsInsError.vn(1) - gpsIns.vn(1);
        z(5) = gpsInsError.vn(2) - gpsIns.vn(2);

        gpsInsError.updateGps(z);
		if (i % 100 == 0) {
        	std::cout << z << std::endl;
		}

        boost::this_thread::sleep(boost::posix_time::milliseconds(10));
    }
    return 0;
}



