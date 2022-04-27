function yd = ode_dragsled_yd( t, y )
% provides yd for integration
global m k mu_s mu_d g epsilon vdr
% free motion
Fext = 0;
% individual terms
x = y(1); %xs
xd = y(2);

%calcualte xdr
xdr = vdr*t;
% ordinary differential equation (ODE)
Fspr = -k*(x - xdr);
if abs(xd) > epsilon
    Ffriction = -mu_d*m*g*sign(xd);
else
    Ffriction = -Fspr;
    if abs(Ffriction) > mu_s*m*g
        Ffriction = -mu_s*m*g*sign(Fspr);
    end
end
xdd = ( Fext + Fspr + Ffriction ) / m;
% return values
yd(1,1) = xd;
yd(2,1) = xdd;
return
% bottom - ode_dragsled_yd