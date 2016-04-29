clear all; close all; clc;
warning off;

load('FC_MD.mat');
load('FC_SA.mat');
n1 = 25;
n2 = 21;
load('W.mat');
load('h.mat');
MD =[]; SA=[];
for i=1:n1
    temp1 = FC_MD{1,i};
    B=[];
    for j=1:104
            B =[B temp1(j,j+1:end)];
    end
    MD = [MD;B];
end
for i=1:n2
    temp2 = FC_SA{1,i};
    C=[];
    for j=1:104
            C =[C temp2(j,j+1:end)];
    end
    SA =  [SA;C];
end

A = [MD;SA];
A = A';
avgp = 1.2*mean(mean(A(A>0)));
avgn = 1.2*mean(mean(A(A<0)));
A(A<avgp &A>0) = 0;
A(A<0 &  A>avgn) = 0;

% [m n] = size(A);
% k = 20;

% ------------------------------ Usage examples ------------------------------
[m n] = size(A);
k = 20;
% opts.tol= 1e-4; 
% opts.maxit = 500; 
% opts.maxT = 1e3;  
% opts.rw= 1;       
% [X,Y,out] = nmf3(A,k,opts);

%A = rand(m,n);

% Uncomment only one -------------------------------------------------------------------------
[W,H,iter,HIS]=nmf(A,k,'type','plain');
% save('W_MD.mat','W');
% save('H_MD.mat','H');
%[W,H,iter,HIS]=nmf(A,k,'verbose',2);
% [W,H,iter,HIS]=nmf(A,k,'verbose',1,'nnls_solver','as');
[W,H,iter,HIS]=nmf(A,k,'verbose',2,'type','sparse');
% [W,H,iter,HIS]=nmf(A,k,'verbose',1,'type','sparse','nnls_solver','bp','alpha',1.1,'beta',1.3);
% [W,H,iter,HIS]=nmf(A,k,'verbose',2,'type','plain','w_init',rand(m,k));

