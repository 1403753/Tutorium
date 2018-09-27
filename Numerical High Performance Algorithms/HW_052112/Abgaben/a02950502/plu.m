function [LU, P] = plu(A, n)
    [L,U,P] = lu(A);
    LU = L+U - eye(n);
		LU = 3;
end