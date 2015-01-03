function [ rew, draws, reg, Na, Sa ] = linUCB_multipletheta( T, alpha, Arms, thetas, sigma_noise, nb_samples )
% every arm has to return a d-dimensional vector
d = size(thetas(:,1), 1); % theta should be vertical
K = length(Arms);
A = cell(1, K);
b = cell(1, K);

Na = zeros(1, length(Arms));
Sa = zeros(1, length(Arms));

rew = zeros(1, T);
draws = zeros(1, T);
reg = zeros(1, T);

%initializing
for t = 1:K
    A{t} = eye(d);
    b{t} = zeros(d, 1);
    rewards_th = zeros(1, nb_samples);
    for i = 1:K
        rewards_th(i) = Arms{i}'*thetas(:, i);
    end
    
    reward = rewards_th(t) + mvnrnd(0, sigma_noise^2);
    Sa(t) = Sa(t) + reward;
    Na(t) = Na(t) + 1;
    
    draws(t) = t;
    rew(t) = reward;
    reg(t) = max(rewards_th) - rewards_th(t);
    
    A{t} = A{t} + Arms{t}*Arms{t}';
    b{t} = b{t} + Arms{t}*reward;

end

for t = (length(Arms)+1):T
    selected_articles_idx = randperm(K);
    %nb_samples random indices in [1:K]:
    selected_articles_idx = selected_articles_idx(1:nb_samples);
    upper_bound = zeros(1, nb_samples);
    rewards_th = zeros(1, nb_samples);
    i = 1;
	for k = selected_articles_idx
        theta_estim = A{k}\b{k};
        upper_bound(i) = Arms{k}'*theta_estim + alpha*sqrt(Arms{k}'*inv(A{k})*Arms{k});
        rewards_th(i) = Arms{k}'*thetas(:, k);
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
    
    A{idx_article} = A{idx_article} + Arms{idx_article}*Arms{idx_article}';
    b{idx_article} = b{idx_article} + Arms{idx_article}*reward;

end

end
