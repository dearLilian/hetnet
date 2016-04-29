function [NMI,AMI,AVI,EMI]=ICML(true_mem,mem)

%calculate the contingency table
K1=max(true_mem);
K2=max(mem);
n=length(mem);N=n;

%identify the missing labels
list_t=ismember(1:K1,true_mem);
list_m=ismember(1:K2,mem);

%calculating the Entropy
NK1=zeros(1,K1);
NK2=zeros(1,K2);
for i=1:N
    NK1(true_mem(i))=NK1(true_mem(i))+1;
    NK2(mem(i))=NK2(mem(i))+1;
end
NK1=NK1(list_t);%deleting the missing labels
NK2=NK2(list_m);

HK1=-(NK1/n)*log(NK1/n)'; %calculating the Entropies
HK2=-(NK2/n)*log(NK2/n)';

%building contingency table
disp('The getted label has clusters:')
size(unique(mem))
disp('The standard label has clusters:')
size(unique(true_mem))
T=Contingency(true_mem,mem);
T=T(list_t,:);%deleting the missing labels
T=T(:,list_m);

%update the true dimensions
[K1 K2]=size(T);

%calculate the MI (unadjusted)
MI=0;
for i=1:K1
    for j=1:K2
        if T(i,j)>0 MI=MI+T(i,j)*log(T(i,j)*n/(NK1(i)*NK2(j)));end;
    end
end
MI=MI/n;

a=NK1;b=NK2;
AB=a'*b;
% MI=sum(sum(T.*mylog(T*n./AB)))/n;
%-------------correcting for randomness---------------------------
E3=(AB/n^2).*log(AB/n^2);

EPLNP=zeros(K1,K2);
LogNij=log([1:min(max(a),max(b))]/N);
for i=1:K1
    for j=1:K2
        nij=max(1,a(i)+b(j)-N);
        X=sort([nij N-a(i)-b(j)+nij]);
        if N-b(j)>X(2)
            nom=[[a(i)-nij+1:a(i)] [b(j)-nij+1:b(j)] [X(2)+1:N-b(j)]];
            dem=[[N-a(i)+1:N] [1:X(1)]];
        else
            nom=[[a(i)-nij+1:a(i)] [b(j)-nij+1:b(j)]];       
            dem=[[N-a(i)+1:N] [N-b(j)+1:X(2)] [1:X(1)]];
        end
        p0=prod(nom./dem)/N;
        EPLNP(i,j)=nij*LogNij(nij)*p0;
        p1=p0*(a(i)-nij)*(b(j)-nij)/(nij+1)/(N-a(i)-b(j)+nij+1);  
        
        for nij=max(1,a(i)+b(j)-N)+1:1:min(a(i), b(j))
%             % modification
%             if(isinf(p1))
%                 p1 = 0;
%             end
            
            EPLNP(i,j)=EPLNP(i,j)+nij*LogNij(nij)*p1;

            
            p1=p1*(a(i)-nij)*(b(j)-nij)/(nij+1)/(N-a(i)-b(j)+nij+1);            
        end
    end
end

EMI=sum(sum(EPLNP))-sum(sum(E3));
AMI=(MI-EMI)/(max(HK1,HK2)-EMI);
AVI=2*(MI-EMI)/(HK1+HK2-2*EMI);

%VI=HK1+HK2-2*MI;
NMI=MI/max(HK1,HK2);
% fprintf('Mutual information= %f  VI= %f\n',MI,VI);

%---------------------auxiliary functions---------------------
function Cont=Contingency(Mem1,Mem2)

if nargin < 2 || min(size(Mem1)) > 1 || min(size(Mem2)) > 1
   error('Contingency: Requires two vector arguments')
   return
end

Cont=zeros(max(Mem1),max(Mem2));

for i = 1:length(Mem1);
   Cont(Mem1(i),Mem2(i))=Cont(Mem1(i),Mem2(i))+1;
end

            