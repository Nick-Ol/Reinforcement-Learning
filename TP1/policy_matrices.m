function[newP, newR] = policy_matrices (P, R, pi)
%from 3D to 2D
dim = length(R(1,:));
newP = zeros(dim,dim);
for i = 1:dim
    for j = 1:dim
        newP(i,j) = P(i, j, pi(i) + 1);
    end
end

newR = zeros(dim,1);
for i = 1:dim
    newR(i) = R(i, pi(i) + 1);
end 
end