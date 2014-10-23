function [TV]= bellman(pi, P, R ,gamma, V0)
%compute the bellman operator

n = length(R(1,:));
newP = zeros(n,n);
for i = 1:n
    for j = 1:n
        newP(i,j) = P(i, j, pi(i));
    end
end

newR = zeros(1,n);
for i = 1:n
    newR(i) = R(i, pi(i));
end

TV = newR + gamma* reshape(newP*V0,size(newR));
end