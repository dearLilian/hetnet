clear all;
clc


datapath = 'E:/research/dataset/network/dataR/';

%% initialize
%
dataset = 'dblp1/';
object = {'authors', 'confs', 'terms'};
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

% dataset = 'movie/';
% object = {'movies', 'actors', 'directors', 'genres', 'tags'};
% num = [5627,8500,2300,20,3478];
% dim=[4,4,4,4,4];

begint = datestr(now)
type = {'_NMF', '_PCA'};
for (i =1 : length(object))
    %% load graph data
    disp('load graph')
    lgrapht = datestr(now)
    gfile = strcat(datapath, dataset, object(i) ,'AD.txt');
    graphdata = load(gfile{1});
    adj = graphdata;
    
    disp('cal cc')
    cct = datestr(now)
    %cluster_coef = weighted_clust_coef(adj)

    for(j = 1:length(type))
        disp(type(j))
        disp('load pred label')
        lplabelt = datestr(now)
        label_file = strcat(datapath, dataset, 'dr/', object(i), type(j), 'sync_id.txt');
        label = load(label_file{1});


        %format changing
        disp('get the membership')
        modules = {};
        clu = unique(label);
        for (k = 1:length(clu))
            modules{k} = [];
        end
        for (k = 1:length(label))
            l = label(k);
            for(kk= 1:length(clu))
                if(l == clu(kk))
                    modules{kk} = [modules{kk},k];
                end
            end
        end

        %% calculate  the metric measuring the quality of graph clustering
        disp('cal mod')
        modt = datestr(now)
%         nedges=numedges(adj); % total number of edges
% 
%         Q = 0;
%         for m=1:length(modules)
%           e_mm=numedges(adj(modules{m},modules{m}))/nedges;
%           a_m=sum(sum(adj(modules{m},:)))/(2*nedges);
%           Q = Q + (e_mm - a_m^2);
%         end
%         Q

        n = numnodes(adj);
        m = numedges(adj);

%         mod={};
%         for mm=1:length(modules)
%            for ii=1:length(modules{mm})
%              mod{modules{mm}(ii)}=modules{mm};
%            end
%          end

         Q = 0;
         n
         s = sum(adj);
         for x=1:n
             
             for y =1:n
                 
%                  disp([x,y])
                 if(not(isequal(label(x),label(y))))
                     continue
                 end
                 Q = Q + (adj(x,y) - s(x)*s(y)/(2*m))/(2*m);
             end
         end
         Q
%          for k=1:n
%            for kk=1:n
% 
%             if not(isequal(mod(k),mod(kk)))
%               continue
%             end
% 
%             Q = Q + (adj(k,kk) - sum(adj(k,:))*sum(adj(kk,:))/(2*m))/(2*m);
% 
%            end
%          end
%          
%          Q

    end
    endtime = datestr(now)
end