function [V, pi] = PI(P, R, gamma, n_it)

n = length(R(1,:));
Q = zeros(n,n);
pi = ones(n,1); %column vector

for k = 1:n_it
    %policy evaluation using bellman operator
    V = pol_eval_3(pi, P, R ,gamma, 500); %magic number 
    for i = 1:n
        for j = 1:n
            Q(i,j) = R(i,j) + gamma.* P(i,:,j)*V;
        end
        pi(i)= find(Q(i,:)==max(Q(i,:))); %update the policy
    end
end
   
