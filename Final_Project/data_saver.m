clc,clear, close all

data = load('WM_30rpm.dta');

t_30rpm_WM = data(:,1);
P_30rpm_WM = data(:,[2 6]);
V_30rpm_WM = data(:,[3 7]);
A_30rpm_WM = data(:,[4 8]);

save('data_30rpm_WM','t_30rpm_WM','P_30rpm_WM','V_30rpm_WM','A_30rpm_WM')

load('data_30rpm_WM.mat')
