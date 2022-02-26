
% hc_dig.m - digitize ball launched from howitzer cart in MP4 video
% HJSIII, 19.12.04
clear
% video file name
fn_input = [ 'howitzer_cart.mp4' ];
% create video file reader object
VR_obj = VideoReader( fn_input );
% get video information
video_fps = VR_obj.FrameRate; % frames per second
%video_duration = VR_obj.Duration; % sec
%video_frames = VR_obj.NumberOfFrames; % must recreate object to rewind after using NumberofFrames

%video_width = VR_obj.Width;
%video_height = VR_obj.Height;
% step through video
iframe = 0;
keep = [];
while hasFrame( VR_obj )
 a_rgb = readFrame( VR_obj ); % "readFrame" returns class uint8
 [ nr, nc, nk ] = size( a_rgb );
 iframe = iframe + 1;
 
% save first frame as JPG
 s_frame = [ '000' num2str(iframe) ];
 fn_frame = [ 'frame' s_frame( end-2 : end ) '.jpg' ];
 if (iframe==1 || iframe==6)
 imwrite( a_rgb, fn_frame )
 end
% only analyze frame 2 through 23
 if ( iframe > 1 ) & (iframe< 24 )
 
% convert to CIE L*a*b*
% L* intensity 0=dark, 100=bright - a_lab(:,:,1)
% a* green<0, red>0 - a_lab(:,:,2)
% b* blue<0, yellow>0 - a_lab(:,:,3)
 a_lab = rgb2lab( a_rgb ); % size (nr,nc,3) - class double
% find dark pixels for ball
 bw_dark = ( a_lab(:,:,1) < 40 ); % size (nr,nc) - class logical
% find yellow pixels for dot on cart
 bw_yellow = ( a_lab(:,:,3) > 35 ); % size (nr,nc) - class logical
% find centroid of one object in each black/white image
% use reduced AOI for ball - rows 51 to 355, columns 11 to 640
 s_ball = regionprops( bw_dark( 51:355, 11:640 ) ); % class structure - returns Area, Centroid, BoundingBox

 s_cart = regionprops( bw_yellow );
% area, centroid column and row, bounding box stored in structure
 area_ball = cat( 1, s_ball.Area ); % size (n,1) - class double
 cr_ball = cat( 1, s_ball.Centroid ); % size (n,2) - class double - column, row
 bbox_ball = cat( 1, s_ball.BoundingBox ); % size (n,4) - class double - UL col, UL row, size col, size row

 area_cart = cat( 1, s_cart.Area ); % size (n,1) - class double
 cr_cart = cat( 1, s_cart.Centroid ); % size (n,2) - class double - column, row
 bbox_cart = cat( 1, s_cart.BoundingBox ); % size (n,4) - class double - UL col, UL row, size col, size row

% add offsets for AOI
 cr_ball(1,1) = cr_ball(1,1) + 10;
 cr_ball(1,2) = cr_ball(1,2) + 50;
% new figure
figure( 1 )
 clf
 warning( 'OFF', 'images:initSize:adjustingMag' ) % disable warning for large images
 
 % RGB image in UL
 subplot( 2, 2, 1 )
 imshow( a_rgb )
 title( fn_frame )
% BW image for ball in LL
 subplot( 2, 2, 3 )
 imshow( bw_dark )
 title( 'dark L*<40' )
 hold on
 plot( [ 0 cr_ball(1,1) ], [ 0 cr_ball(1,2) ], 'r' ) % line from origin to centroid
 
% BW image for cart in LR
 subplot( 2, 2, 4 )
 imshow( bw_yellow )
 title( 'yellow b*>35' )
 hold on
 plot( [ 0 cr_cart(1,1) ], [ 0 cr_cart(1,2) ], 'y' ) % line from origin to centroid
 
% update graphics
 drawnow
% save centroids
 keep = [ keep ; [ cr_ball(1,:) cr_cart(1,:) ] ];
 
 end % bottom - if iframe 
end % bottom - while hasFrame
% row number increases in negative y direction
keep(:,2) = nr - keep(:,2); 
keep(:,4) = nr - keep(:,4);
% show x-y results
figure( 2 )
 clf
 plot( keep(:,1),keep(:,2),'r', keep(:,3),keep(:,4),'g' )
 axis equal
 
% save to TXT file - x_ball y_ball x_cart y_cart
save( 'hc_keep.txt', 'keep', '-ascii' )
% bottom - hc_dig
