function [new_partitions] = map_partitions(partitions)%, baseline)
% partitions: N*M的基础划分集，M为该划分集所包含的聚类结果数
% 对平均k向下取整，然后从簇个数为k'的划分里随机挑一个作为映射的参照对象
% --------------------------给出参照对象-----------------------------------
[N, M] = size(partitions);
new_partitions = zeros(N, M);
%p2 = mat2cell(partitions, N, ones(1,M));

% % -----------------------1.随机baseline----------------------------------
idx = randi(M); %随机选取baseline
object_p = partitions(:, 1); %选取baseline
%fprintf('random id %.0f to run.\n', idx);
% % ----------------------2.最大熵baseline---------------------------------
% all_entropy = @(p2) Entropy(p2{1,1});
% entropies = arrayfun(all_entropy, p2); % 逐个计算clustering的熵
% [~,idx] = max(entropies);
% object_p = partitions(:, idx); %选取baseline

% % -----------------------3.true_label_baseline----------------------------------
% object_p = baseline;

% % -----------------------4.集成结果_baseline----------------------------------
%object_p = baseline;


% -----------------------------映射----------------------------------------


for i = 1:M
	new_partitions(:, i) = label_map(object_p, partitions(:, i));
end


