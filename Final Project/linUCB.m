function [ rew, draws, reg, theta_estim, Na, Sa ] = linUCB( T, alpha, Arms, theta, sigma_noise, nb_samples, seed )
% every arm has to return a d-dimensional vector
rng(seed);
d = size(theta, 1); % theta should be vertical
K = length(Arms);
A = eye(d);
b = zeros(d, 1);

Na = zeros(1, length(Arms));
Sa = zeros(1, length(Arms));

rew = zeros(1, T);
draws = zeros(1, T);
reg = zeros(1, T);

for t = 1:T
    theta_estim = A\b;
    selected_articles_idx = randperm(K);
    %nb_samples random indices in [1:K]:
    selected_articles_idx = selected_articles_idx(1:nb_samples); 
    upper_bound = zeros(1, nb_samples);
    rewards_th = zeros(1, nb_samples);
    i = 1;
    for k = selected_articles_idx
        upper_bound(i) = Arms{k}'*theta_estim + alpha*sqrt(Arms{k}'*inv(A)*Arms{k});
        rewards_th(i) = Arms{k}'*theta;
        i = i+1;
    end
    [val, idx] = max(upper_bound); % idx = index in selected_articles_idx
    idx_article = selected_articles_idx(idx);
    
    reward = rewards_th(idx) + mvnrnd(0, sigma_noise^2);
    Sa(idx_article) = Sa(idx_article) + reward;
    Na(idx_article) = Na(idx_article) + 1;
    draws(t) = idx_article;
    rew(t) = reward;
    reg(t) = max(rewards_th) - rewards_th(idx);
    
    A = A + Arms{idx_article}*Arms{idx_article}';
    b = b + Arms{idx_article}*reward;
end

end
