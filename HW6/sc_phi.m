% sc_phi.m 
% evaluate constraints and Jacobian for crank driving constraint
% HJSIII - 22.02.13
% global location of local frames and rotation matrices
% Eq 2.4.4, page 33 - Eq 2.6.5, page 42
r2 = q(1:2);
r3 = q(4:5);
r4 = q(7:8);
phi2 = q(3);
phi3 = q(6);
phi4 = q(9);
A2 = [ cos(phi2) -sin(phi2); sin(phi2) cos(phi2) ];
A3 = [ cos(phi3) -sin(phi3); sin(phi3) cos(phi3) ];
A4 = [ cos(phi4) -sin(phi4); sin(phi4) cos(phi4) ];
B2 = R * A2;
B3 = R * A3;
B4 = R * A4;
% global locations - Eq 2.4.8, page 33
r2A = r2 + A2*s2pA;
r2B = r2 + A2*s2pB;
r3B = r3 + A3*s3pB;
r3C = r3 + A3*s3pC;
r4C = r4 + A4*s4pC;
% r4D = r4 + A4*s4pD;
% r3P = r3 + A3*s3pP;
% revolute constraints - A,B,C,D - Eq 3.3.10, page 65
PHI(1:2,1) = r2A - r1A;
PHI(3:4,1) = r3B - r2B;
PHI(5:6,1) = r4C - r3C;
PHI(7,1) = phi4;
PHI(8,1) = q(8,1);
% crank driving constraint
PHI(9,1) = phi2 - phi2_start - w2*t;
 
% Jacobian by rows - Eq 3.3.12, page 66 for revolutes
JAC = zeros(9,9);
JAC(1:2,1:3) = [ eye(2) B2*s2pA ];
JAC(3:4,1:3) = [ -eye(2) -B2*s2pB ];
JAC(3:4,4:6) = [ eye(2) B3*s3pB ];
JAC(5:6,4:6) = [ -eye(2) -B3*s3pC ];
JAC(5,7:9) = [ [0 0] (r4C - r1A)'*[1;0] ];
JAC(6,7:9) = [ [0 0] -(r4C - r1A)'*[1;0] ];
% JAC(5:6,7:9) = [ eye(2) [0;0] ];
% JAC(7:8,7:9) = [ eye(2) [0;0] ];
% driving constraint in Jacobian - Eq 3.1.9, page 52
JAC(9,3) = 1;
% current results
current_crank = phi2 / d2r;
% bottom - dm_phi
