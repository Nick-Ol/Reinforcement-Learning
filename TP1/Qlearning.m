function [Q] =Qlearning(n_episodes,n_it,M,K,h,c,pr,gamma, D)

Q = zeros(M+1,M+1);
Q_prev = ones(M+1,M+1)*inf;
count = 0;

visits = zeros(M+1, M+1); %this will count the visits in (x,a)

for episode = 1:n_episodes
    states = randperm(M+1);
    state = states(1)-1; %choose a random initial state
    
    for i=1:n_it %no terminal state where to stop...
        actions = randperm(M+1);
        a = actions(1)-1; %random action        
        d = simu(D); %random demand
        nextstate = Nextstate(state,a,d,M);
        reward = Reward(state,a,d,M,K,h,c,pr); %one-step reward
        visits(1+state, 1+a) = visits(1+state, 1+a) + 1;
        Q(1+state,1+a) = (1- (1/visits(1+state, 1+a)))*Q(1+state,1+a)...
                        + (1/visits(1+state, 1+a))*(reward + gamma*max(Q(1+nextstate,:)));
                    
        state = nextstate;
    end
    
end
        