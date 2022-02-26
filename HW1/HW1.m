clc,clear,close

a = 30; %mm
b = 33; %mm
c = 53; %mm

alpha = acosd((a^2 - b^2 - c^2)/(-2*b*c))


%% Derivative

% syms  a b c t

da = 10

% alpha = acosd((a^2 - b^2 - c^2)/(-2*b*c))

% alpha = simplify(alpha)

% dalpha = diff(alpha,t)

% dalpha = round(asind((a*da)/(b*c))/alpha,4)

dalpha = (a*da)/(b*c*sqrt(1-((a^2 - b^2 - c^2)/(-2*b*c))^2))