%% Working Model
clc,clear,close all

% data = load('Final_model_WM.dta');
% 
% t_WM = data(:,1);
% P_WM = data(:,[2 6]);
% V_WM = data(:,[3 7]);
% A_WM = data(:,[4 8]);
% 
% save('data_WM','t_WM','P_WM','V_WM','A_WM')

load('data_original_WM.mat')
load('data_m10p_WM.mat')
load('data_m20p_WM.mat')
load('data_20rpm_WM.mat')
load('data_30rpm_WM.mat')



%% Solidworks

posx_nom = readmatrix('xdisp_nom.csv');
posy_nom = readmatrix('ydisp_nom.csv');
posy_nom_gnd = posy_nom(:,2)+.82;

posx_10s = readmatrix('xdisp_10S.csv');
posy_10s = readmatrix('ydisp_10S.csv');

posx_20s = readmatrix('xdisp_20S.csv');
posy_20s = readmatrix('ydisp_20S.csv');

posx_nom_20rpm = readmatrix('xdisp_nom_20rpm.csv');
posy_nom_20rpm = readmatrix('ydisp_nom_20rpm.csv');


velx_nom_20rpm = gradient(posx_nom_20rpm(:,2),posx_nom_20rpm(:,1));
accx_nom_20rpm = gradient(velx_nom_20rpm,posx_nom_20rpm(:,1));

velx_nom = gradient(posx_nom(:,2),posx_nom(:,1));
accx_nom = gradient(velx_nom,posx_nom(:,1));

gnd_height = 0;
gnd_touch_nom = zeros(1,4);
j = 1;
for i = 1:length(posy_nom_gnd)
    if posy_nom_gnd(i) <= gnd_height + .00105 && posy_nom_gnd(i) >= gnd_height - .00105
        gnd_touch_nom(j) = i;
        j = j+1;
    end
end

figure
plot(posy_nom(:,1), posy_nom_gnd,posx_nom(:,1),accx_nom)
yline(gnd_height)
for i = 1:numel(gnd_touch_nom)
    xline(posy_nom(gnd_touch_nom(i),1))
end

figure
plot(posy_nom(:,1),accx_nom,posy_nom_20rpm(:,1),accx_nom_20rpm)
legend ('10rpm', '20rpm')
%% Plotting

% Different lengths SW
figure
hold on 
plot(posx_nom(:,2),posy_nom(:,2),'b')
plot(posx_10s(:,2),posy_10s(:,2))
plot(posx_20s(:,2),posy_20s(:,2))
hold off
axis equal
xlabel('Leg ground x position [m]')
ylabel('Leg ground y position [m]')
title('Leg ground point path (SolidWorks)')
legend('original','minus 10% driver length', 'minus 20% driver length')

%Different lengths WM
figure
plot(P_original_WM(:,1),P_original_WM(:,2),'b')
hold on
plot(P_m10p_WM(:,1),P_m10p_WM(:,2))
plot(P_m20p_WM(:,1),P_m20p_WM(:,2))
hold off
axis equal
xlabel('Leg ground x position [m]')
ylabel('Leg ground y position [m]')
title('Leg ground point path (Working Model)')
legend('original','minus 10% driver length', 'minus 20% driver length')

% Different lengths WM vs SW leg path to validate SW and WM accuracy
step = 2;
x_adjust = .376791;
figure
plot(P_original_WM(:,1),P_original_WM(:,2),'b',posx_nom(1:step:end,2)+x_adjust,posy_nom(1:step:end,2),'ro')
hold on
plot(posx_10s(1:step:end,2)+x_adjust,posy_10s(1:step:end,2),'ro',P_m10p_WM(:,1),P_m10p_WM(:,2),'b')
plot(posx_20s(1:step:end,2)+x_adjust,posy_20s(1:step:end,2),'ro',P_m20p_WM(:,1),P_m20p_WM(:,2),'b')
hold off
axis equal
xlabel('Leg ground x position [m]')
ylabel('Leg ground y position [m]')
title('Leg ground point path (Working Model vs Solidworks)')
legend('Working Model','SolidWorks')

% PVA comparison between different RPMs

speed_10rpm = 10*(2*pi)/60; %rad/sec
speed_20rpm = 20*(2*pi)/60; %rad/sec
speed_30rpm = 30*(2*pi)/60; %rad/sec

theta_original = speed_10rpm*t_original_WM; %rad
theta_20rpm = speed_20rpm*t_20rpm_WM; %rad
theta_30rpm = speed_30rpm*t_30rpm_WM; %rad


