clc,clear,close

%% Problem 1

AB = 36; %in
AC = 42; %in
AD = 96; %in

e = 40; %in
edot = 12; %in/sec

theta = acosd((-e^2 + AC^2 + AB^2)/(2*AB*AC))

thetadot = (e*edot)/(AB*AC*sind(theta))

%% Problem 2
clc,clear,close all
% syms theta3 theta4

r1 = 90; %cm
r2 = 30; %cm
r3 = 60; %cm
r4 = 45; %cm
theta1 = 0; %deg
theta2 = 10; %deg

%initial theta1 and theta2 guesses
theta3 = 0; %deg
theta4 = 90; %deg

q = [theta3 theta4]';

iterations = 5;

for i = 1:iterations
    
    fprintf('iteration number %i \n',i)

    fh = r2*cosd(theta2) + r3*cosd(q(1)) - r4*cosd(q(2)) - r1*cosd(theta1);
    fv = r2*sind(theta2) + r3*sind(q(1)) - r4*sind(q(2)) - r1*sind(theta1);

    
    phi = [fh fv]'

    phiq = [-r3*sind(q(1)) r4*sind(q(2)); r3*cosd(q(1)) -r4*cosd(q(2))]

    grad = phiq\phi
    grad_deg = rad2deg(grad)
    
    q = q - grad_deg
    
end


%% Four bar position check
%using geometric four bar position equations to double check the answers
%found the the previous problem
clc,clear,close all

r1 = 90; %cm
r2 = 30; %cm
r3 = 60; %cm
r4 = 45; %cm
theta1 = 0; %deg
theta2 = 10; %deg

%initial theta1 and theta2 guesses
theta3 = 0; %deg
theta4 = 90; %deg

e = sqrt(r1^2 + r2^2 - 2*r1*r2*cosd(theta2));

alpha = asind((r2*sind(theta2))/e);

gamma = acosd((r3^2 + r4^2 - e^2)/(2*r3*r4));

beta = asind((r3*sind(gamma))/e);

theta4 = 180 - alpha - beta;
theta3 = theta4 - gamma;

theta3
theta4


%% Problem 3
clc,clear,close all
% syms theta3 theta4

r1 = 4.07; %cm
r2 = 1.6; %cm
r3 = 3.57; %cm
r4 = 2.24; %cm
theta1 = 110.4; %deg
theta2 = 270; %deg

%initial theta1 and theta2 guesses
theta3 = 0; %deg
theta4 = 90; %deg

q = [theta3 theta4]';

iterations = 10;

for i = 1:iterations
    
    fprintf('iteration number %i \n',i)

    fh = r2*cosd(theta2) + r3*cosd(q(1)) - r4*cosd(q(2)) - r1*cosd(theta1);
    fv = r2*sind(theta2) + r3*sind(q(1)) - r4*sind(q(2)) - r1*sind(theta1);

    
    phi = [fh fv]'

    phiq = [-r3*sind(q(1)) r4*sind(q(2)); r3*cosd(q(1)) -r4*cosd(q(2))]

    grad = phiq\phi
    grad_deg = rad2deg(grad)
    
    q = q - grad_deg
    
end




