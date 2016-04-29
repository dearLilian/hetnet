clear all;close all; clc;
c = load('E:/research/dataset/network/dataR/dblp1/confs_label.txt');
p = load('E:/research/dataset/network/dataR/dblp2/paper_label.txt');
pgetID = load('E:/research/dataset/network/dataR/dblp2/dr/papers_NMFsync_id.txt');
cgetID = load('E:/research/dataset/network/dataR/dblp1/dr/confs_PCAsync_id.txt');
stdID = p;

getID = pgetID;
stdID = stdID + ones(size(stdID))+ ones(size(stdID));
getID = getID + ones(size(getID)) + ones(size(getID));


size(stdID)
size(getID)
%% get the validation
[NMI,AMI,AVI,EMI]=ICML(stdID,getID);
[pur]=purity(stdID,getID);
[AR,RI,MI,HI]=RandIndex(stdID,getID);

R = [NMI AR pur]


%% When dim = 20/10 
% %for conf  dim = 10
% NMF = [0.4389  ,  0.2142  ,  0.6500]
% PCA = [0.4389  ,  0.2142  ,  0.6500]
% %for paper
% NMF = [0.2064    0.0068    0.2047];%1e-1
% PCA = [0.2212    0.0116    0.2031];%1e-1

% NMF = [0.3149  ,  0.0073  ,  0.2921];%1e-2
% PCA = [0.3123  ,  0.0099  ,  0.2949];%1e-2

%% when dim = 4
    disp('for conf');%dim=4
    NMF = [0.5894  ,  0.3922  ,  0.9000];
    PCA = [0.5111  ,  0.2685  ,  0.8000];
    
    % for paper
    NMF = [0.1082  ,  0.0104  ,  0.1699];
    PCA = [0.0894  ,  0.0038  ,  0.1706];
