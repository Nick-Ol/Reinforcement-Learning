function [ Q, alphaNew ] = fittedQ( k, n, gamma, maxIter )
%k: number of features
alphaOld = zeros(k, 1);
alphaNew = rand(1,k)';
thetas = rand_featureQ(k);
iter = 0;

while(iter < maxIter && max(abs(alphaNew - alphaOld)) > 0.01 )
    iter = iter + 1
    Z = zeros(n, 1);
    X = zeros(n, k); %n observations, k features
    for i = 1:n
        s = zeros(1, 2);
        s(1) = randi([-120, 60])/100;
        s(2) = randi([-7, 7])/100;
        a = randi([-1,1]);
        [y, r] = simulator(s, a);
        Q = createQ(alphaNew, thetas);
        Z(i) = r + gamma*max([Q(y, -1), Q(y, 0), Q(y, 1)]);
        %filling line number i
        for j = 1:k
            X(i, j) = phiQ(s, a, thetas(j, :));
        end
    end
    %update alpha
    alphaOld = alphaNew;
    alphaNew = inv(X'*X)*X'*Z;
    %alphaNew = (X'*X)\(X'*Z);
end

Q = createQ(alphaNew, thetas);

end

