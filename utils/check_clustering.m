function labels_resorted = check_clustering(labels)
    labels = double(labels(:)); % Ensure column vector and double type
    
    % Check if labels count from 1 and are continuous
    k_set = unique(labels);
    label_max = max(k_set);
    label_min = min(k_set);
    
    if label_min ~= 1 || label_max ~= length(k_set)
        labels_resorted = zeros(size(labels));
        for i = 1:length(k_set)
            idx = (labels == k_set(i));
            labels_resorted(idx) = i;
        end
    else
        labels_resorted = labels;
    end
end