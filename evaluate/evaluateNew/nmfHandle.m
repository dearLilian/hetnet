function nmfHandle(inputfile, outputfile, k)

clear all;
clc;

A = load(inputfile);
[W,H,iter,HIS]=nmf(A,k,'type','plain');

dlmwrite(outputfile ,W,'delimiter','\t');

end