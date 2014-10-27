function [V, pi] = VI(P, R, gamma, V0, n_it)

n = length(R(1,:));
Q = zeros(n,n);
V= V0;
for k = 1:n_it
    for i = 1:n
        for j = 1:n
            Q(i,j) = R(i,j) + gamma.* P(i,:,j)*V;
            V(i) = max(Q(i,:)); %update the value, for each initial state i
        end
    end
end

pi = zeros(n, 1); %column vector
for i = 1:n
    pi(i) = find(Q(i,:)==max(Q(i,:))); %find the optimal policy
end


            