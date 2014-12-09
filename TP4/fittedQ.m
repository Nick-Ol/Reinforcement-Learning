function [ Q ] = fittedQ( k,n, gamma )
alphaOld = ones(1, k);
alphaNew = ones(1, k);
thetas = rand_featureQ(k);

while(max(abs(alphaNew - alphaOld)) > 0.01)
    Z = zeros(n, 1);
    for i = 1:n
        s = zeros(1, 2);
        s(1) = randi([-120, 60])/100;
        s(2) = randi([-7, 7])/100;
        a = randi([-1,1]);
        [y, r] = simulator(s, a);
        Q = createQ(alpha, thetas);
        Z(i) = r + gamma*max(Q(y, -1), Q(y, 0), Q(y, 1));
    end  
%define X

%update alpha
alphaOld = alphaNew;
alphaNew = inv(X
end
end

