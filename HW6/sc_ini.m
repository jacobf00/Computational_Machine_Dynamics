% sc_ini.m - slider crank
% initialize constants and assembly guesses
% HJSIII - 22.02.13
% general constants
d2r = pi / 180;
R = [ 0 -1; 1 0 ];
% mechanism constants
len2 = .985;
len3 = 4.33;
len4 = 1.1;
% len4 = 30;
% possible lengths for parameter study of link
% len4 = 19.1; plot_str = 'r';
% len4 = 20; plot_str = 'b';
% len4 = 25; plot_str = 'g';
% len4 = 30; plot_str = 'k';
% local body-fixed locations
% s1pA = [ 0 0 ]';
% s1pD = [ 45 0 ]';
s2pA = [ 0 0 ]';
s2pB = [ len2 0 ]';
s3pB = [ -len4 0 ]';
s3pC = [ len3-len4 0 ]';
% s3pP = [ 105 -5.00 ]';
s4pC = [ 0 0 ]';
% s4pD = [ len4 0 ]';
% global locations
r1A = [ 0 0 ]';
% r1D = [ 45 0 ]';
% initial guesses - angles measured by protractor
phi2 = .5236;
phi3 = -0.1140;
phi4 = 0*d2r;
q(1,1) = 0;
q(2,1) = 0;
q(3,1) = phi2;
q(4,1) = 1.9459;
q(5,1) = .3674;
q(6,1) = phi3;
q(7,1) = 5.1549;
q(8,1) = 0;
q(9,1) = phi4;
% driver for crank - phi2 = phi2_start + w2*t
phi2_start = 0 * d2r;
w2 = 1000 * 2 * pi / 60; % 1000 rpm CCW, convert to rad/sec
% start time
t = 0.01;
% bottom - dm_ini
