n = [10 100 1000];

for k = 1:length(n)
    
    %%%%%%%%%%%%%%
    %  solveL.m  %
    %%%%%%%%%%%%%%
    
    B = rand(n(k));
    
    ty = ones(n(k), 1);
    
    L = tril(B, -1) + eye(n(k));
    b = L*ty;
    
    y1 = ref_solveL(B, b, n(k));
    
    lr = ref_accuracy(L*y1, b);
    lf = ref_accuracy(y1, ty);
    
    %%%%%%%%%%%%%%
    %  solveU.m  %
    %%%%%%%%%%%%%%
    
    tx = ones(n(k), 1);
    
    U = triu(B);
    y = U*tx;
    
    x = ref_solveU(B, y, n(k));
    
    ur = ref_accuracy(U*x, y);
    uf = ref_accuracy(x, tx);
    
end