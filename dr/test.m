

A = rand(12000,12000);
begin=datestr(now)
B = A*A';
endt = datestr(now)
disp('pca')
[mappedX, mapping] = pca(B, 100);
pcaEnd = datestr(now)

disp('nmf')
[W,H,iter, HIS] = nmf(B, 100,'type', 'plain');
nmfend = datestr(now)