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

plot(posx_nom(:,2),posy_nom(:,2))



%% Plotting

% Original length WM vs SW leg path
step = 2;
figure(1)
plot(P_original_WM(:,1),P_original_WM(:,2),posx_nom(1:step:end,2)+.376791,posy_nom(1:step:end,2),'ro')
xlabel('Leg ground x position [m]')
ylabel('Leg ground y position [m]')
title('Leg ground point path')
legend('Working Model','SolidWorks')