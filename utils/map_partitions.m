function [new_partitions] = map_partitions(partitions)%, baseline)
% partitions: N*M�Ļ������ּ���MΪ�û��ּ��������ľ�������
% ��ƽ��k����ȡ����Ȼ��Ӵظ���Ϊk'�Ļ����������һ����Ϊӳ��Ĳ��ն���
% --------------------------�������ն���-----------------------------------
[N, M] = size(partitions);
new_partitions = zeros(N, M);
%p2 = mat2cell(partitions, N, ones(1,M));

% % -----------------------1.���baseline----------------------------------
idx = randi(M); %���ѡȡbaseline
object_p = partitions(:, 1); %ѡȡbaseline
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


for i = 1:M
	new_partitions(:, i) = label_map(object_p, partitions(:, i));
end


