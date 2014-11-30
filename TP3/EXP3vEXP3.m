function [ActionsA,ActionsB,Rew]= EXP3vEXP3(n,eta,beta,G)

ActionsA = zeros(1,n);
ActionsB = zeros(1,n);
Rew = zeros(1,n);
Exp3A = EXP3(eta, beta, size(G,1));
Exp3B = EXP3(eta, beta, size(G,1));

for i = 1:n
    ActionsA(i) = Exp3A.play();
    ActionsB(i) = Exp3B.play();
    Exp3A.getReward(G(ActionsA(i),ActionsB(i)));
    Exp3B.getReward(-G(ActionsA(i),ActionsB(i)));
    Rew(i) = G(ActionsA(i),ActionsB(i));
end
