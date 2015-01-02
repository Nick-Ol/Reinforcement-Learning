function [ rew, draws, reg, Na, Sa ] = linUCB_multipletheta( T, alpha, MAB, thetas, sigma_noise, nb_samples )
% every arm has to return a d-dimensional vector
d = size(thetas(:,1), 1); % theta should be vertical
K = length(MAB);
A = cell(1, K);
b = cell(1, K);

Na = zeros(1, length(MAB));
Sa = zeros(1, length(MAB));

rew = zeros(1, T);
draws = zeros(1, T);
reg = zeros(1, T);

%initializing
for t = 1:K
    A{t} = eye(d);
    b{t} = zeros(d, 1);
    x = zeros(d, nb_samples);
    rewards_th = zeros(1, nb_samples);
    for i = 1:K
        x(:, i) = MAB{i}.play();
        rewards_th(i) = x(:, i)'*thetas(:, i);
    end
    
    reward = rewards_th(t) + mvnrnd(0, sigma_noise^2);
    Sa(t) = Sa(t) + reward;
    Na(t) = Na(t) + 1;
    
    draws(t) = t;
    rew(t) = reward;
    reg(t) = max(rewards_th) - rewards_th(t);
    
    A{t} = A{t} + x(:, t)*x(:, t)';
    b{t} = b{t} + x(:, t)*reward;

end

for t = (length(MAB)+1):T
    selected_articles_idx = randperm(K);
    %nb_samples random indices in [1:K]:
    selected_articles_idx = selected_articles_idx(1:nb_samples);
    upper_bound = zeros(1, nb_samples);
    x = zeros(d, nb_samples);
    rewards_th = zeros(1, nb_samples);
    i = 1;
	for k = selected_articles_idx
        theta_estim = A{k}\b{k};
        x(:, i) = MAB{k}.play();
        upper_bound(i) = x(:, i)'*theta_estim + alpha*sqrt(x(:, i)'*inv(A{k})*x(:, i));
        rewards_th(i) = x(:, i)'*thetas(:, i);
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
    
    A{idx_article} = A{idx_article} + x(:, idx)*x(:, idx)';
    b{idx_article} = b{idx_article} + x(:, idx)*reward;

end

end
