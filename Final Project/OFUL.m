function [ rew, draws, reg, theta_estim ] = OFUL( T, delta, MAB, theta, sigma_noise, nb_samples, lambda  )
% every arm has to return a d-dimensional vector
d = size(theta, 1); % theta should be vertical
K = length(MAB);
A = lambda*eye(d);
b = zeros(d, 1);

Na = zeros(1, length(MAB));
Sa = zeros(1, length(MAB));

rew = zeros(1, T);
draws = zeros(1, T);
reg = zeros(1, T);

for t = 1:T
    theta_estim = A\b;
    selected_articles_idx = randperm(K);
    %nb_samples random indices in [1:K]:
    selected_articles_idx = selected_articles_idx(1:nb_samples);
    upper_bound = zeros(1, nb_samples);
    x = zeros(nb_samples, d);
    rewards_th = zeros(1, nb_samples);
    i = 1;
    for k = selected_articles_idx
        x(i, :) = MAB{k}.play();
        upper_bound(i) = theta_estim'*x(i, :)' + norm(x(i, :))*(sigma_noise^2*sqrt(2*log(sqrt(det(A)/lambda^d)/delta))+sqrt(lambda)*norm(theta));
        rewards_th(i) = x(i, :)*theta;
    end
    [val, idx] = max(upper_bound);
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
