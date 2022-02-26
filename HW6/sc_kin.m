% dm_kin.m - D-mechanism four-bar - ref: Haug, Fig P5.1, page 196
% positon, velocity, and acceleration at desired_crank 
% HJSIII - 20.03.04
% Newton-Raphson position solution - Eq 3.6.7 and 3.6.8, page 100
assy_tol = 0.00001;
sc_phi
while max(abs(PHI)) > assy_tol
 q = q - inv(JAC) * PHI;
 sc_phi
end
% velocity - Eq 3.1.9, page 52 - also page 66 for revolutes
velrhs(9,1) = w2;
qd = inv(JAC) * velrhs;
% global velocities - Eq 2.6.4, page 41
r2d = qd(1:2);
r3d = qd(4:5);
r4d = qd(7:8);
phi2d = qd(3);
phi3d = qd(6);
phi4d = qd(9);
% r3Pd = r3d + phi3d * B3 * s3pP;
% % acceleration - Eq 3.1.10, page 53 - also page 66 for revolutes
% accrhs(1:2,1) = A2*s2pA*phi2d*phi2d;
% accrhs(3:4,1) = A3*s3pB*phi3d*phi3d - A2*s2pB*phi2d*phi2d;
% accrhs(5:6,1) = A4*s4pC*phi4d*phi4d - A3*s3pC*phi3d*phi3d;
% accrhs(7:8,1) = A4*s4pD*phi4d*phi4d;
% accrhs(9,1) = 0;
% qdd = inv(JAC) * accrhs;
% % global accelerations
% r2dd = qdd(1:2);
% r3dd = qdd(4:5);
% r4dd = qdd(7:8);
% phi2dd = qdd(3);
% phi3dd = qdd(6);
% phi4dd = qdd(9);
% r3Pdd = r3dd + phi3dd*B3*s3pP - phi3d*phi3d*A3*s3pP;
% % bottom - dm_kin