function kappa = kappa_calculate(true_label, pred)
%true_label: N*1ά������ӳ��Ĳ��ջ��ֶ���
%pred��N*1ά��������ӳ��Ļ���
%��ǩ���1��ʼ��������
    % true = check_clustering(true_label);
    % pred = check_clustering(pred);
    pred_aligned = label_map(true_label, pred);
    kappa = cohen_kappa(true_label, pred_aligned);
end

