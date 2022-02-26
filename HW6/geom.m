clc,clear,close all

%% Geometric slider crank calculations
t = .01; %sec

BG3 = 1.1; %in

theta0 = 0; %rad
thetadot = 1000 *2*pi/60; % rmp to rad/sec
theta = thetadot*t + theta0;


R = .985; %in
L = 4.33; %in


phi = asin((R/L)*sin(theta));


s = R*cos(theta) + L*cos(phi);

r3 = [(L - BG3)*cos(phi); (L - BG3)*sin(phi)];
r3(1,1) = s - r3(1,1);

phi3 = -phi;

r4 = [s 0]';
phi4 = 0;


q = [0 0 theta r3(1) r3(2) phi3 r4(1) r4(2) phi4]'

