function [subset, weight] = DSF1(new_partitions, delta)%, baseline)
% 选择子集并给该集合中的簇赋权
% new_partitions: 已映射的划分集
% delta:阈值
% beta: Fmeasure中的超参
[N, M] = size(new_partitions);   % 返回划分集的元素个数
partition_set = mat2cell(new_partitions, N, ones(1,M)); 
% pair_nmi = @(p1,p2) (1-nmi(p1{1,1}, p2{1,1}));
pair_kappa = @(p1, p2) cohen_kappa(p1{1,1}, p2{1,1});
% pair_kappa = @(p1, p2) (1-kappa_m(p1{1,1}, p2{1,1}))*kappa_m(p1{1,1}, p2{1,1});

% ------------------------a.平均多样性来排序-----------------------
%前两种规则(噪声平滑处理)
div = zeros(1,M);          % 用来储存聚类结果之间的多样性
for m = 1:M
    p = new_partitions(:, m);
    p1 = repmat({p},1,M);
    values = arrayfun(pair_kappa, p1, partition_set); %Kappa
%     values = arrayfun(pair_nmi, p1, partition_set); %NMI
    div(m) = 1 - sum(values)/M;
end

% ------------------------1to1多样性来排序-----------------------
% baseline质量较高
% p1 = repmat({baseline},1,M);
% sim = arrayfun(pair_kappa, p1, partition_set);
% % sim = arrayfun(pair_nmi, p1, partition_set);

% ---------------------根据多样性选取前25名的聚类结果-----------------------
[~, idxs] = sort((div), 'descend');
idx = idxs(1:delta);
subset = new_partitions(:, idx);
weight = weighted_f1(subset);
