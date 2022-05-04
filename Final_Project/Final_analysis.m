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





%% Solidworks

posx_nom = readmatrix('xdisp_nom.csv');
posy_nom = readmatrix('ydisp_nom.csv');
posy_nom_gnd = posy_nom(:,2)+.82;

posx_10s = readmatrix('xdisp_10S.csv');
posy_10s = readmatrix('ydisp_10S.csv');

posx_20s = readmatrix('xdisp_20S.csv');
posy_20s = readmatrix('ydisp_20S.csv');

figure(1)
hold on 
plot(posx_nom(:,2),posy_nom(:,2))
plot(posx_10s(:,2),posy_10s(:,2))
plot(posx_20s(:,2),posy_20s(:,2))
hold off

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

figure(3)
plot(posy_nom(:,1), posy_nom_gnd,posx_nom(:,1),accx_nom)
yline(gnd_height)
for i = 1:numel(gnd_touch_nom)
    xline(posy_nom(gnd_touch_nom(i),1))
end


%% Plotting

% Original length WM vs SW leg path
step = 2;
figure(4)
plot(P_original_WM(:,1),P_original_WM(:,2),posx_nom(1:step:end,2)+.376791,posy_nom(1:step:end,2),'ro')
xlabel('Leg ground x position [m]')
ylabel('Leg ground y position [m]')
title('Leg ground point path')
legend('Working Model','SolidWorks')