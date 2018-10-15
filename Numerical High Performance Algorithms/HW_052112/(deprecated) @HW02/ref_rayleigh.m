function [x, lambda, iter] = ref_rayleigh(A,  numitr) 
    [m,n] = size(A);
    if m~=n
        disp('matrix A  is not square');
        return;
    end
    I = eye(n);
%     x = rand(n,1);
    x = [0.807;0.397];
    for k = 1 : numitr
        iter = k;
        sigma = x'*A*x / (x'*x);
        y = (A-sigma*I)\x;
        lambda = norm(y, inf);
        x = y / lambda;
    end
end