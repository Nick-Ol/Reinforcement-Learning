function [V, pi] = PI(P, R, gamma, n_it)

n = length(R(1,:));
Q = zeros(n,n);
pi = ones(n,1); %column vector

for k = 1:n_it
    %policy evaluation using bellman operator
    V = pol_eval_3(pi, P, R ,gamma, 500); %magic number 
    for x = 1:n
        for a = 1:n
            Q(x,a) = R(x,a) + gamma.* P(x,:,a)*V;
        end
        pi(x)= find(Q(x,:)==max(Q(x,:))) -1 ; %Correcting this line after 3 hours, I happily remember CN asking me "Oh, why do array start at 0 in C?"
        %update the policy
    end
end
   
