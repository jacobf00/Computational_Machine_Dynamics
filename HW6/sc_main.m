
% sc_main.m - D-mechanism four-bar - ref: Haug, Fig P5.1, page 196
% main
% HJSIII - 22.02.13
% initialize
sc_ini
% starting position
phi2_start = 0 * d2r; % start at zero
% time loop
% tpr = 2 * pi / w2; % one revolution at constant speed
t_start = 0; % start
% t_end = tpr; % end
t_end = .01; %sec
nt = 180; % number of time steps
dt = (t_end - t_start) / nt;
keep_q = [];
keep = [];
for t = t_start : dt : t_end
% kinematics
 sc_kin
 
% save kinematics
 detJAC = det(JAC);
 x3P = r3P(1);
 y3P = r3P(2);
 x3Pd = r3Pd(1);
 y3Pd = r3Pd(2);
 keep_q = [ keep_q ; q' qd' qdd' ];
 keep = [ keep ; detJAC x3P y3P x3Pd y3Pd ];
% bottom - for t
end
% data for plotting
ang2 = keep_q(:,3) /d2r;
phi4d = keep_q(:,18);
phi4dd = keep_q(:,27);
detJAC = keep(:,1);
x3P = keep(:,2);
y3P = keep(:,3);
x3Pd = keep(:,4);
y3Pd = keep(:,5);
% four figures per page 
figure( 1 )
% locus of coupler point
subplot( 2,2,1 )
 plot( x3P,y3P,plot_str )
 hold on
 axis( [70 140 -25 45] )
 axis square
 xlabel( 'xP [mm]' )
 ylabel( 'yP [mm]' )
% follower velocity
subplot( 2,2,2 )
 plot( ang2, phi4d, plot_str )
 hold on
 axis( [ 0 360 -100 100 ] )
 xlabel( 'Phi2 [deg]' )
 ylabel( 'Omega4 [rad/s]' )
 legend( [ 'L4=', num2str(len4) ] )
% follower acceleration
subplot( 2,2,3 )

plot( ang2, phi4dd, plot_str )
 hold on
 axis( [ 0 360 -40000 20000 ] )
 xlabel( 'Phi2 [deg]' )
 ylabel( 'Alpha4 [rad/s^2]' )
% Jacobian
subplot( 2,2,4 )
 plot( ang2, detJAC, plot_str )
 hold on
 axis( [ 0 360 -1500 0 ] )
 xlabel( 'Phi2 [deg]' )
 ylabel( 'det(JAC) [mm^2]' )
% coupler point velocity - quiver plot
npos = length( x3P );
iskip = (1:12:npos);
figure( 2 )
 quiver( x3P(iskip),y3P(iskip), x3Pd(iskip),y3Pd(iskip) )
 axis( [70 140 -25 45] )
 axis square
 hold on
 plot( x3P(iskip),y3P(iskip),'bo' )
 xlabel( 'xP [mm]' )
 ylabel( 'yP [mm]' )
 title( [ 'D mechanism - L4 = ' num2str(len4) ] )
% bottom - dm_main 
