%%the implement of hetNetClustering
clear all;
clc

%%  1:initialization
%%

net0_files = 'E:able/DBLP_four_area/extract\AT.txt';
net1_files = 'E:able/DBLP_four_area/extract\AC.txt';
net2_files = 'E:\DBLP_four_area\resetAuthor\ATA.txt';
% label_files = 'E:\DBLP_four_area\resetAuthor\author_label.txt';
label_files = 'E:\paper\hetnetclustering\original\conf_labels.txt';

f1 = 'E:\able\DBLP_four_area\CA.txt';
f2 = 'E:\able\DBLP_four_area\CT.txt';


%%  2.input data
%%

net1_view = load_from_triple(f1);
net2_view = load_from_triple(f2);


%%  3.decoposition from hetnet to homnet
%%
net1 = net1_view * transpose(net1_view);
net2 = net2_view * transpose(net2_view);

%normalize
a = max(max(net1))
b = min(min(net1))
A1 = net1;
for i = 1:1:size(net1, 1)
    for j = 1:1:size(net1, 2)
        net1(i,j) = (net1(i,j) - b)/(a - b);
        A(i,j) = 1 - net1(i, j);
    end
end
%normalize
c = max(max(net2));
d = min(min(net2));
A2 = net2;
for i = 1:1:size(net2, 1)
    for j = 1:1:size(net2, 2)
        net2(i,j) = (net2(i,j) - d)/(c - d);
%         A(i,j) = 1 - net2(i, j)
    end
end




%%  4. merge into a unified homnet
%%
net = net1 + net2;

% net = net1_view + net2_view;


%normalize
e = max(max(net));
f = min(min(net));

for i = 1:1:size(net, 1)
    for j = 1:1:size(net, 2)
        net(i,j) = (net(i,j) - f)/(e - f);
%         A(i,j) = 1 - net(i, j)
    end
end

A = net

%%  5.do clustering
%%

sigma = 40;
num_clusters = 4;
[cluster_labels, evd_time, kmeans_time, total_time] = sc(A, sigma, num_clusters);

cluster_labels;

%%  6.evaluating the result
%%
true_labels = load(label_files);
% true_labels = true_labels(:,2);
nmi = nmi(true_labels, cluster_labels)
accuracy = accuracy(true_labels, cluster_labels)