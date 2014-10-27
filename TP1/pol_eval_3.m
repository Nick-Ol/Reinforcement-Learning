function [V] = pol_eval_3(pi, P, R ,gamma, n_it)
%policy evaluation using bellman operator's iterations
n = length(R(1,:));
V = ones(n,1);
[newP, newR] = policy_matrices(P, R, pi);

for i = 1:n_it
    V = bellman(pi, newP, newR ,gamma, V);
end
