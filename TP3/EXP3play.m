function [Actions,Rewards]=EXP3play(n,G,eta,beta,Seq)

Actions = zeros(1,n);
Rewards = zeros(1,n);
Exp3 = EXP3(eta, beta, size(G,1));

for i = 1:n
    Actions(i) = Exp3.play();
    Exp3.getReward(G(Actions(i),Seq(i)));
    Rewards(i) = G(Actions(i), Seq(i));
end
