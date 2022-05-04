%% Working Model
clc,clear,close all

%% Solidworks

posx_nom = readmatrix('xdisp_nom.csv');
posy_nom = readmatrix('ydisp_nom.csv');

plot(posx_nom(:,2),posy_nom(:,2))