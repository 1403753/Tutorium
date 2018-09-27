function loadRefImpl(obj)
   
    % obj.loadTestInput(HWXX.CONST.INPUTFNAME);
    
    obj.n = 2000;
    obj.A = rand(obj.n);
    
    oldDir = pwd;
    cd(HWXX.CONST.REFIMPLDIR);
    
    %%%%%%%%%%%%
    %  part 1  %
    %%%%%%%%%%%%
    
    [obj.B, P] = ref_plu(obj.A, obj.n);
    obj.L = tril(obj.B, -1) + eye(obj.n);
    obj.U = triu(obj.B);
    obj.X = transpose(P)*obj.L*obj.U;
    
    obj.plu_r = ref_accuracy(obj.X, obj.A);
    
    %%%%%%%%%%%%
    %  part 2  %
    %%%%%%%%%%%%
    
    obj.tx = 2*ones(obj.n, 1);
    obj.solveL_b = obj.L*obj.tx;
    
    obj.solveL_x = ref_solveL(obj.B, obj.solveL_b, obj.n);
    
    obj.solveL_r = ref_accuracy(obj.L*obj.solveL_x, obj.solveL_b);
    obj.solveL_f = ref_accuracy(obj.solveL_x, obj.tx);
    
    obj.solveU_b = obj.U*obj.tx;
    
    x = ref_solveU(obj.B, obj.solveU_b, obj.n);
    
    obj.solveU_r = ref_accuracy(obj.U*x, obj.solveU_b);
    obj.solveU_f = ref_accuracy(x, obj.tx);
    
    %%%%%%%%%%%%
    %  part 3  %
    %%%%%%%%%%%%
    
    obj.linSolve_b = obj.A*obj.tx;
    
    x = ref_linSolve(obj.A, obj.linSolve_b, obj.n);
    
    obj.linSolve_r = ref_accuracy(obj.A*x, obj.linSolve_b);
    obj.linSolve_f = ref_accuracy(x, obj.tx);
    
    cd(oldDir);
end