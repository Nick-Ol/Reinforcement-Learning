function [i]= simu(p)
% p = vecteur de proba
q=cumsum(p);
u=rand;
i=1;
while (u>q(i))
    i=i+1;
end
