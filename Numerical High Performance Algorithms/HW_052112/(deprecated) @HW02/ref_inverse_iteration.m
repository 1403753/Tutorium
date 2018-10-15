function [x, lambda, iter] = ref_inverse_iteration(A,  numitr) 
    [m,n] = size(A);
    if m~=n
        disp('matrix A  is not square');
        return;
    end
    x = rand(n,1);
    for k = 1 : numitr
        iter = k;
        y = A\x;
        lambda = norm(y, inf);
        x = y /lambda;
    end
end