function [preCID, syncData, rr] = Synclustering(reducedData, epsilon, iter)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

loop = true;

loopNum = 0;

localOrder = 0.0;
allorder = 0.0;
syncData = reducedData;
s = size(syncData);
len = s(1);
dim = s(2);
rr = zeros(iter+1, 1);
while(loop)
   
    order = zeros(len, 1);
    localOrder = 0.0;
    allorder = 0.0;
    loopNum = loopNum + 1;
    for (i = 1:len)
        sinValue = zeros(dim, 1);
        diss = zeros(dim, 1);
        dis = 0.0;
        
        num = 0;
        sita = 0.0;
        disp('test...')
        
        for (j = 1:len)
            dis = 0.0;
            for (d = 1:dim)
                diss(d) = syncData(j,d) - syncData(i,d);
            end
            dis = dist(diss);
            
            
            if(dis < epsilon)
                disp('begin to interact...');
                num = num + 1;
                for (d = 1:dim)
                    sinValue(d) = sinValue(d) + sin(diss(d));
                end
                sita = sita + exp(-dis);
            end
        end
        
        disp('update the position of data points...')
        if num > 1
            for( d = 1:1:dim)
                x1 = [];
                x1(d) = syncData(i, d) + sinValue(d)/num;
                syncData(i, d) = x1(d);
            end
            
            disp('update the order...')
            order(i) = sita/num;
        end
    end
    
    for k = 1:len
        allorder = allorder + order(k);
    end
    
    localOrder = allorder/len;
    rr(loopNum) = localOrder;
    
    if(localOrder > 1 - (1e-2) || loopNum >= iter)
        loop = false;
        disp('End of interaction...');
        localOrder
        loopNum

        
    end   
end


    preCID = findSynCluster(syncData);

%     save('sync-data.txt', syncData);
%     save('r.txt', rr);
%     clusterNo = max(preCID)
%     save('sync-id.txt', preCID);
end

