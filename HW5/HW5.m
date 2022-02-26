clc,clear,close all

%% Plots for Inversion 1

load('WANZER.dta')

t = WANZER(:,2);
pos = WANZER(:,5);
vel = WANZER(:,9);
acc = WANZER(:,14);
w = WANZER(:,end);

figure(1)
plot(w,pos)
xlabel('Rotation (radians)')
ylabel('Position (mm/s)')
title('Pos vs Rotation')

figure(2)
plot(w,vel)
xlabel('Rotation (radians)')
ylabel('Velocity (mm/s^2)')
title('Velocity vs Rotation')

figure(3)
plot(w,acc)
xlabel('Rotation (radians)')
ylabel('Acceleration (mm)')
title('Acceleration vs Rotation')
ylim([-20000 60000])

%% Plots for Inversion 2

load('WANZER2.dta')

t = WANZER2(:,2);
pos = WANZER2(:,5);
vel = WANZER2(:,9);
acc = WANZER2(:,14);
w = WANZER2(:,end);

figure(4)
plot(w,pos)
xlabel('Rotation (radians)')
ylabel('Position (mm)')
title('Pos vs Rotation')

figure(5)
plot(w,vel)
xlabel('Rotation (radians)')
ylabel('Velocity (mm/s)')
title('Velocity vs Rotation')

figure(6)
plot(w,acc)
xlabel('Rotation (radians)')
ylabel('Acceleration (mm/s^2)')
title('Acceleration vs Rotation')
ylim([-20000 60000])