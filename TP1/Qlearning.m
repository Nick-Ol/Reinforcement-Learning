function [Q] =Qlearning(eta,n_episodes,n_it,M,K,h,c,pr)
%eta: learning rate, considered as constant

Q = zeros(M+1,M+1);
Q_prev = ones(M+1,M+1)*inf;
count = 0;

for episode = 1:n_episodes
    states = randperm(M+1);
    state = states(1)-1; %chose a random initial state
    
    for i=1:n_it
        actions = randperm(M+1);
        a = actions(1)-1; %random action        
        demands = randperm(M+1);
        d = demands(1)-1; %random number of demands
        nextstate = Nextstate(state,a,d,M);
        reward = Reward(state,a,d,M,K,h,c,pr); %one-step reward
        
        Q(1+state,1+a) = (1-eta)*Q(1+state,1+a)...
                        + eta*(reward + max(Q(1+nextstate,:)));
    end
    
    if sum(sum(abs(Q-Q_prev))) < 0.0001
        if count > 500
            break
        else count = count + 1;
        end
    else
        count = 0;
    end
    
    Q_prev = Q;
    
end
        