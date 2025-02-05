function clb = BI_clusters(cl)   %构造BA矩阵
[n,m]=size(cl);
[newE, no_allcl] = relabelCl(cl);%重贴标签
clb=zeros(n,no_allcl);
for i=1:m
    now_cl=newE(:,i);
    for j=min(now_cl):max(now_cl)
        clb(:,j)=now_cl==j;
    end
end
end