function [V, pi] = PI(P, R, gamma, n_it, pol_eval_index)
%pol_eval_index = 1 or 3, pol_eval function we eish to use

if pol_eval_index ~= 1 && pol_eval_index ~= 3
    error('Last parameter needs to be 1 or 3')
end
    
n = length(R(1,:));
Q = zeros(n,n);
pi = ones(n,1); %column vector

for k = 1:n_it
    
    if pol_eval_index == 1
        %policy evaluation using matricial computation
        V = pol_eval_1(pi, P, R ,gamma);
    elseif pol_eval_index == 3      
        %policy evaluation using bellman operator
        V = pol_eval_3(pi, P, R ,gamma, 500); 
    end
    
    for x = 1:n
        for a = 1:n
            Q(x,a) = R(x,a) + gamma.* P(x,:,a)*V;
        end
        pi(x)= find(Q(x,:)==max(Q(x,:))) -1 ; %Correcting this line after 3 hours, I happily remember CN asking me "Oh, why do array start at 0 in C?"
        %update the policy
    end
end
   
