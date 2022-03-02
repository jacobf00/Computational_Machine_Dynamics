
%% Problem 1 - import motion analysis data
clc,clear,close all

theta4Table = readtable('Link4-theta4.csv','NumHeaderLines',2);
dtheta4Table = readtable('Link4-theta4dot.csv','NumHeaderLines',2);
ddtheta4Table = readtable('Link4-theta4dotdot.csv','NumHeaderLines',2);

theta2_start = pi;
t = theta4Table{:,1};
theta2_sim = (30*((2*pi)/60))*t + theta2_start;
theta2_sim = rad2deg(theta2_sim);

theta4_sim = theta4Table{:,2} + 180;
theta4dot_sim = dtheta4Table{:,2};
theta4dotdot_sim = ddtheta4Table{:,2};



%% Problem 2 - Four bar position check


r1 = 13; %in
r2 = 4; %in
r3 = 15; %in
r4 = 20; %in
% theta1 = 0; %deg
%{
the minimum theta4 occurs at theta2 = 90 deg, maximum theta4 occurs at theta2 = -90 deg
%}
 
theta2 = theta2_sim; %deg

%initial theta1 and theta2 guesses
% theta3 = 0; %deg
% theta4 = 90; %deg
theta4 = zeros(length(theta2),1);
theta3 = zeros(length(theta2),1);
% count = 0;
for i=1:length(theta2)
%     count = count + 1;
    e = sqrt(r1^2 + r2^2 - 2*r1*r2*cosd(theta2(i)));

    alpha = asind((r2*sind(theta2(i)))/e);

    gamma = acosd((r3^2 + r4^2 - e^2)/(2*r3*r4));

    beta = asind((r3*sind(gamma))/e);

    theta4(i) = 180 - alpha - beta;
    theta3(i) = theta4(i) - gamma;

end

dt = t(2) - t(1);
theta4dot = gradient(theta4,dt);
theta4dotdot = gradient(theta4dot,dt);

%% Plot data


figure(1)
subplot(3,1,1)
plot(theta2_sim,theta4_sim,'o',theta2,theta4)
xlabel('theta2 (deg)')
ylabel('theta4 (deg)')
title('Theta4 vs Theta2')
legend('SolidWorks','Geometric')

subplot(3,1,2)
plot(theta2_sim,theta4dot_sim,'o',theta2,theta4dot)
xlabel('theta2 (deg)')
ylabel('theta4dot (deg/sec)')
title('Theta4dot vs Theta2')
legend('SolidWorks','Geometric')

subplot(3,1,3)
plot(theta2_sim,theta4dotdot_sim,'o',theta2,theta4dotdot)
xlabel('theta2 (deg)')
ylabel('theta4dotdot (deg/sec^2)')
title('Theta4dotdot vs Theta2')
legend('SolidWorks','Geometric')