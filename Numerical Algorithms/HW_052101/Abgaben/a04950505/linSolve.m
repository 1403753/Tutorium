function x = linSolve(A, b, n)
	[B, P] = plu(A, n);
	y = solveL(B, b, n);
	x = solveU(B, y, n);
end