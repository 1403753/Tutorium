function [r, t] = pluStats(A, n)
		tic;
		[B, P] = plu(A, n);
		t = toc;
		X = transpose(P)*(tril(B, -1) + eye(n))*triu(B);
		r = norm(X - A, 1) / norm(A, 1);
end