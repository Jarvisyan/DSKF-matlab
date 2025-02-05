function [weight] = weighted_f1(partition_set)
%给每个簇赋权
% beta: Fmeasure中的超参
% tanh_act = @(x) tanh(x); % tanh激活函数
% t: 默认t=1,稳定性赋权. t=2, 多样性赋权.
t = 1;

[~,M] = size(partition_set);
weight = [];
for i = 1:M
    k = length(unique(partition_set(:,i)));
    scores = zeros(1,k);
    for j = 1:M
        if j ~= i
            score = F1(partition_set(:,j)', partition_set(:,i)'); 
            switch t
                case 1            
                    scores = scores + score;
                case 2
                    scores = scores + (1 - score);
            end
        end
    end
    f1 = scores/(M-1);
%     f1 = F1(baseline', partition_set(:,i)');
    weight = [weight,f1];
end
weight = weight/sum(weight);
% sigmoid = @(x) 1./ (1 + exp(-x)); % sigmoid激活函数
% weight = arrayfun(sigmoid, weight);
% weight = arrayfun(tanh_act, weight);