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
clc,clear,close all

load('conn_rod_CCW.txt')
load('hole_B_CCW.txt')
load('hole_C_CCW.txt')

d2r = pi / 180;

t = .75; %in
rho = 0.0975437; %lbm/in^3

%reverse direction of hole numbers
hole_B_CW = zeros(size(hole_B_CCW));
hole_B_CW(:,1) = hole_B_CCW(end:-1:1,1);
hole_B_CW(:,2) = hole_B_CCW(end:-1:1,2);

hole_C_CW = zeros(size(hole_C_CCW));
hole_C_CW(:,1) = hole_C_CCW(end:-1:1,1);
hole_C_CW(:,2) = hole_C_CCW(end:-1:1,2);

x = [conn_rod_CCW(:,1)' hole_B_CW(:,1)' hole_C_CW(:,1)' conn_rod_CCW(1,1)];
y = [conn_rod_CCW(:,2)' hole_B_CW(:,2)' hole_C_CW(:,2)' conn_rod_CCW(1,2)];

[ geom, iner, cpmo ] = polygeom( x, y );

area = geom(1);
x_cen = geom(2);
y_cen = geom(3);
perimeter = geom(4);
disp( [ ' ' ] )
disp( [ 'Connecting Rod 3' ] )
disp( [ ' ' ] )
disp( [ ' area x_cen y_cen perim' ] )
disp( [ area x_cen y_cen perimeter ] )
I1 = cpmo(1);
angle1 = cpmo(2);
I2 = cpmo(3);
angle2 = cpmo(4);
disp( [ ' ' ] )
disp( [ ' I1 I2' ] )
disp( [ I1 I2 ] )
disp( [ ' angle1 angle2' ] )
disp( [ angle1/d2r angle2/d2r ] )
% plot outline
xplot = x( [ 1:end 1] );
yplot = y( [ 1:end 1] );
rad = 10;
x1 = [ x_cen-rad*cos(angle1) x_cen+rad*cos(angle1) ];
y1 = [ y_cen-rad*sin(angle1) y_cen+rad*sin(angle1) ];
x2 = [ x_cen-rad*cos(angle2) x_cen+rad*cos(angle2) ];
y2 = [ y_cen-rad*sin(angle2) y_cen+rad*sin(angle2) ];
plot( xplot,yplot,'b', x_cen,y_cen,'r+', ...
 x1,y1,'g:', x2,y2,'g:' )
axis( [ 0 rad 0 rad ] )
axis square
xlim([-2 6])
ylim([-4 4])

m3 = geom(1)*t*rho

%BG3 from plot
BG3 = x_cen

%Calculate controidal polar mass mmoent of intertia from centroidal polar
%area moment of inertia

J_boundary = t*rho*cpmo(5)

