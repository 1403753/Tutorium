function x = solveU(B, y, n)
    U = triu(B);
    x = U \ y;
end