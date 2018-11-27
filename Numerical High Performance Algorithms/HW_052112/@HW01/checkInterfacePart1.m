function [r, msg] = checkInterfacePart1(obj)
    mlock
    
    persistent r__
    persistent n_ref
    
    n = 8;
    assert (n >= 2);
    assert ((~isinf(n) && floor(n) == n) || n > 1);
    
    n_ref = n;
    r__ = 1;
    msg = '';
    
    assert(n == n_ref);
    
    A = rand(n);
    
    %%%%%%%%%%%
    %  plu.m  %
    %%%%%%%%%%%
    
    if obj.plu
        em = 0;
        obj.ctx(obj.partNr).addText('    - try ''plu.m'' ..');
        
        try
            [B, P] = plu(A, n);
            obj.ctx(obj.partNr).addText(' ok\n');
        catch ME
            msg = ' PLU.M ! error in function';
            obj.ctx(obj.partNr).addText(' failed\n\n'), em = 1;
            obj.ctx(obj.partNr).addErrMsg(ME);
        end
        
        
        if exist('B', 'var') && exist('P', 'var')
            err = '';
            if ~isnumeric(B)
                str = ' ! output matrix A is not numeric';
                obj.ctx(obj.partNr).addText(['     ' str '\n']), em = 1;
                err = [err str];
            end
            if diff(size(B))
                str = ' ! output matrix A is not square';
                obj.ctx(obj.partNr).addText(['     ' str '\n']), em = 1;
                err = [err str];
            end
            if size(B, 1) ~= n
                str = ' ! output matrix A has wrong dimension';
                obj.ctx(obj.partNr).addText(['     ' str ' (dim(A) == %d) \n'], size(B, 1)), em = 1;
                err = [err str];
            end
            if ~isnumeric(P)
                str = ' ! output matrix P is not numeric';
                obj.ctx(obj.partNr).addText(['     ' str '\n']), em = 1;
                err = [err str];
            end
            if size(P, 1) ~= n
                str = ' ! output matrix P has wrong dimension';
                obj.ctx(obj.partNr).addText(['     ' str ' (dim(P) == %d) \n'], size(B, 1)), em = 1;
                err = [err str];
            end
            if ~isequal(P * P', eye(size(P, 1)))
                str = ' ! output matrix P is not orthonormal';
                obj.ctx(obj.partNr).addText(['     ' str '\n']), em = 1;
                err = [err str];
            end
            if em
                msg = [msg ' PLU.M' err];
            end
        end
        if em
            obj.plu = 0; r__ = 0;
        end
    else
        r__ = 0;
    end
    
    assert(n == n_ref);
    
    A = rand(n);
    
    %%%%%%%%%%%%
    %  uplu.m  %
    %%%%%%%%%%%%
    
    if obj.uplu
        em = 0;
        obj.ctx(obj.partNr).addText('    - try ''uplu.m'' ..');
        
        try
            [B, P] = uplu(A, n);
            obj.ctx(obj.partNr).addText(' ok\n');
        catch ME
            msg = ' UPLU.M ! error in function';
            obj.ctx(obj.partNr).addText(' failed\n\n'), em = 1;
            obj.ctx(obj.partNr).addErrMsg(ME);
        end
        
        
        if exist('B', 'var') && exist('P', 'var')
            err = '';
            if ~isnumeric(B)
                str = ' ! output matrix A is not numeric';
                obj.ctx(obj.partNr).addText(['     ' str '\n']), em = 1;
                err = [err str];
            end
            if diff(size(B))
                str = ' ! output matrix A is not square';
                obj.ctx(obj.partNr).addText(['     ' str '\n']), em = 1;
                err = [err str];
            end
            if size(B, 1) ~= n
                str = ' ! output matrix A has wrong dimension';
                obj.ctx(obj.partNr).addText(['     ' str ' (dim(A) == %d) \n'], size(B, 1)), em = 1;
                err = [err str];
            end
            if ~isnumeric(P)
                str = ' ! output matrix P is not numeric';
                obj.ctx(obj.partNr).addText(['     ' str '\n']), em = 1;
                err = [err str];
            end
            if size(P, 1) ~= n
                str = ' ! output matrix P has wrong dimension';
                obj.ctx(obj.partNr).addText(['     ' str ' (dim(P) == %d) \n'], size(B, 1)), em = 1;
                err = [err str];
            end
            if ~isequal(P * P', eye(size(P, 1)))
                str = ' ! output matrix P is not orthonormal';
                obj.ctx(obj.partNr).addText(['     ' str '\n']), em = 1;
                err = [err str];
            end
            if em
                msg = [msg ' UPLU.M' err];
            end
        end
        if em
            obj.uplu = 0; r__ = 0;
        end
    else
        r__ = 0;
    end
    
    assert(n == n_ref);
    
    %%%%%%%%%%%%%%%%
    %  pluStats.m  %
    %%%%%%%%%%%%%%%%
    
    if obj.pluStats && ~obj.plu
        str = ' PLUSTATS.M ! required routines missing/not working';
        msg = [msg str];
        obj.ctx(obj.partNr).addText('    ! ''pluStats.m'': required routines missing/not working\n');
        r__ = 0; obj.pluStats = 0;
    end
    
    if obj.pluStats
        
        A = rand(n);
        
        em = 0;
        obj.ctx(obj.partNr).addText('    - try ''pluStats.m'' ..');
        
        try
            [rn, foe, fae, t] = pluStats(A, n);
            obj.ctx(obj.partNr).addText(' ok\n');
        catch ME
            str = ' PLUSTATS.M ! error in function';
            obj.ctx(obj.partNr).addText(' failed\n\n'), em = 1;
            obj.ctx(obj.partNr).addErrMsg(ME);
            msg = [msg str];
        end
        
        if exist('rn', 'var') && exist('t', 'var') && exist('foe', 'var') && exist('fae', 'var')
            err = '';
            if ~isscalar(fae)
                str = ' ! fae is not a scalar';
                obj.ctx(obj.partNr).addText(['     ' str '\n']), em = 1;
                err = [err str];
            end
            if ~isnumeric(fae)
                str = ' ! fae has wrong type';
                obj.ctx(obj.partNr).addText(['     ' str '\n']), em = 1;
                err = [err str];
            end
            if ~isscalar(rn)
                str = ' ! rn is not a scalar';
                obj.ctx(obj.partNr).addText(['     ' str '\n']), em = 1;
                err = [err str];
            end
            if ~isnumeric(rn)
                str = ' ! rn has wrong type';
                obj.ctx(obj.partNr).addText(['     ' str '\n']), em = 1;
                err = [err str];
            end
            if ~isscalar(foe)
                str = ' ! foe is not a scalar';
                obj.ctx(obj.partNr).addText(['     ' str '\n']), em = 1;
                err = [err str];
            end
            if ~isnumeric(foe)
                str = ' ! foe has wrong type';
                obj.ctx(obj.partNr).addText(['     ' str '\n']), em = 1;
                err = [err str];
            end
            if ~isscalar(t)
                str = ' ! runtime is not a scalar';
                obj.ctx(obj.partNr).addText(['     ' str '\n']), em = 1;
                err = [err str];
            end
            if ~isnumeric(t)
                str = ' ! runtime has wrong type';
                obj.ctx(obj.partNr).addText(['     ' str '\n']), em = 1;
                err = [err str];
            end
            if em
                msg = [msg ' PLUSTATS.M' err];
            end
        end
        if em
            obj.pluStats = 0; r__ = 0;
        end
    else
        r__ = 0;
    end
    
    assert(n == n_ref);
    
    %%%%%%%%%%%%%%%%%
    %  upluStats.m  %
    %%%%%%%%%%%%%%%%%
    
    if obj.upluStats && ~obj.uplu
        str = ' UPLUSTATS.M ! required routines missing/not working';
        msg = [msg str];
        obj.ctx(obj.partNr).addText('    ! ''upluStats.m'': required routines missing/not working\n');
        r__ = 0; obj.upluStats = 0;
    end
    
    if obj.upluStats
        
        A = rand(n);
        
        em = 0;
        obj.ctx(obj.partNr).addText('    - try ''upluStats.m'' ..');
        
        try
            [rn, foe, fae, t] = upluStats(A, n);
            obj.ctx(obj.partNr).addText(' ok\n');
        catch ME
            str = ' UPLUSTATS.M ! error in function';
            obj.ctx(obj.partNr).addText(' failed\n\n'), em = 1;
            obj.ctx(obj.partNr).addErrMsg(ME);
            msg = [msg str];
        end
        
        if exist('rn', 'var') && exist('t', 'var') && exist('foe', 'var') && exist('fae', 'var')
            err = '';
            if ~isscalar(fae)
                str = ' ! fae is not a scalar';
                obj.ctx(obj.partNr).addText(['     ' str '\n']), em = 1;
                err = [err str];
            end
            if ~isnumeric(fae)
                str = ' ! fae has wrong type';
                obj.ctx(obj.partNr).addText(['     ' str '\n']), em = 1;
                err = [err str];
            end
            if ~isscalar(rn)
                str = ' ! rn is not a scalar';
                obj.ctx(obj.partNr).addText(['     ' str '\n']), em = 1;
                err = [err str];
            end
            if ~isnumeric(rn)
                str = ' ! rn has wrong type';
                obj.ctx(obj.partNr).addText(['     ' str '\n']), em = 1;
                err = [err str];
            end
            if ~isscalar(foe)
                str = ' ! foe is not a scalar';
                obj.ctx(obj.partNr).addText(['     ' str '\n']), em = 1;
                err = [err str];
            end
            if ~isnumeric(foe)
                str = ' ! foe has wrong type';
                obj.ctx(obj.partNr).addText(['     ' str '\n']), em = 1;
                err = [err str];
            end
            if ~isscalar(t)
                str = ' ! runtime is not a scalar';
                obj.ctx(obj.partNr).addText(['     ' str '\n']), em = 1;
                err = [err str];
            end
            if ~isnumeric(t)
                str = ' ! runtime has wrong type';
                obj.ctx(obj.partNr).addText(['     ' str '\n']), em = 1;
                err = [err str];
            end
            if em
                msg = [msg ' UPLUSTATS.M' err];
            end
        end
        if em
            obj.upluStats = 0; r__ = 0;
        end
    else
        r__ = 0;
    end
    
    assert(n == n_ref);
    
    %%%%%%%%%%%%%%%%%%%
    %  assignment1.m  %
    %%%%%%%%%%%%%%%%%%%
    
    if HWXX.CONST.TESTSCRIPTS
        
        obj.ctx(obj.partNr).addText('    - try ''assignment1.m'' ..');
        
        fTemp = fopen('temp.txt', 'w');
        msg	= [msg '  -''assignment1.m'' ..'];
        
        fprintf(fTemp, msg);
        fclose(fTemp);
        try
            assignment1
            obj.ctx(obj.partNr).addText(' ok\n');
        catch ME
            if exist('obj', 'var')
                obj.ctx(obj.partNr).addText(' failed\n\n'), r__ = 0;
                obj.ctx(obj.partNr).addErrMsg(ME);
            end
        end
        
        if ~exist('obj', 'var') % <- 'clear' in script was prob. used
            r = 99;
        else
            r = r__;
        end
        fTemp = fopen('temp.txt', 'r');
        msg = fscanf(fTemp, '%c');
        fclose(fTemp);
        delete('temp.txt');
        msg = [msg ' couldn''t test assignment1, ''clear'' command used?'];
    else
        r = r__;
    end
    munlock;
end