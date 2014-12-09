function [thetas] = rand_featureQ(k)

thetas = zeros(k,12);
for i=1:k,
 for j=0:2,
    thetas(i,4*j+1) = rand()*(1.7) - 1.2;% mean parameters
    thetas(i,4*j+2) = rand()*(0.14) - 0.07;
    thetas(i,4*j+3) = 1.7*(0.5 + rand())/50;% covariance parameters
    thetas(i,4*j+4) = 0.14*(0.5 + rand())/50;
 end;
end;
