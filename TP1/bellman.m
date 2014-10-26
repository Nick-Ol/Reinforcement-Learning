function [TV]= bellman(pi, newP, newR ,gamma, V0)
%compute the bellman operator

TV = newR + gamma.* newP*V0 ;
end