function x = linSolve(A, b, n)
    [B, P] = plu(A, n);
    b = P*b;
    y = solveL(B, b, n);
    x = solveU(B, y, n);
end