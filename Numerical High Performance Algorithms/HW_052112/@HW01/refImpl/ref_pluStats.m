function [rn, foe, fae, t] = ref_pluStats(A, n)
		tic;
		[B, P] = ref_plu(A, n);
		t = toc;
		tx = 2*ones(n,1);
		b = A*tx;
		L = tril(B, -1) + eye(n);
		U = triu(B);
		X = P'*L*U;		
		y = L\P*b;
		x = U\y;
		rn = norm(A*x - b, 1) / norm(b, 1);
		foe = norm(x - tx, 1) / norm(tx, 1);
		fae = norm(X - A, 1) / norm(A, 1);
end