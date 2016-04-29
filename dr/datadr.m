clear all;
clc;


datapath = 'E:/research/dataset/network/dataR/';

%% initialize
%
% dataset = 'dblp1/';
% object = {'authors', 'confs', 'terms'};
% num = [8030, 20, 5200];
% dim = [4,4,4];


% dataset = 'dblp1/';
% object = { 'confs', 'terms'};
% num = [20, 5200];
% dim = [4,4];

% dataset = 'dblp2/';
% object = {'papers', 'authors', 'terms'};
% num =[7642, 9100, 4500];
% dim=[20,20,20];

dataset = 'movie/';
object = {'movies', 'actors', 'directors', 'genres', 'tags'};
num = [5627,8500,2300,20,3478];
dim=[4,4,4,4,4];


% object = {'tags'};
% num = [3478];
% dim = [20];
%%  load ,integrate, norm data and do dim reduction.

for(i = 1:length(object))
    %% the file path initial
    file = strcat(datapath,dataset, object(i), '.txt');
    data = strcat(datapath,dataset, object(i), 'AD.txt');
    pcaOutput = strcat(datapath,dataset,'dr/', object(i), '_PCAReduce.txt');
    nmfOutput = strcat(datapath ,dataset,'dr/',object(i), '_NMFReduce.txt');
    ldaOutput = strcat(datapath ,dataset,'dr/',object(i), '_LDAReduce.txt');
    mdsOutput = strcat(datapath ,dataset,'dr/',object(i), '_MDSReduce.txt');
     
    %% get the unified network of multiple views
%     getdatabegin = datestr(now)
%     all = getUnifiedNet(file{1}, num(i));
%     
%     dlmwrite(data{1}, all, 'delimiter','\t');

    %% load the unified net
    disp('load whole net')
    lt = datestr(now)
    file = strcat(datapath, dataset, object(i), 'AD.txt');
    all = load(file{1});
    %% nmf
    nmfbegin=datestr(now)
    [W,H, iter, HIS] = nmf(all, dim(i), 'type', 'plain');
    dlmwrite(nmfOutput{1}, W, 'delimiter','\t');

    %% pca
    pcabegin=datestr(now)
    [mappedX, mapping] = compute_mapping(all, 'PCA', dim(i));
    dlmwrite(pcaOutput{1}, mappedX, 'delimiter', '\t');
    
    %% LDA
%     ldabegin=datestr(now)
%     [mappedX, mapping] = compute_mapping(all, 'LDA', dim(i));
%     dlmwrite(ldaOutput{1}, mappedX, 'delimiter', '\t');
%     
%    %% MDS
%     pcabegin=datestr(now)
%     [mappedX, mapping] = compute_mapping(all, 'MDS', dim(i));
%     dlmwrite(mdsOutput{1}, mappedX, 'delimiter', '\t');
    
    
    
    programEnd=datestr(now)
end