clc,clear, close all

data = load('Final_model_m20p.dta');

t_m20p_WM = data(:,1);
P_m20p_WM = data(:,[2 6]);
V_m20p_WM = data(:,[3 7]);
A_m20p_WM = data(:,[4 8]);

save('data_m20p_WM','t_m20p_WM','P_m20p_WM','V_m20p_WM','A_m20p_WM')

load('data_m20p_WM.mat')
