%% Problem 2
clc,clear,close all

g = 386.088; %in/sec^2
m3 = .462; %lbm
L = 4.33; %in
a = 3.642; %in
IDc = .707; %in

tau = [13.69 13.67 13.64 13.67 13.66 13.76 13.74 13.73 13.79 13.67];

tau = (1/20)*tau;

%calculate tau,sigma, and 100*sigma/tau
sigma = std(tau)

tau = mean(tau)

sigma_tau = 100*sigma/tau

%calculate JG3

JG3 = (m3*g*a*tau^2)/(4*pi^2) - m3*a^2

%% Problem 3
syms m3B m3C

CG3 = a - IDc/2 %in
BG3 = L - CG3 %in

Moment_eq = m3B*BG3 - m3C*CG3 == 0;
total_mass_eq = m3B + m3C == m3;

sol = solve([Moment_eq total_mass_eq],[m3B m3C]);

m3B_sol = double(sol.m3B) %lbm
m3C_sol = double(sol.m3C) %lbm

JAPP = m3B_sol*BG3^2 + m3C_sol*CG3^2 %lbm*in^2


%% Problem 4



