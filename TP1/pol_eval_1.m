function [V] = pol_eval_1(pi, P, R, gamma)
%matricial equation policy evaluation

dim = length(R(1,:));
[newP, newR] = policy_matrices(P, R, pi);

V = inv(eye(dim) - gamma.* newP) *newR;

end