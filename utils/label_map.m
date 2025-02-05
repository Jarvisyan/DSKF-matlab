function pred_aligned = label_map(true_label, pred)
    true_label = check_clustering(true_label);
    pred = check_clustering(pred);
	
    n = length(true_label);
    k_true = max(true_label);
    k_pred = max(pred);
    m = max(k_true, k_pred);
	
    cost_matrix = zeros(m, m);
    for j = 1:k_true
        idx_true = (true_label == j);
        for k = 1:k_pred
            idx_pred = (pred == k);
            union_num = sum(idx_pred | idx_true);
            intersection_num = sum(idx_pred & idx_true);
            cost_matrix(k, j) = union_num - intersection_num;
        end
    end
    
    [index, ~] = munkres(cost_matrix); % Use munkres algorithm for optimal assignment | return [assignment, cost]
    
    pred_aligned = zeros(n, 1);
	for i = 1:k_pred
		%keyboard  % 代码会在这里暂停，并进入调试模式
        idx = pred == i;
		pred_aligned(idx) = index(i);
	end
	%keyboard  % 代码会在这里暂停，并进入调试模式
end