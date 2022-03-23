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

%% Problem 2
%math done by hand in HW9 OneNote

%% Extra Credit

clc,clear,close all

dta = load('SliderCrank_ExtraCredit.dta');

t = dta(:,1);
theta2 = dta(:,2) - (2*pi);

force = dta(:,4);



%calculate static forces for slider crank by using eq from Notes 06_01

%initialize correct slider crank properties and starting theta
R = 1.97/2;
L = 4.33;

theta0 = theta2(10:end); %deg
% theta0 = deg2rad(theta0); %rad

phi = asin((R/L)*sin(theta0));
s = R*cos(theta0) + L*cos(phi);

T12 = 240; %lb*ft

%calculate force P on C for all the specified crank angles
P = T12*(cos(phi))./(R*sin(theta0 + phi));


figure(1)
plot(theta2(10:end),force(10:end),'r',theta0,P,'b')
xlabel('theta2 (rad)')
ylabel('Contact Force (N)')
title('Force vs theta2')
legend('Simulated','Static Force analysis')




