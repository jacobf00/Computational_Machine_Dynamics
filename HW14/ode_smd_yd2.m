function yd = ode_smd_yd2( t, y )
% provides yd for integration
% spring-mass-damper
% m*xdd = Fext + Fspr + Fdamp
% HJSIII, 20.04.09
global m k f
% free motion
Fext = 0;
% individual terms
x = y(1);
xd = y(2);
% ordinary differential equation (ODE)
Fspr = -k*x;
Ffriction = -f*sign(xd);
xdd = ( Fext + Fspr + Ffriction ) / m;
% return values
yd(1,1) = xd;
yd(2,1) = xdd;
return
% bottom - ode_smd_yd