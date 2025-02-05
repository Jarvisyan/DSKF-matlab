clear;

M = 50;
[A,B,C,D,~] = textread('./iris.txt','%f%f%f%f%s','delimiter',',');
Iris = [A, B, C, D];
true_label = repelem([1 2 3], 50)';
k = length(unique(true_label));
dataed = mapminmax(Iris')'; 
partition = kmeans(dataed,k, 'maxiter',300);
nmi(true_label, partition)

partitions = csvread('./Iris_ensemble.csv', 1);
new_partitions = map_partitions(partitions(:, 1:M));
[subset, weight] = DSF1(new_partitions, 25);
sim = WCO_matrix(subset, weight);
Z = linkage(1 - sim, 'average','chebychev');
c = cluster(Z,'Maxclust', k);

nmi(true_label, c)
kappa_calculate(true_label, c)




