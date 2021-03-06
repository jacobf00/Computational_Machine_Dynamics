%% Problem 2

clc,clear,close all

data = load('SliderCrank.dta');

theta = data(:,2);
T1on2_sim = -data(:,4);
T1on2_sim(1) = 0;
t = data(:,1);
dt = t(2) - t(1);

thetadot = gradient(theta)/dt;
thetadot = 1000*(2*pi/60); %rad/sec

R = .985; %in
L = 4.33; %in
m3B = 0.3509; %lbm
m3C = 0.1111; %lbm

m3 = m3B + m3C;

m4 = .781; %lbm
BG3 = 1.043; %in
JG3 = 1.5; %lbm*in^2


T1on2 = -.5*(m3C + m4)*R^2*thetadot.^2.*((R/(2*L))*sin(theta) - sin(2*theta) - ((3*R)/(2*L))*sin(3*theta));

T1on2 = (1/386)*T1on2; %lbf*in

step = 10;

figure(1)
plot(theta(1:step:end),T1on2_sim(1:step:end),'ro',theta,T1on2,'b')
xlabel('theta2 (rad)')
ylabel('T1on2 (lbf*in)')
title('Crank Torque vs Crank Angle')
legend('Simulation','Analytical')

%% Problem 3
clc,clear, close all

R = .985; %in
L = 4.33; %in
m3B = 0.3509; %lbm
m3C = 0.1111; %lbm

m3 = m3B + m3C;

m4 = .781; %lbm
BG3 = 1.043; %in
JG3 = 1.5; %lbm*in^2
mBAL = 0; %lbm
g = 386.088; %in/sec^2



data = load('SliderCrank_Shaking.dta');

t = data(:,1);
dt = t(2) - t(1); %sec

theta0 = 0; %rad
thetadot = 1000*(2*pi/60); %rad/sec
theta = thetadot*t + theta0; %rad
phi = asin((R/L)*sin(theta));
s = R*cos(theta) + L*cos(phi);

sdot = gradient(s)/dt;
sdotdot = gradient(sdot)/dt;

Fx2on1_sim = -data(:,6);
Fx2on1_sim(1) = Fx2on1_sim(2);

Fy2on1_sim = -data(:,7);
Fy2on1_sim(1) = Fy2on1_sim(2);

Fy4on1_sim = -data(:,3);
Fy4on1_sim(1) = Fy4on1_sim(2);

% Fx2on1 = (m3B - mBAL)*R*thetadot.^2.*cos(theta) - (m3C + m4)*sdotdot;
% 
% Fy2on1 = (m3B - mBAL)*R*thetadot.^2.*sin(theta) + (m3C + m4)*sdotdot.*tan(phi);
% Fy4on1 = -(m3C + m4)*sdotdot.*tan(phi);

%matrix equation
Fx = R*thetadot^2*((m3B - mBAL)*cos(theta) + (m3C + m4)*(cos(theta) + (R/L)*cos(2*theta)))/g;

Fy = R*thetadot^2*((m3B - mBAL)*sin(theta))/g;

step = 20;

figure(2)
% plot(Fx2on1,Fy2on1+Fy4on1,'b',Fx2on1_sim,Fy2on1_sim+Fy4on1_sim,'ro')
plot(Fx,Fy,'b',Fx2on1_sim(1:step:end),Fy2on1_sim(1:step:end)+Fy4on1_sim(1:step:end),'ro')
% plot(Fx,Fy,'b')
xlabel('X Shaking Force (lbf)')
ylabel('Y Shaking Force (lbf)')
title('Y Shaking Force vs X Shaking Force (mBAL = 0)')
legend('Analytical','Simulation')

%% Problem 4
clc,clear, close all

R = .985; %in
L = 4.33; %in
m3B = 0.3509; %lbm
m3C = 0.1111; %lbm

m3 = m3B + m3C;

m4 = .781; %lbm
BG3 = 1.043; %in
JG3 = 1.5; %lbm*in^2
mBAL = m3B; %lbm
g = 386.088; %in/sec^2



data = load('SliderCrank_Shaking2.dta');

t = data(:,1);
dt = t(2) - t(1); %sec

theta0 = 0; %rad
thetadot = 1000*(2*pi/60); %rad/sec
theta = thetadot*t + theta0; %rad
phi = asin((R/L)*sin(theta));
s = R*cos(theta) + L*cos(phi);

