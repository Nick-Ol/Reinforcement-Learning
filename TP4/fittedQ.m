function [ Q, alphaNew ] = fittedQ( k, n, gamma, thetasQ, maxIter )
% k: number of features
alphaOld = zeros(k, 1);
alphaNew = rand(1,k)';
Q = createQ(alphaNew, thetasQ);
iter = 0;

while(iter < maxIter && max(abs(alphaNew - alphaOld)) > 0.01)
    iter = iter + 1
    Z = zeros(n, 1);
    X = zeros(n, k); % n observations, k features
    for i = 1:n
        s = zeros(1, 2);
        s(1) = -1.2 + 1.8 * rand(1);
        s(2) = -0.07 + 0.14 * rand(1);
        a = randi([-1,1]);
        [y, r] = simulator(s, a);
        Z(i) = r + gamma*max([Q(y, -1), Q(y, 0), Q(y, 1)]);
        % filling line number i
        for j = 1:k
            X(i, j) = phiQ(s, a, thetasQ(j, :));
        end
    end
    % update alpha
    alphaOld = alphaNew;
    alphaNew = inv(X'*X)*X'*Z
    %alphaNew = (X'*X)\(X'*Z);
    
    % update Q
    Q = createQ(alphaNew, thetasQ);
end

end
