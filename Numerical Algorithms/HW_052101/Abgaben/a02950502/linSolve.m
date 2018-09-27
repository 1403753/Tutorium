function x = linSolve(A, b, n)
	[A, P] = plu(A, n);
	b = P*b;
	y = solveL(A, b, n);
	x = solveU(A, y, n);
end