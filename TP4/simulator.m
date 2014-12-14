function [ sn,rec ] = simulator( s,a )

xn = max(min(s(1) + s(2), 0.6), -1.2);
if xn == -1.2
    vn = 0;
else
    epsilon = randi([-50, 90])/100000;
    vn = max(min(s(2) + epsilon + 0.001*a -0.0025*cos(3*s(1)), 0.07), -0.07);
end

sn = [xn, vn];
rec = (xn >= 0.6) - 1;
end
