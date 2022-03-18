clc,clear,close all

%calculate static forces for slider crank by using eq from Notes 06_01

%initialize correct slider crank properties and starting theta
R = 1.97/2;
L = 4.33;

theta0 = [314.7 331.07 343.55]; %deg
theta0 = deg2rad(theta0); %rad

phi = asin((R/L)*sin(theta0));
s = R*cos(theta0) + L*cos(phi);

T12 = 240; %lb*ft

%calculate force P on C for all the specified crank angles
P = T12*(cos(phi))./(R*sin(theta0 + phi))