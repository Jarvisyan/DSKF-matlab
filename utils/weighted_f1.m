function [weight] = weighted_f1(partition_set)
%��ÿ���ظ�Ȩ
% beta: Fmeasure�еĳ���
% tanh_act = @(x) tanh(x); % tanh�����
% t: Ĭ��t=1,�ȶ��Ը�Ȩ. t=2, �����Ը�Ȩ.
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
% sigmoid = @(x) 1./ (1 + exp(-x)); % sigmoid�����
% weight = arrayfun(sigmoid, weight);
% weight = arrayfun(tanh_act, weight);