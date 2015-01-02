function [ rew, draws, reg ] = Thompson( T, delta, Arms, theta, sigma_noise, nb_samples )

d = size(theta, 1); % theta should be vertical
K = length(Arms);
A = eye(d);
b = zeros(d, 1);

rew = zeros(1, T);
draws = zeros(1, T);
reg = zeros(1, T);

obs = zeros(1, K);
Na = zeros(1, K);
Sa = zeros(1, K);

for t = 1:T
    selected_articles_idx = randperm(K);
    %nb_samples random indices in [1:K]:
    selected_articles_idx = selected_articles_idx(1:nb_samples);
    x = zeros(nb_samples, d);
    rewards_th = zeros(1, nb_samples);
    i = 1;
    for k = selected_articles_idx
        x(i, :) = Arms{k}; 
        rewards_th(i) = x(i, :)*theta;
        i = i+1;
    end
    theta_estim = A\b;
    B = eye(d, d) + x'*x;
    theta_thompson = mvnrnd(theta_estim, sigma_noise^2*9*d*log(t/delta)*inv(B));
    for i = 1:nb_samples
        obs(i) = x(i, :)*theta_thompson';
    end
    %pick best arm
    [val, idx] = max(obs);
    idx_article = selected_articles_idx(idx);
    
    reward = x(idx, :)*theta + mvnrnd(0, sigma_noise^2);
    Sa(idx_article) = Sa(idx_article) + reward;
    Na(idx_article) = Na(idx_article) + 1;
    draws(t) = idx_article;
    rew(t) = reward;
    reg(t) = max(rewards_th) - x(idx, :)*theta;
    
    A = A + x(idx, :)'*x(idx, :);
    b = b + x(idx, :)'*reward;   
end

end
