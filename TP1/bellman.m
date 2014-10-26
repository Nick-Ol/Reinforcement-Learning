function [TV]= bellman(pi, newP, newR ,gamma, V0)
%compute the bellman operator

TV = newR + gamma* reshape(newP*V0,size(newR));
end