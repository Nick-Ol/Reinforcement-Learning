function [ c ] = complexity( MAB )

NbArms=length(MAB);

Means=zeros(1,NbArms);
for i=1:NbArms
    Means(i)=MAB{i}.mean;
end

c=0;
[maxMean, maxIdx] = max(Means);

for i = 1:NbArms
    if i~= maxIdx
        c = c + (maxMean - Means(i))/KL(MAB{i}.p, MAB{maxIdx}.p);
    end
end
end

