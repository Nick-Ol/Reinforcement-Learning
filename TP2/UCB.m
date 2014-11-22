function [ rew, draws ] = UCB( T, alpha, MAB )
%TODO deal with T < length(MAB)
Na = zeros(1, length(MAB));
Sa = zeros(1, length(MAB));

rew = zeros(1, T);
draws = zeros(1,T);

%initializing
for t = 1:length(MAB)
    reward = MAB{t}.play();
    Sa(t) = Sa(t) + reward;
    Na(t) = Na(t) + 1;
    
    draws(t) = t;
    rew(t) = reward;
end
    
for t = (length(MAB)+1):T  
    Ba = (Sa./Na) +sqrt(alpha*log(t)./Na);
    [val, idx] = max(Ba());
    
    reward = MAB{idx}.play();
    Sa(idx) = Sa(idx) + reward;
    Na(idx) = Na(idx) + 1;
    draws(t) = idx;
    rew(t) = reward;
end


end

