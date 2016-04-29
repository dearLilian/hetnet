clear all;
clc all;


%% initialize
%
%datapath = '/home/hadoop/文档/dataR/dblp1/';
%object = {'authors', 'confs', 'terms'};
%num = [8030, 20, 5200];
%dim = [20,10,20];

datapath = '/home/hadoop/文档/dataR/dblp2/';
object = {'papers', 'authors', 'terms'};
num =[7642, 9100, 4500];
dim=[20, 20, 20];

%datapath = '/home/hadoop/文档/dataR/movie/';
%object = {'movies', 'actors', 'directors', 'genres', 'tags'};
%num = [5627,8500,2300,20,3478];
%dim=[20,20,20,10,20];

%%  load ,integrate, norm data and do dim reduction.

for(i = 1:length(object))
    file = strcat(datapath, object(i), '.txt');
    data = strcat(datapath, object(i), 'AD.txt');
    pcaOutput = strcat(datapath,'dr/', object(i), '_PCAReduce.txt');
    nmfOutput = strcat(datapath ,'dr/',object(i), '_NMFReduce.txt');
    
    getdatabegin = datestr(now)
    all = getUnifiedNet(file{1}, num(i));
    
    dlmwrite(data{1}, all, 'delimiter','\t');
    %% nmf
    nmfbegin=datestr(now)
    [W,H,iter, HIS] = nmf(all, dim(i), 'type', 'plain');
    dlmwrite(nmfOutput{1}, W, 'delimiter','\t');

    %% pca
    pcabegin=datestr(now)
    [mappedX, mapping] = compute_mapping(all, 'PCA', dim(i));
    dlmwrite(pcaOutput{1}, mappedX, 'delimiter', '\t');
    
    
    programEnd=datestr(now)
end