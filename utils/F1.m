function [f1_scores] = F1(actual, predict)
% true:��ʵ��ǩ��
% predict:Ԥ���ǩ��
% beta: Fmeasure�еĳ���
% ������ʽΪ������
% predict = label_map(actual, predict)';
evaluated = unique(predict); %Ҫ���۵ı�ǩ��
scores = [];
for label = evaluated
    if ismember(label,actual)
        idx_a = actual == label;
        idx_p = predict == label;
        p = sum(idx_a);
        q = sum(idx_p);
        condition = idx_a + idx_p;
        tp = sum(condition == 2);
        if tp == 0
            scores = [scores,0];
        else
            precision = tp/q;
            recall = tp/p;
            f1 = 2*((precision*recall)/(precision + recall)); %Ĭ��ֵ�� = 1 
            scores = [scores,f1];
        end
    else
        scores = [scores,0];
    end
end
f1_scores = scores;