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
    obj.X = transpose(P)*L*U;
    
    obj.plu_r = norm(obj.X - obj.A, 1) / norm(obj.A, 1);
    
    
    cd(oldDir);
end