sdot = gradient(s)/dt;
sdotdot = gradient(sdot)/dt;

Fx2on1_sim = -data(:,2);
Fx2on1_sim(1) = Fx2on1_sim(2);

Fy2on1_sim = -data(:,3);
Fy2on1_sim(1) = Fy2on1_sim(2);

Fy4on1_sim = -data(:,7);
Fy4on1_sim(1) = Fy4on1_sim(2);

% Fx2on1 = (m3B - mBAL)*R*thetadot.^2.*cos(theta) - (m3C + m4)*sdotdot;
% 
% Fy2on1 = (m3B - mBAL)*R*thetadot.^2.*sin(theta) + (m3C + m4)*sdotdot.*tan(phi);
% Fy4on1 = -(m3C + m4)*sdotdot.*tan(phi);

%matrix equation
Fx = R*thetadot^2*((m3B - mBAL)*cos(theta) + (m3C + m4)*(cos(theta) + (R/L)*cos(2*theta)))/g;

Fy = R*thetadot^2*((m3B - mBAL)*sin(theta))/g;

step = 20;

figure(3)
% plot(Fx2on1,Fy2on1+Fy4on1,'b',Fx2on1_sim,Fy2on1_sim+Fy4on1_sim,'ro')
plot(Fx,Fy,'b',Fx2on1_sim(1:step:end),Fy2on1_sim(1:step:end)+Fy4on1_sim(1:step:end),'ro')
% plot(Fx,Fy,'b')
xlabel('X Shaking Force (lbf)')
ylabel('Y Shaking Force (lbf)')
title('Y Shaking Force vs X Shaking Force (mBAL = m3B)')
legend('Analytical','Simulation')
ylim([-10 10])

%% Problem 5
clc,clear, close all

R = .985; %in
L = 4.33; %in
m3B = 0.3509; %lbm
m3C = 0.1111; %lbm

m3 = m3B + m3C;

m4 = .781; %lbm
BG3 = 1.043; %in
JG3 = 1.5; %lbm*in^2
mBAL = m3C + m4; %lbm
g = 386.088; %in/sec^2



data = load('SliderCrank_Shaking3.dta');

t = data(:,1);
dt = t(2) - t(1); %sec

theta0 = 0; %rad
thetadot = 1000*(2*pi/60); %rad/sec
theta = thetadot*t + theta0; %rad
phi = asin((R/L)*sin(theta));
s = R*cos(theta) + L*cos(phi);

sdot = gradient(s)/dt;
sdotdot = gradient(sdot)/dt;

Fx2on1_sim = -data(:,2);
Fx2on1_sim(1) = Fx2on1_sim(2);

Fy2on1_sim = -data(:,3);
Fy2on1_sim(1) = Fy2on1_sim(2);

Fy4on1_sim = -data(:,7);
Fy4on1_sim(1) = Fy4on1_sim(2);

% Fx2on1 = (m3B - mBAL)*R*thetadot.^2.*cos(theta) - (m3C + m4)*sdotdot;
% 
% Fy2on1 = (m3B - mBAL)*R*thetadot.^2.*sin(theta) + (m3C + m4)*sdotdot.*tan(phi);
% Fy4on1 = -(m3C + m4)*sdotdot.*tan(phi);

%matrix equation
Fx = R*thetadot^2*((m3B - mBAL)*cos(theta) + (m3C + m4)*(cos(theta) + (R/L)*cos(2*theta)))/g;

Fy = R*thetadot^2*((m3B - mBAL)*sin(theta))/g;

step = 20;

figure(3)
% plot(Fx2on1,Fy2on1+Fy4on1,'b',Fx2on1_sim,Fy2on1_sim+Fy4on1_sim,'ro')
plot(Fx,Fy,'b',Fx2on1_sim(1:step:end),Fy2on1_sim(1:step:end)+Fy4on1_sim(1:step:end),'ro')
% plot(Fx,Fy,'b')
xlabel('X Shaking Force (lbf)')
ylabel('Y Shaking Force (lbf)')
title('Y Shaking Force vs X Shaking Force (mBAL = m3C + m4)')
legend('Analytical','Simulation')

Fs_analytical = max(Fx)
Fs_sim = max(Fx2on1_sim)
