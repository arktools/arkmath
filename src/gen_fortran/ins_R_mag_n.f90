R_mag_n(1,1) = (sin(dec)**2*sin(dip)**2*sigDec**2+cos(dec)**2*sin(dip)**2)*sigDip**2+sin(dec)**2*cos(dip)**2*sigDec**2
R_mag_n(1,2) = (cos(dec)*sin(dec)*sin(dip)**2-cos(dec)*sin(dec)*sin(dip)**2*sigDec**2)*sigDip**2-cos(dec)*sin(dec)*cos(dip)**2*sigDec**2
R_mag_n(1,3) = -cos(dec)*cos(dip)*sin(dip)*sigDip**2
R_mag_n(2,1) = (cos(dec)*sin(dec)*sin(dip)**2-cos(dec)*sin(dec)*sin(dip)**2*sigDec**2)*sigDip**2-cos(dec)*sin(dec)*cos(dip)**2*sigDec**2
R_mag_n(2,2) = (cos(dec)**2*sin(dip)**2*sigDec**2+sin(dec)**2*sin(dip)**2)*sigDip**2+cos(dec)**2*cos(dip)**2*sigDec**2
R_mag_n(2,3) = -sin(dec)*cos(dip)*sin(dip)*sigDip**2
R_mag_n(3,1) = -cos(dec)*cos(dip)*sin(dip)*sigDip**2
R_mag_n(3,2) = -sin(dec)*cos(dip)*sin(dip)*sigDip**2
R_mag_n(3,3) = cos(dip)**2*sigDip**2
