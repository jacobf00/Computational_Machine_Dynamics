% test_fft.m - example use of FFT
% HJSIII - 20.04.06
clear
% read time domain data here
% must also define time step h
% alternately create synthetic signal for testing
% synthetic - 30 Hz sine, +/- 5 mm, 0.001 sec time step
h = 0.001; % time step [sec]
f_synthetic = 30; % synthetic frequency [Hz]
x_max = 5; % size synthetic signal [mm]
t = [ 0:(1999) ]' * h; % synthetic time [sec]
x = x_max * sin( 2 * pi * f_synthetic * t ); % synthetic signal [mm]
% bottom - creating synthetic signal
% synthetic square wave
%x = sign( x );
% find number of samples and sampling frequency
n = length( x ); % number of samples
fs = 1 / h; % sampling frequency [Hz]
% FFT
% MATLAB FFT must be scaled by 2/n - DC component must be scaled scaled by 1/n
a = fft(x) * 2 / n; % complex number - units [mm]
a(1) = a(1) / 2; % offset at frequency of 0 Hz [mm]
amp = abs( a ); % amplitude at each frequency [mm]
phase = angle( a ) * 180 / pi; % phase angle [deg]
df = fs / n; % frequency resolution between spectral bands [Hz]
freq = [ 0:(n-1) ]' * df; % all frequencies [Hz]
% find peaks and list
[ peaks, i_locations ] = findpeaks( amp, 'MinPeakHeight', 0.01 ); % ignore tiny values
disp( ' ' )
disp( ' freq [Hz] peak [mm]' )
disp( [ freq(i_locations) peaks ] ) % units [Hz] [mm]
% plot time domain, amplitude, phase
figure( 1 )
subplot( 3,1,1 ) 
 plot( t, x )
 xlabel( 'Time (sec)' )
 ylabel( 'Signal [mm]' )
subplot( 3,1,2 )
 plot( freq, amp )
 xlabel( 'Frequency [Hz]' )
 ylabel( 'Amplitude [mm]' )
subplot( 3,1,3 )
 plot( freq, phase )
 xlabel( 'Frequency [Hz]' )
 ylabel( 'Phase [deg]' )
% bottom - test_fft 