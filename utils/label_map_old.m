function [new_label] = label_map(true_label, partition)
%true_label: N*1ά������ӳ��Ĳ��ջ��ֶ���
%partition��N*1ά��������ӳ��Ļ���
%��ǩ���1��ʼ��������

% �����ǩ�п��ܲ�����
% example1:
% true_label = [1, 1, 2, 2, 3, 3, 3, 3]';
% partition = [1, 1, 2, 2, 2, 2, 2, 2]';
% partition = [1, 1, 1, 1, 2, 2, 2, 2]';

[N,~] = size(partition);
k_set = unique(true_label)';
kk_set = unique(partition);
k1 = length(kk_set);  %��ӳ�仮���еĴظ���
k2 = length(k_set); %���ն����еĴظ���
map_cost = @(cl, partition, idx1)...
    sum(((partition{1,1} == cl{1,1}) + idx1{1,1}) >0) - sum(((partition{1,1} == cl{1,1}) + idx1{1,1}) == 2);

cost_matrix = zeros(k1, k2);
for j = 1:k2
    idx1 = true_label == j;
    col_value = arrayfun(map_cost, num2cell(1:k1)',  repmat({partition},k1,1), repmat({idx1},k1,1));
    cost_matrix(:, j) = col_value;
end

if k1 < k2
    cost_matrix(k1+1:k2,:) = 0;
elseif k1 > k2
    cost_matrix(:,k2+1:k1) = 0;
end
[index,~] = munkres(cost_matrix);

new_label = zeros(N,1);
for i = 1:k1
    new = index(i);
    idx = partition == i;
    new_label(idx) = new;
end

