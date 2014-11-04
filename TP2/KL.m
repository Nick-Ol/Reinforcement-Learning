function [ k ] = KL( x, y )

k = x*log(x/y) +(1-x)*log((1-x)/(1-y));

end

