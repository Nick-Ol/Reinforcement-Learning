function [actions,rewards]= EXP3stochastic(n,eta,beta,MAB)

actions = zeros(1,n);
rewards = zeros(1,n);
Exp3 = EXP3(eta, beta, length(MAB));

for i = 1:n
    actions(i) = Exp3.play();
    rewards(i) = MAB{actions(i)}.play();
    Exp3.getReward(rewards(i));
end