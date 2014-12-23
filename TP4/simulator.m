function [ sn,rec ] = simulator( s,a )

x = s(1);
v = s(2);

xn = max(min(x + v, 0.6), -1.2);
epsilon = 0; % deterministic case
%epsilon = -0.0005 + 0.0014 * rand(1);

if xn == -1.2 % speed set to zero
    vn = max(min(epsilon + 0.001*a -0.0025*cos(3*x), 0.07), 0);
else
    vn = max(min(v + epsilon + 0.001*a -0.0025*cos(3*x), 0.07), -0.07);
end

sn = [xn, vn];
rec = (xn >= 0.6) - 1;
end
