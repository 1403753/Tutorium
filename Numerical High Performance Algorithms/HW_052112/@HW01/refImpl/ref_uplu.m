function [A, P] = ref_uplu(A, n)
    [L,U,P] = lu(A);
    A = L+U - eye(n);
end