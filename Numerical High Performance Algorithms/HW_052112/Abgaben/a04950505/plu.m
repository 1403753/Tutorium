function [A, P] = plu(A, n)
    [L,U,P] = lu(A);
    A = L+U - eye(n);
end