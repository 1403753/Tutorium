function x = ref_linSolve(A, b, n)
    [A, P] = ref_plu(A, n);
    b = P*b;
    y = ref_solveL(A, b, n);
    x = ref_solveU(A, y, n);
end