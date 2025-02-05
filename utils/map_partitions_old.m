function [new_partitions] = map_partitions_old(partitions)%, baseline)
% partitions: N*M�Ļ������ּ���MΪ�û��ּ��������ľ�������
% ��ƽ��k����ȡ����Ȼ��Ӵظ���Ϊk'�Ļ����������һ����Ϊӳ��Ĳ��ն���
% --------------------------�������ն���-----------------------------------
[N, M] = size(partitions);
p2 = mat2cell(partitions, N, ones(1,M));

% % -----------------------1.���baseline----------------------------------
idx = randi(M); %���ѡȡbaseline
object_p = partitions(:, 1); %test idx 23 %ѡȡbaseline
%fprintf('random id %.0f to run.\n', idx);
% % ----------------------2.�����baseline---------------------------------
% all_entropy = @(p2) Entropy(p2{1,1});
% entropies = arrayfun(all_entropy, p2); % �������clustering����
% [~,idx] = max(entropies);
% object_p = partitions(:, idx); %ѡȡbaseline

% % -----------------------3.true_label_baseline----------------------------------
% object_p = baseline;

% % -----------------------4.���ɽ��_baseline----------------------------------
%object_p = baseline;


% -----------------------------ӳ��----------------------------------------
p1 = repmat({object_p}, 1, M);

all_map = @(p1, p2) label_map_old(p1{1,1}, p2{1,1});
new_partitions = cell2mat(arrayfun(all_map, p1, p2, 'UniformOutput', false));