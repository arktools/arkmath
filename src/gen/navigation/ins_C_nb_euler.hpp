C_nb_euler(0,0) = cos(%psi)*cos(%theta);
C_nb_euler(0,1) = sin(%phi)*cos(%psi)*sin(%theta)-cos(%phi)*sin(%psi);
C_nb_euler(0,2) = cos(%phi)*cos(%psi)*sin(%theta)+sin(%phi)*sin(%psi);
C_nb_euler(1,0) = sin(%psi)*cos(%theta);
C_nb_euler(1,1) = sin(%phi)*sin(%psi)*sin(%theta)+cos(%phi)*cos(%psi);
C_nb_euler(1,2) = cos(%phi)*sin(%psi)*sin(%theta)-sin(%phi)*cos(%psi);
C_nb_euler(2,0) = -sin(%theta);
C_nb_euler(2,1) = sin(%phi)*cos(%theta);
C_nb_euler(2,2) = cos(%phi)*cos(%theta);
