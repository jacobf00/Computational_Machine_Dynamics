% show_body2.m - show motion for collision detection
% HJSIII, 19.04.24
clc,clear,close all
% motion data
% time x2 y2 phi2 x3 y3 phi3
% [sec] [in] [in] [rad] [in] [in] [rad]
all = [ 0 0 15.0000 0 0 0 0 ;
 1.0000 5.0000 20.0000 -0.3000 6.6000 0 0.2000 ;
 2.0000 10.0000 24.0000 -0.6000 13.0684 1.3112 0.4000 ;
 3.0000 15.0000 27.0000 -0.9000 19.1474 3.8814 0.6000 ;
 4.0000 20.0000 29.0000 -1.2000 24.5947 7.6080 0.8000 ;
 5.0000 25.0000 30.0000 -1.5000 29.1929 12.3426 1.0000 ;
 6.0000 30.0000 30.0000 -1.8000 32.7589 17.8963 1.2000 ;
 7.0000 35.0000 29.0000 -2.1000 35.1505 24.0477 1.0000 ;
 8.0000 40.0000 27.0000 -2.4000 38.7165 29.6014 0.8000 ;
 9.0000 45.0000 24.0000 -2.7000 43.3147 34.3360 0.6000 ;
 10.0000 50.0000 20.0000 -3.0000 48.7620 38.0626 0.4000 ];
time = all(:,1)'; % size 1 x nt
r2_all = all(:,2:3)'; % size 2 x nt
phi2_all = all(:,4)'; % size 1 x nt
r3_all = all(:,5:6)';
phi3_all = all(:,7)';
ntime = length( time );
% define object 2 in local coordinates
s2p_poly = [ 2 3 -1 -1 2 ; % local x2p [in]
             3 -1 -2 2 3 ]; % local y2p [in]

s3p_poly = [ 2 1 -1 2 ; % local x2p [in]
             3 -2 0 3 ]; % local y2p [in]

rho2 = max( sqrt( diag( s2p_poly'*s2p_poly ) ) ); % maximum radius
[ nr, n2 ] = size( s2p_poly ); % number of points for body 2

rho3 = max( sqrt( diag( s3p_poly'*s3p_poly ) ) ); % maximum radius
[ nr, n3 ] = size( s3p_poly ); % number of points for body 2
BC_collisions = zeros(1,ntime);
PiP_2in3 = zeros(1,ntime);
PiP_3in2 = zeros(1,ntime);
% new figure
figure( 1 )
 clf
% plot origin and outline at each time sample
 for itime = 1 : ntime
 t = time(itime);
% body 2 = red 
 r2 = r2_all(:,itime); % origin
 r3 = r3_all(:,itime); % origin
 
 dist_r3r2 = r3 - r2;
 dist_r3r2 = sqrt(dist_r3r2'*dist_r3r2); % calculate magnitude dist between r3 and r2
 if dist_r3r2 < (rho2 + rho3)
     BC_collisions(itime) = 1; % if the magnitude distance is lower than the sum of rhos, change 0 to 1 in array
 end
 
 phi2 = phi2_all(itime); % angle
 phi3 = phi3_all(itime); % angle
 
 A2 = [ cos(phi2) -sin(phi2) ; % attitude matrix
 sin(phi2) cos(phi2) ];
 A3 = [ cos(phi3) -sin(phi3) ; % attitude matrix
 sin(phi3) cos(phi3) ];

 r2_poly = r2*ones(1,n2) + A2*s2p_poly; % global locations for vertices 
 r3_poly = r3*ones(1,n3) + A3*s3p_poly; % global locations for vertices 
 
 %find point in polygon collisions
 %find points p2 in p3
 
 IN_2in3 = inpolygon(r2_poly(1,1:end-1),r2_poly(2,1:end-1),r3_poly(1,1:end-1),r3_poly(2,1:end-1));
 verticies_2in3 = find(IN_2in3==1);
 if ~isempty(verticies_2in3)
    fprintf('Body 2 vertices shown below are in body 3 at time=%i\n',t)
    verticies_2in3
 end
 if any(IN_2in3==1)
     PiP_2in3(itime) = 1;
 end
 IN_3in2 = inpolygon(r3_poly(1,1:end-1),r3_poly(2,1:end-1),r2_poly(1,1:end-1),r2_poly(2,1:end-1));
 verticies_3in2 = find(IN_3in2==1);
 if ~isempty(verticies_3in2)
    fprintf('Body 3 vertices shown below are in body 2 at time=%i\n',t)
    verticies_3in2
 end
 if any(IN_3in2==1)
     PiP_3in2(itime) = 1;
 end
 
 % find intersections using polyxpoly
 [XI,YI,II] = polyxpoly(r2_poly(1,:),r2_poly(2,:),r3_poly(1,:),r3_poly(2,:));
 if ~isempty(XI)
     fprintf('Edge intersections at time=%i\n',t)
     disp('xi yi edge2 edge3')
     for i=1:length(XI)
         fprintf('%f  %f  %i  %i\n',XI(i),YI(i),II(i,1),II(i,2))
     end
     disp(' ')
 end
%  disp(IN_2in3)
%  for i=1:(length(r2_poly)-1)
%      x2 = r2_poly(1,i);
%      y2 = r2_poly(2,i);
%      if inpolygon(x2,y2,r3_poly(1,end),r3_poly(2,end))
%          disp('did it!')
%          PiP_2in3(itime) = 1;
%      end
%  end
%  
%  %find points p3 in p2
%   for i=1:(length(r3_poly)-1)
%      x3 = r3_poly(1,i);
%      y3 = r3_poly(2,i);
%      if inpolygon(x3,y3,r2_poly(1,end-1),r2_poly(2,end-1))
%          PiP_3in2(itime) = 1;
%      end
%  end
 
 plot( r2(1),r2(2),'ro',r3(1),r3(2),'bo' ) % plot origin
 axis equal
 hold on
 plot( r2_poly(1,:), r2_poly(2,:), 'r',r3_poly(1,:),r3_poly(2,:),'b' ) % closed curve
 if ~isempty(verticies_2in3)
     plot(r2_poly(1,verticies_2in3),r2_poly(2,verticies_2in3),'ro')
 end
 if ~isempty(verticies_3in2)
     plot(r3_poly(1,verticies_3in2),r3_poly(2,verticies_3in2),'ro')
 end
 plot(XI,YI,'go')
 end % bottom - for itime
 title('Body 2 and 3 trajectory with Point-in-polygon and edge intersection collisions visualized')

 BC_collision_times = find(BC_collisions==1) - 1;
 fprintf('Problem 3:\nObjects are candidates for collision as determined by the bounding circles test at times shown in the array below\n')
 BC_collision_times
 fprintf('Problem 4:\nObjects are candidates for collision as determined by the point-in-polygon for body 2 in body 3 test at times shown in the array below\n')
 PiP_2in3_times = find(PiP_2in3==1)-1
 fprintf('Problem 4:\nObjects are candidates for collision as determined by the point-in-polygon for body 3 in body 2 test at times shown in the array below\n')
 PiP_3in2_times = find(PiP_3in2==1)-1
 fprintf('Problem 5: edge intersections can be found above in output')
 
% bottom - show_body2.m