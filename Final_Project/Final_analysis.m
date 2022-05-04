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


%% Plotting

% Different lengths SW
figure
hold on 
plot(posx_nom(:,2),posy_nom(:,2),'b')
plot(posx_10s(:,2),posy_10s(:,2))
plot(posx_20s(:,2),posy_20s(:,2))
hold off
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
xlabel('Leg ground x position [m]')
ylabel('Leg ground y position [m]')
title('Leg ground point path (Working Model vs Solidworks)')
legend('Working Model','SolidWorks')


