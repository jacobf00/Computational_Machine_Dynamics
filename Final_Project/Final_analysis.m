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

load('data_WM.mat')
%% Solidworks

posx_nom = readmatrix('xdisp_nom.csv');
posy_nom = readmatrix('ydisp_nom.csv');

plot(posx_nom(:,2),posy_nom(:,2))
