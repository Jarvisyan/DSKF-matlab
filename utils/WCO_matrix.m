function [wco_matrix] = WCO_matrix(partitions,weight)
% partitions:划分集
% weight:1*h矩阵，表示每个簇的权重

[N, ~] = size(partitions);
w = repmat(weight, N, 1);
ba_matrix = BI_clusters(partitions);
wba = ba_matrix .* w;                               % 权重BA矩阵
wco_matrix = wba * ba_matrix';

% wco_matrix = wba * wba';                            % 权重一致性矩阵（待归一化）
value = max(diag(wco_matrix));                      % 对角线最大的元素
wco_matrix(logical(eye(size(wco_matrix)))) = value; % 对角元素一致化
wco_matrix = wco_matrix/value;                      % 归一化

