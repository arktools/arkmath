H_mag(0,1) = -(cosPsi*sinTheta*Bn+sinPsi*sinTheta*Be+cosTheta*Bd);
H_mag(0,2) = -cosTheta*(sinPsi*Bn-cosPsi*Be);
H_mag(1,0) = cosPhi*cosPsi*sinTheta*Bn+sinPhi*sinPsi*Bn+cosPhi*sinPsi*sinTheta*Be-sinPhi*cosPsi*Be+cosPhi*cosTheta*Bd;
H_mag(1,1) = sinPhi*(cosPsi*cosTheta*Bn+sinPsi*cosTheta*Be-sinTheta*Bd);
H_mag(1,2) = -(sinPhi*sinPsi*sinTheta*Bn+cosPhi*cosPsi*Bn-sinPhi*cosPsi*sinTheta*Be+cosPhi*sinPsi*Be);
H_mag(2,0) = -(sinPhi*cosPsi*sinTheta*Bn-cosPhi*sinPsi*Bn+sinPhi*sinPsi*sinTheta*Be+cosPhi*cosPsi*Be+sinPhi*cosTheta*Bd);
H_mag(2,1) = cosPhi*(cosPsi*cosTheta*Bn+sinPsi*cosTheta*Be-sinTheta*Bd);
H_mag(2,2) = -(cosPhi*sinPsi*sinTheta*Bn-sinPhi*cosPsi*Bn-cosPhi*cosPsi*sinTheta*Be-sinPhi*sinPsi*Be);
