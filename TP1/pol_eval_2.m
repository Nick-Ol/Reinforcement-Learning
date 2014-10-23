function [V] = pol_eval_2(MCn,n,V0,pi,D,M,K,h,c,pr,gamma)
%policy evaluation using montecarlo
V = zeros(1,length(V0));

for i = 1:length(V0)
    for k = 1:MCn
        [X, R] = trajectory(n,V0(i),pi,D,M,K,h,c,pr);
        V(i) = V(i) + sum(gamma.^((1:n)-1).*R);
    end
end

V = V ./MCn;


end

