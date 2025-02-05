function kappa = kappa_calculate(true_label, pred)
%true_label: N*1维向量，映射的参照划分对象
%pred：N*1维向量，待映射的划分
%标签需从1开始，且连续
    % true = check_clustering(true_label);
    % pred = check_clustering(pred);
    pred_aligned = label_map(true_label, pred);
    kappa = cohen_kappa(true_label, pred_aligned);
end

