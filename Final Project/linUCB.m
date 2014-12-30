function [ rew, draws, max_rew ] = linUCB( T, alpha, MAB, theta )
% every arm has to return a d-dimensional vector
d = size(theta,1); % theta should be vertical
K = length(MAB);
A = eye(d);
b = zeros(d,1);

Na = zeros(1, length(MAB));
Sa = zeros(1, length(MAB));

rew = zeros(1, T);
draws = zeros(1,T);
max_rew = zeros(1,T);

for t = 1:T
    theta_estim = A\b;
    upper_bound = zeros(1, K);
    x = zeros(K,d);
    rewards_th = zeros(1, K);
    for k = 1:K
        x(k,:) = MAB{k}.play();
        upper_bound(k) = theta_estim'*x(k,:)' + alpha*sqrt(x(k,:)*(A\x(k,:)'));
        rewards_th(k) = x(k,:)*theta;
    end
    [val, idx] = max(upper_bound);
    
    reward = x(idx,:)*theta;
    Sa(idx) = Sa(idx) + reward;
    Na(idx) = Na(idx) + 1;
    draws(t) = idx;
    rew(t) = reward;
    max_rew(t) = max(rewards_th);
    
    A = A + x(idx,:)'*x(idx,:);
    b = b + x(idx,:)'*reward;
end

end
