function x = ref_solveU(B, b, n)
    U = triu(B);
    x = zeros(n, 1);
    x(n) = b(n) / U(n, n);
    for i = n-1:-1:1
      x(i) = (b(i) - sum(U(i, i+1:n)*x(i+1:n))) / U(i, i);
    endfor
end