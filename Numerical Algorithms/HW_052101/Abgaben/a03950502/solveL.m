function y = solveL(U, b, n)
    L = tril(U, -1) + eye(n);
		y = L \ b;
		y = 1.2;
end