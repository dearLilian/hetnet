function result = getUnifiedNet(file, num)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
%   author:wenbao li
%   date:2016/4/22
%   function:get the integrating network of multiple views.
file
fid = fopen(file);
result = zeros(num, num);
    while ~feof(fid)
        line = fgetl(fid)
        tri = load(line);
        m = tri(1,1);
        n = tri(1,2);
        data = tri([2:length(tri)],:);
        A = zeros(m,n);

        for (i = 1:length(data))
            A(data(i,1),data(i,2))=data(i,3);
        end

        mulBegin=datestr(now)
        B = A*A';

        normBegin=datestr(now)
        normB = normaliseByMax(B);

        inteBegin=datestr(now)
        result = result + normB;
    
    				
    end

end

