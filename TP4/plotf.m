function plotf(f)
%for a feature function:
%f = @(x)phi(x,theta);

xs = linspace(-1.2,0.6,20);
vs = linspace(-0.07,0.07,20);
Z=zeros(20,20);
for i=1:20,
 for j=1:20,
 Z(i,j) = f([xs(j),vs(i)]);
 end;
end;

surf(xs,vs,Z);
