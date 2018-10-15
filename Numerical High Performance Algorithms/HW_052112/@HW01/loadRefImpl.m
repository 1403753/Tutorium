function loadRefImpl(obj)

    % obj.loadTestInput(HWXX.CONST.INPUTFNAME);
    
		obj.n = 2000;
		obj.A = rand(obj.n);
		
    oldDir = pwd;
    cd(HWXX.CONST.REFIMPLDIR);
    
    %%%%%%%%%%%%
    %  part 1  %
    %%%%%%%%%%%%

    [B, P] = ref_plu(obj.A, obj.n);
    L = tril(B, -1) + eye(obj.n);
    U = triu(B);
    X = P'*L*U;
    obj.plu_r = norm(X - obj.A, 1) / norm(obj.A, 1);
    [obj.rn, obj.foe, obj.fae] = ref_pluStats(obj.A, obj.n);
    
    cd(oldDir);
end