figure
subplot(3,1,1)
plot(theta_original,P_original_WM(:,1),theta_20rpm,P_20rpm_WM(:,1),theta_30rpm,P_30rpm_WM(:,1))
ylabel('x position of foot [m]')
legend('10 rpm', '20 rpm', '30 rpm')
title('x P-V-A compared at different driver speeds')

subplot(3,1,2)
plot(theta_original,V_original_WM(:,1),theta_20rpm,V_20rpm_WM(:,1),theta_30rpm,V_30rpm_WM(:,1))
ylabel('x velocity of foot [m/s]')
legend('10 rpm', '20 rpm', '30 rpm')

subplot(3,1,3)
plot(theta_original,A_original_WM(:,1),theta_20rpm, A_20rpm_WM(:,1),theta_30rpm, A_30rpm_WM(:,1))
ylabel('x acceleration of foot [m/s^2]')
xlabel('driver angle [rad]')
legend('10 rpm', '20 rpm', '30 rpm')
ylim([-8 8])


figure
subplot(3,1,1)
plot(theta_original,P_original_WM(:,2),theta_20rpm,P_20rpm_WM(:,2),theta_30rpm,P_30rpm_WM(:,2))
ylabel('y position of foot [m]')
legend('10 rpm', '20 rpm', '30 rpm')
title('y P-V-A compared at different driver speeds')

subplot(3,1,2)
plot(theta_original,V_original_WM(:,2),theta_20rpm,V_20rpm_WM(:,2),theta_30rpm,V_30rpm_WM(:,2))
ylabel('y velocity of foot [m/s]')
legend('10 rpm', '20 rpm', '30 rpm')

subplot(3,1,3)
plot(theta_original,A_original_WM(:,2),theta_20rpm, A_20rpm_WM(:,2),theta_30rpm, A_30rpm_WM(:,2))
ylabel('y acceleration of foot [m/s^2]')
xlabel('driver angle [rad]')
legend('10 rpm', '20 rpm', '30 rpm')
% ylim([-8 8])


% Acc in the x vs pos in the y for different rpms
gnd_height = 0;
gnd_touch_nom_wm = zeros(1,4);
error = .001;
j = 1;
det = 1;
for i = 1:length(P_original_WM)
    if det == 1
        if P_original_WM(i,2)+.8 <= gnd_height + error && P_original_WM(i,2)+.8 >= gnd_height - error
            gnd_touch_nom_wm(j) = i;
            j = j+1;
            det = 20;
        end
    end
    if det > 1
        det = det-1;
    end
end
gnd_touch_nom_20 = zeros(1,4);
error = .001;
j = 1;
det = 1;
for i = 1:length(P_20rpm_WM)
    if det == 1
        if P_20rpm_WM(i,2)+.8 <= gnd_height + error && P_20rpm_WM(i,2)+.8 >= gnd_height - error
            gnd_touch_nom_20(j) = i;
            j = j+1;
            det = 20;
        end
    end
    if det > 1
        det = det-1;
    end
end
gnd_touch_nom_30 = zeros(1,4);
error = .001;
j = 1;
det = 1;
for i = 1:length(P_30rpm_WM)
    if det == 1
        if P_30rpm_WM(i,2)+.8 <= gnd_height + error && P_30rpm_WM(i,2)+.8 >= gnd_height - error
            gnd_touch_nom_30(j) = i;
            j = j+1;
            det = 20;
        end
    end
    if det > 1
        det = det-1;
    end
end

figure
subplot(3,1,1)
plot(theta_original,P_original_WM(:,2)+.8,theta_original,A_original_WM(:,1))
% yline(gnd_height)

for i = 1:numel(gnd_touch_nom_wm)
    xline(theta_original(gnd_touch_nom_wm(i)))
end
ylim([-1,1])
xlim([0,12])

subplot(3,1,2)
plot(theta_20rpm,P_20rpm_WM(:,2)+.8,theta_20rpm,A_20rpm_WM(:,1))
% yline(gnd_height)
for i = 1:numel(gnd_touch_nom_20)
    xline(theta_20rpm(gnd_touch_nom_20(i)))
end
ylim([-3.4,3.4])
xlim([0,12])

subplot(3,1,3)
plot(theta_30rpm,P_30rpm_WM(:,2)+.8,theta_30rpm,A_30rpm_WM(:,1))
% yline(gnd_height)
for i = 1:numel(gnd_touch_nom_30)
    xline(theta_30rpm(gnd_touch_nom_30(i)))
end
ylim([-7.6,6.5])
xlim([0,12])
