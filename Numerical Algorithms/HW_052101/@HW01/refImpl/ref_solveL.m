function x = ref_solveL(B, b, n)
    L = tril(B,-1) + eye(n);
    x = L \ b;
end