function [ rew, draws ] = naive(T, MAB)

[rew, draws] = UCB(T, 0, MAB);


end