function x = ref_solveU(B, b, n)
    U = triu(B);
    x = U \ b;
end