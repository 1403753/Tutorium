clear;
n = 503;
%{
A = [10 -7 0
     -3  2 6
      5 -1 5];
%}
A = rand(n);
%{
[L1,U1,P1] = lu(A);
[B, P2] = ref_plu(A,n);
L2 = tril(B,-1) + eye(n);
U2 = triu(B);
b = L2*ones(n,1);
ref_solveL(B, b, n);
b = U2*ones(n,1);
ref_solveU(B, b, n);
%}
b = A*ones(n,1);
ref_linSolve(A, b, n);
