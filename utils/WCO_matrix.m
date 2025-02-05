function [wco_matrix] = WCO_matrix(partitions,weight)
% partitions:���ּ�
% weight:1*h���󣬱�ʾÿ���ص�Ȩ��

[N, ~] = size(partitions);
w = repmat(weight, N, 1);
ba_matrix = BI_clusters(partitions);
wba = ba_matrix .* w;                               % Ȩ��BA����
wco_matrix = wba * ba_matrix';

% wco_matrix = wba * wba';                            % Ȩ��һ���Ծ��󣨴���һ����
value = max(diag(wco_matrix));                      % �Խ�������Ԫ��
wco_matrix(logical(eye(size(wco_matrix)))) = value; % �Խ�Ԫ��һ�»�
wco_matrix = wco_matrix/value;                      % ��һ��

