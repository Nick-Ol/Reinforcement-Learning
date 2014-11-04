function [i]= simu(p)
% p is a vector of probabilities
% draw a sample of a finite-supported distribution that takes value 
% k with porbability p(k) 
q=cumsum(p);
u=rand;
i=1;
while (u>q(i))
    i=i+1;
end
