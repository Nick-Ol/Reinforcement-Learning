function [V] = pol_eval_3(pi, P, R ,gamma, V0, n_it)
%policy evaluation using bellman operator's iterations

V = V0;
[newP, newR] = policy_matrices(P, R);
for i = 1:n_it
    V = reshape(bellman(pi, P, R ,gamma, V), size(V0));
end
