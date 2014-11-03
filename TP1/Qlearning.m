function [Q] =Qlearning(n_episodes,n_it,M,K,h,c,pr,gamma)

Q = zeros(M+1,M+1);
Q_prev = ones(M+1,M+1)*inf;
count = 0;
nb_it = 0;

for episode = 1:n_episodes %hope you ready for the next episode
    states = randperm(M+1);
    state = states(1)-1; %choose a random initial state
    
    for i=1:n_it %no terminal state where to stop...
        actions = randperm(M+1);
        a = actions(1)-1; %random action        
        demands = randperm(M+1);
        d = demands(1)-1; %random demand
        nextstate = Nextstate(state,a,d,M);
        reward = Reward(state,a,d,M,K,h,c,pr); %one-step reward
        
        Q(1+state,1+a) = (1- (1/i))*Q(1+state,1+a)...
                        + (1/i)*(reward + gamma*max(Q(1+nextstate,:)));
        state = nextstate;
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
    nb_it = nb_it + 1;
    
end
        