function [x] = simu(D)
% tire une réalisation de la loi discrète sur 0:(length(D)-1) donnée par D
E=cumsum(D);
u=rand;
i=1;

while (u>E(i))
    i=i+1;
end

x=i-1;

end
