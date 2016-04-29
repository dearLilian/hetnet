clear;
clc;


conf = load('E:/able/DBLP_four_area/conf_labels.txt');
paper = load('E:/able/paperData/extract/paper_label.txt');
result = load('D:\eclipse\project\HetClustering\spec_id.txt');
 %r = load('E:\able\DBLP_four_area\extract\confs.txt_cid.txt');

 data = load('E:able/DBLP_four_area/extract/authorsData.txt');
r = result;
size(r)
for i = 1:size(r(:,1))
    r(i,1) = r(i,1)+2;
end
% l = conf;
l = paper;
% l = load('D:\eclipse\project\HeterogeneousClustering\PAM_conf_clusterID.txt');
%l = label(:,2);

% r = load('D:\eclipse\project\HeterogeneousClustering\synC-ID1.txt');
% for i = 1:size(l(:,1))
%     l(i,1) = l(i,1)+2;
% end
 w = [r,l]

nmi = nmi(l,r)

purity = purity(r,l)
RI = RandIndex(r,l)

ncluster = 