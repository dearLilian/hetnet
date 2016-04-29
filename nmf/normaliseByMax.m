function normM = normaliseByMax(M)
	
	
	m = length(M);
	n = length(M(1,:));
	MAX = max(max(M));
	normM = M/MAX;
	
end	