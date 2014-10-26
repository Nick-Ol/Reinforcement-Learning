function[newP, newR] = policy_matrices (P, R)
%from 3D to 2D
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
end