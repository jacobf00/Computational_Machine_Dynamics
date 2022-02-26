
%% Questions 1-3
clc,clear,close all

scale = 430/1; %pixels per m
% scale = scale/100; %pixels per cm

h = 1/30; %sec/frame


load('hc_keep.txt')

mn = size(hc_keep);
frames = mn(1);
t = (0:frames-1)*h;

%scale the hc_keep values by pixels per m (convert to m)

hc_keep = hc_keep/scale;

ballx = hc_keep(:,1);
bally = hc_keep(:,2);

cartx = hc_keep(:,3);
carty = hc_keep(:,4);

%calculate the velocities of the ball

%calculate differences between each point
dx = diff(ballx);
dy = diff(bally);

%time between each frame
dt = h;

velx = dx/dt;
vely = dy/dt;

%adjusted time vector to match finite difference derivative method
t2 = t(1:end-1);
t2 = t2 + dt/2;

%calculate the accerlations of the ball

%calculate differences between each point
dvelx = diff(velx);
dvely = diff(vely);


accx = dvelx/dt;
accy = dvely/dt;

%adjusted time vector to match finite difference derivative method
t3 = t2(1:end-1);
t3 = t3 + dt/2;


%use Savitsky-Golay function to genearate interpolated pos,vel,acc data
x = [ballx bally]';

[ p, v, a, j ] = filt_7pt_mat( x, h );


%horizontal position of the ball vs time
figure(1)
subplot(3,1,1)
plot(t,ballx,'-o',t,p(1,:))
xlabel('time (s)')
ylabel('ball x (m)')
title('Horizontal Position of the ball vs time')
legend('Data','Interpolated')

%vertical position of the ball vs time
subplot(3,1,2)
plot(t,bally,'-o',t,p(2,:))
xlabel('time (s)')
ylabel('ball y (m)')
title('Vertical Position of the ball vs time')
legend('Data','Interpolated')

%vertical vs horizontal position of ball
subplot(3,1,3)
plot(ballx,bally,'-o',p(1,:),p(2,:))
xlabel('ball x (m)')
ylabel('ball y (m)')
title('Vertical vs Horizontal position of ball')
legend('Data','Interpolated')


%plot horizontal velocity vs time
figure(2)
subplot(2,1,1)
plot(t2,velx,'-o',t,v(1,:))
xlabel('time (s)')
ylabel('ball x velocity (m/s)')
title('Horizontal velocity vs time')
legend('Data','Interpolated')

%plot vertical velocity vs time
subplot(2,1,2)
plot(t2,vely,'-o',t,v(2,:))
xlabel('time (s)')
ylabel('ball y velocity (m/s)')
title('Vertical velocity vs time')
legend('Data','Interpolated')

%plot horizontal acceleration of the ball vs time
figure(3)
subplot(2,1,1)
plot(t3,accx,'-o',t,a(1,:))
xlabel('time (s)')
ylabel('ball x acceleration (m/s^2)')
title('Horizontal acceleration vs time')
legend('Data','Interpolated')

%plot vertical acceleration of the ball vs time
subplot(2,1,2)
plot(t3,accy,'-o',t,a(2,:))
xlabel('time (s)')
ylabel('ball y acceleration (m/s^2)')
title('Vertical acceleration vs time')
legend('Data','Interpolated')



%% Question 4

%calculate acceleration of gravity from slope of vertical velocity vs time
%data
n = 1;
P = polyfit(t,v(2,:),n);

slope = P(1); %m/s^2

g_mean_acc = mean(a(2,:));

fprintf('The acceleration of gravity calculated from slope (g_slope_v) is %.3f m/s^2\n',slope)
fprintf('The acceleration of gravity calculated from mean vertical acceleration of gravity (g_mean_acc) is %.3f m/s^2\n',g_mean_acc)


%% Questions 5

xcart = hc_keep(:,3);
ycart = hc_keep(:,4);



x2 = [xcart ycart]';

[ pcart, vcart, acart, jcart ] = filt_7pt_mat( x2, h );

%calculate the Coloumb friction coefficient

d = pcart(1,end) - pcart(1,1); %distance the cart travels

%ignore last three datapoints of vcart
vcartx = vcart(1,:);
vcartx(end-3:end) = NaN;

vi = vcartx(1);
vf = vcartx(end-4);

g = 9.81; %m/s^2

mew = (vi^2 - vf^2)/(2*g*d);


fprintf('\nThe coefficient of Coloumb friction on the cart is %f\n',mew)


%% Question 6

rho = 1.225; %kg/m^3
Cd = .47; %coefficient of drag for sphere
ball_diameter = 11; %pixels
ball_diameter = ball_diameter/scale; %meters
A = (pi/4)*ball_diameter^2; %m^2
F_drag = .5*rho*(v(1,:).^2)*Cd*A;

%found poloynomial to fit F_drag vs xpos data
Pwork = polyfit(p(1,:),F_drag,2);

F_drag_poly = polyval(Pwork,p(1,:));

%numerically integrated F_drag_data and F_drag_polyfit over ball x pos
W_drag_data = trapz(p(1,:),F_drag)
% disp('Newtons')
W_drag_polyfit = trapz(p(1,:),F_drag_poly)
% disp('Newtons')

figure(4)
plot(p(1,:),F_drag,p(1,:),F_drag_poly)
xlabel('ball x pos (m)')
ylabel('Force of drag (N)')
title('Force of drag vs ball x')
legend('Data', 'Polyfit')

%calculated mass of ball from derived equation from energy balance
mass_ball = (2*W_drag_polyfit)/(v(1,1)^2 - v(1,end)^2);
fprintf('The mass of the ball is %f kg\n',mass_ball)








