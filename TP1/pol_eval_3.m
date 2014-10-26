function [V] = pol_eval_3(pi, P, R ,gamma, V0, n_it)
%policy evaluation using bellman operator's iterations

V = V0;
[newP, newR] = policy_matrices(P, R, pi);
for i = 1:n_it
    V = bellman(pi, newP, newR ,gamma, V);
end
