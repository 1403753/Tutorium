function loadRefImpl(obj)

    % obj.loadTestInput(HWXX.CONST.INPUTFNAME);
    
		obj.n = obj.CONST.N;
		obj.A = rand(obj.n);
		
    oldDir = pwd;
    cd(obj.CONST.REFIMPLDIR);
    
    %%%%%%%%%
    %  plu  %
    %%%%%%%%%
    
    [B, P] = ref_plu(obj.A, obj.n);
    L = tril(B, -1) + eye(obj.n);
    U = triu(B);
    X = P'*L*U;
    obj.R = ref_accuracy(X, obj.A); 
   
    %%%%%%%%%%%%
    %  solveL  %
    %%%%%%%%%%%%
    
    
    tx = 2*ones(obj.n, 1);
    
    L = tril(B, -1) + eye(obj.n);
    b = L*tx;
    
    y = ref_solveL(B, b, obj.n);

    obj.rn_L = ref_accuracy(L*y, b);
    obj.foe_L = ref_accuracy(y, tx);

    %%%%%%%%%%%%
    %  solveU  %
    %%%%%%%%%%%%

    U = triu(B);
    b = U*tx;

    x = ref_solveU(B, b, obj.n);

    obj.rn_U = ref_accuracy(U*x, b);
    obj.foe_U = ref_accuracy(x, tx);

    %%%%%%%%%%%%%%
    %  linSolve  %
    %%%%%%%%%%%%%%
    
    b = obj.A * tx;
    
    [x] = ref_linSolve(obj.A, b, obj.n);
    
    obj.rn_linSol = ref_accuracy(obj.A*x, b);
    obj.foe_linSol = ref_accuracy(x, tx);
    
    cd(oldDir);
end