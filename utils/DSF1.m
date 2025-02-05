function [subset, weight] = DSF1(new_partitions, delta)%, baseline)
% ѡ���Ӽ������ü����еĴظ�Ȩ
% new_partitions: ��ӳ��Ļ��ּ�
% delta:��ֵ
% beta: Fmeasure�еĳ���
[N, M] = size(new_partitions);   % ���ػ��ּ���Ԫ�ظ���
partition_set = mat2cell(new_partitions, N, ones(1,M)); 
% pair_nmi = @(p1,p2) (1-nmi(p1{1,1}, p2{1,1}));
pair_kappa = @(p1, p2) cohen_kappa(p1{1,1}, p2{1,1});
% pair_kappa = @(p1, p2) (1-kappa_m(p1{1,1}, p2{1,1}))*kappa_m(p1{1,1}, p2{1,1});

% ------------------------a.ƽ��������������-----------------------
%ǰ���ֹ���(����ƽ������)
div = zeros(1,M);          % �������������֮��Ķ�����
for m = 1:M
    p = new_partitions(:, m);
    p1 = repmat({p},1,M);
    values = arrayfun(pair_kappa, p1, partition_set); %Kappa
%     values = arrayfun(pair_nmi, p1, partition_set); %NMI
    div(m) = 1 - sum(values)/M;
end

% ------------------------1to1������������-----------------------
% baseline�����ϸ�
% p1 = repmat({baseline},1,M);
% sim = arrayfun(pair_kappa, p1, partition_set);
% % sim = arrayfun(pair_nmi, p1, partition_set);

% ---------------------���ݶ�����ѡȡǰ25���ľ�����-----------------------
[~, idxs] = sort((div), 'descend');
idx = idxs(1:delta);
subset = new_partitions(:, idx);
weight = weighted_f1(subset);
