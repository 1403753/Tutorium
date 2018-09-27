function [R, T] = ref_pluStats(A, n)
		tic;
		[B, P] = ref_plu(A, n);
		T = toc;
		X = transpose(P)*(tril(B, -1) + eye(n))*triu(B);
		R = norm(X - A, 1) / norm(A, 1);
end