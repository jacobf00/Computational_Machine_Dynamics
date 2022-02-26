function [ p, v, a, j ] = filt_7pt_mat( x, h )
% Savitsky-Golay 7-point cubic interpolant and derivatives
% -3dB low-pass cutoff at 16% of sampling frequency
%
% USAGE
% [ p, v, a, j ] = filt_7pt_mat( x, h )
%
% INPUTS
% x - kxn matrix of raw samples
% k = number of coordinates - scalar k=1, 2D k=2, 3D k=3, etc.
% n = number of samples
% h - sampling interval
%
% OUTPUTS
% p - kxn position matrix
% v - kxn velocity matrix
% a - kxn acceleration matrix
% j - kxn jerk matrix
% HJSIII, 11.02.08 - tested under MATLAB v7.5
%
% H.J. Sommer III, Ph.D., Professor of Mechanical Engineering, 337 Leonhard Bldg
% The Pennsylvania State University, University Park, PA 16802
% (814)863-8997 FAX (814)865-9693 hjs1@psu.edu www.mne.psu.edu/sommer/
% number of samples
[ k, n ] = size(x);
nm1 = n - 1;
nm2 = n - 2;
nm3 = n - 3;
nm4 = n - 4;
nm5 = n - 5;
nm6 = n - 6;
% initialize
p = zeros(k,n);
v = zeros(k,n);
a = zeros(k,n);
j = zeros(k,n);
% Savitsky-Golay 7 point cubic interpolant coefficients
% deriv x(i+3) x(i+2) x(i+1) x(i) x(i-1) x(i-2) x(i-3) divisor
% 0 -2 +3 +6 +7 +6 +3 -2 21
% 1 -22 +67 +58 -58 -67 +22 252*h
% 2 +5 -3 -4 -3 +5 42*h*h
% 3 +1 -1 -1 +1 +1 -1 6*h*h*h
p(:,4:nm3) = ( -2*x(:,7:n) +3*x(:,6:nm1) +6*x(:,5:nm2) +7*x(:,4:nm3) ...
 +6*x(:,3:nm4) +3*x(:,2:nm5) -2*x(:,1:nm6) ) /21;
v(:,4:nm3) = ( -22*x(:,7:n) +67*x(:,6:nm1) +58*x(:,5:nm2) ...
 -58*x(:,3:nm4) -67*x(:,2:nm5) +22*x(:,1:nm6) ) /252 /h;
a(:,4:nm3) = ( +5*x(:,7:n) -3*x(:,5:nm2) -4*x(:,4:nm3) ...
 -3*x(:,3:nm4) +5*x(:,1:nm6) ) /42 /h /h;
j(:,4:nm3) = ( x(:,7:n) -x(:,6:nm1) -x(:,5:nm2) ...
 +x(:,3:nm4) +x(:,2:nm5) -x(:,1:nm6) ) /6 /h /h /h;
% first three
b0 = p(:,4);
b1 = v(:,4)*h;
b2 = a(:,4)*h*h/2;
b3 = j(:,4)*h*h*h/6;
p(:,1:3) = [ b0-3*b1+9*b2-27*b3 b0-2*b1+4*b2-8*b3 b0-b1+b2-b3 ];
v(:,1:3) = [ b1-6*b2+27*b3 b1-4*b2+12*b3 b1-2*b2+3*b3 ]/h;
a(:,1:3) = [ 2*b2-18*b3 2*b2-12*b3 2*b2-6*b3 ]/h/h;
j(:,1:3) = [ j(:,4) j(:,4) j(:,4) ];
% last three
b0 = p(:,nm3);
b1 = v(:,nm3)*h;
b2 = a(:,nm3)*h*h/2;
b3 = j(:,nm3)*h*h*h/6;
p(:,nm2:n) = [ b0+b1+b2+b3 b0+2*b1+4*b2+8*b3 b0+3*b1+9*b2+27*b3 ];
v(:,nm2:n) = [ b1+2*b2+3*b3 b1+4*b2+12*b3 b1+6*b2+27*b3 ]/h;
a(:,nm2:n) = [ 2*b2+6*b3 2*b2+12*b3 2*b2+18*b3 ]/h/h;
j(:,nm2:n) = [ j(:,nm3) j(:,nm3) j(:,nm3) ];
return
% bottom of filt_7pt_mat.m