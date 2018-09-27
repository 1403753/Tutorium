n = [10:10:70];

for k = 1:length(n)
    ty = ones(n(k), 1);
		
		L = tril(rand(n(k)));		
    b = L*ty;
		
    y = solveL(L, b, n(k));
		
		lr = accuracy(L*y, b);
		lf = accuracy(y, ty);
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    

    tx = ones(n(k), 1);

		U = triu(rand(n(k)));

		y = U*tx;
    
		x = solveU(U, y, n(k));
    
 		ur = accuracy(U*x, y);
		uf = accuracy(x, tx);
		
end