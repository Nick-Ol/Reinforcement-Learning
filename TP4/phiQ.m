function val = phiQ(s,a,theta)
% theta line vector of size 12
% returns the value of \phi(s,a) for the feature function \phi represented by the parameter
% theta

switch a
 case 1 
  s0 = theta(1:2);
  sigmas = theta(3:4);
 case 0 
  s0 = theta(5:6);
  sigmas = theta(7:8);
 case -1 
  s0 = theta(9:10);
  sigmas = theta(11:12);
end

Minv = diag([1/sigmas(1),1/sigmas(2)]);
val = exp(-(s-s0)*Minv*(s-s0)'/2.)/sqrt(2.*pi*sigmas(1)*sigmas(2));



