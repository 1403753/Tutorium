function x = ref_solveL(B, b, n)
    L = tril(B, -1) + eye(n);
    x = zeros(n, 1);
    x(1) = b(1) / L(1, 1);
    for i=2:n
      x(i) = (b(i) - sum(L(i, 1:i-1)*x(1:i-1))) / L(i, i);
    endfor
end