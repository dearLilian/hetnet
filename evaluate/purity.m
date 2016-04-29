function [pur]=purity(stdc,getc)

uid = unique(getc);
nc = length(uid);

pur = 0.0;
for i=1:nc
    idx = find(getc==uid(i));
    sid = unique(stdc(idx));
    maxn = 0;
    for j=1:length(sid)
        n = length(find(stdc(idx)==sid(j)));
        if(n>maxn)
            maxn = n;
        end
    end
    pur = pur + maxn;
end
pur = pur/length(stdc);


