function y = solveL(B, b, n)
    L = tril(B, -1) + eye(n);
    y = L \ b;
end