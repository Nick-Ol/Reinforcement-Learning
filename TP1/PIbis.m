% This is duplicated code, should be refactored.

function [V, pi] = PIbis(P, R, gamma, n_it)
%PI using pol_eval_1 instead of 3, to compare the time of execution

n = length(R(1,:));
Q = zeros(n,n);
pi = ones(n,1); %column vector

for k = 1:n_it
    %policy evaluation using bellman operator
    V = pol_eval_1(pi, P, R ,gamma);
    for x = 1:n
        for a = 1:n
            Q(x,a) = R(x,a) + gamma.* P(x,:,a)*V;
        end
    [val, indx] = max(Q(x,:));
    pi(x)= indx -1; %update the policy
    end
end
   
