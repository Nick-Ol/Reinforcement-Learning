function [Actions,Rewards] = EWFplay(n,G,eta,Seq)

Actions = zeros(1,n);
Rewards = zeros(1,n);
Ewf = EWF(eta, size(G,1));

for i = 1:n
    Actions(i) = Ewf.play();
    Ewf.getReward(G(Actions(i),:));
    Rewards(i) = G(Actions(i), Seq(i));
end

