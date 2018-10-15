function [rn, foe, fae, t] = pluStats(A, n)
		tic;
		[B, P] = plu(A, n);
		t = toc;
		X = transpose(P)*(tril(B, -1) + eye(n))*triu(B);
		fae = norm(X - A, 1) / norm(A, 1);
        foe = 12;
        rn = 13;
end