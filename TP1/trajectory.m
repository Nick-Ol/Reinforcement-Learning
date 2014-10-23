function [X,R] = trajectory(n,x0,pi,D,M,K,h,c,pr)
% genere a trajectory X of length  n in the MDP 
% X sequence of states
% R sequence of associated rewards  
% x0 initial state
% pi policy

X = zeros(1, n+1);
X(1) = x0;
R = zeros(1, n);

i = 2;
while i<=n+1
    d = simu(D);
    X(i) = Nextstate(X(i-1), pi(1+X(i-1)), d, M);
    R(i-1) = Reward(X(i-1), pi(1+X(i-1)), d, M, K, h, c, pr);
    i = i+1;
    
end