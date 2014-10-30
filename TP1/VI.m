function [V, pi] = VI(P, R, gamma, n_it)

n = length(R(1,:));
Q = zeros(n,n);
V= ones(n,1);
for k = 1:n_it
    for x = 1:n
        for a = 1:n
            Q(x,a) = R(x,a) + gamma.* P(x,:,a)*V;          
        end
        V(x) = max(Q(x,:)); %update the value, for each initial state i
    end
end

pi = zeros(n, 1); %column vector
for x = 1:n
    pi(x) = find(Q(x,:)==max(Q(x,:))) - 1; %find the optimal policy
end


            