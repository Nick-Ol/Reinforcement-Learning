function [actions,rewards]= Thompson(n,Problem)

K=length(Problem); % number of arms

actions = zeros(1,n); 
rewards = zeros(1,n); 

S=zeros(1,K);% cumulated rewards
N=zeros(1,K);% number of draws


for t=1:n
    samples=betarnd(S+1,N-S+1);
    [~,I]=max(samples);
    a=I(1);
    actions(t)=a;
    armChosen=Problem{a};
    rew=armChosen.play();
    rewards(t)=rew;
    % update the posterior
    S(I)=S(I)+rew;
    N(I)=N(I)+1;
end

end