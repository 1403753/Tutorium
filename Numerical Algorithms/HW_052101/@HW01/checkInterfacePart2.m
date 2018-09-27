function [r, msg] = checkInterfacePart2(obj)
    mlock
    
    persistent r__
    persistent n_ref
    
    n = 5;
    assert (n >= 2);
    assert ((~isinf(n) && floor(n) == n) || n > 1);
    
    msg = '';
    n_ref = 5;
    r__ = 1;
    
    %%%%%%%%%%%%%%%%
    %  accuracy.m  %
    %%%%%%%%%%%%%%%%
    
    if obj.accuracy
        
        x = rand(n, 1);
        y = rand(n, 1);
        
        em = 0;
        obj.ctx(obj.partNr).addText('    - try ''accuracy.m'' ..');
        
        try
            rres = accuracy(x, y);
            obj.ctx(obj.partNr).addText(' ok\n');
        catch ME
            msg = ' ACCURACY.M ! error in function';
            obj.ctx(obj.partNr).addText(' failed\n\n'), em = 1;
            obj.ctx(obj.partNr).addErrMsg(ME);
        end
        
        if exist('rres', 'var')
            err = '';
            if ~isscalar(rres)
                str = ' ! residual is not a scalar';
                obj.ctx(obj.partNr).addText(['     ' str '\n']), em = 1;
                err = [err str];
            end
            if ~isnumeric(rres)
                str = ' ! residual has wrong type';
                obj.ctx(obj.partNr).addText(['     ' str '\n']), em = 1;
                err = [err str];
            end
            if em
                msg = [msg ' ACCURACY.M' err];
            end
        end
        
        if em
            obj.accuracy = 0; r__ = 0;
        end
        
    else
        r__ = 0;
    end
    
    assert(n == n_ref);
    
    %%%%%%%%%%%%%%
    %  solveL.m  %
    %%%%%%%%%%%%%%
    
    if obj.solveL
        
        ty = ones(n, 1);
        L = tril(rand(n));
        b = L*ty;
        
        em = 0;
        obj.ctx(obj.partNr).addText('    - try ''solveL.m'' ..');
        
        try
            y = solveL(L, b, n);
            obj.ctx(obj.partNr).addText(' ok\n');
        catch ME
            str = ' SOLVEL.M ! error in function';
            obj.ctx(obj.partNr).addText(' failed\n\n'), em = 1;
            obj.ctx(obj.partNr).addErrMsg(ME);
            msg = [msg str];
        end
        
        if exist('y', 'var')
            err = '';
            if ~isnumeric(y)
                str = ' ! output vector is not numeric';
                obj.ctx(obj.partNr).addText(['    ' str '\n']), em = 1;
                err = [err str];
            end
            if length(y) ~= n
                str = ' ! output vector has wrong dimension';
                obj.ctx(obj.partNr).addText(['    ' str ' (dim(x) == %i), n == %i\n'], length(y), n_ref), em = 1;
                err = [err str];
            end
            if em
                msg = [msg ' SOLVEL.M' err];
            end
        end
        if em
            obj.solveL = 0; r__ = 0;
        end
    else
        r__ = 0;
    end
    
    assert(n == n_ref);
    
    %%%%%%%%%%%%%%
    %  solveU.m	 %
    %%%%%%%%%%%%%%
    
    if obj.solveU
        
        tx = ones(n, 1);
        U = triu(rand(n));
        y = U*tx;
        
        em = 0;
        obj.ctx(obj.partNr).addText('    - try ''solveU.m'' ..');
        
        try
            x = solveU(U, y, n);
            obj.ctx(obj.partNr).addText(' ok\n');
        catch ME
            str = ' SOLVEU.M ! error in function';
            obj.ctx(obj.partNr).addText(' failed\n\n'), em = 1;
            obj.ctx(obj.partNr).addErrMsg(ME);
            msg = [msg str];
        end
        
        if exist('x', 'var')
            err = '';
            if ~isnumeric(x)
                str = ' ! output vector is not numeric';
                obj.ctx(obj.partNr).addText(['    ' str '\n']), em = 1;
                err = [err str];
            end
            if length(x) ~= n
                str = ' ! output vector has wrong dimension';
                obj.ctx(obj.partNr).addText(['    ' str ' (dim(x) == %i), n == %i\n'], length(x), n_ref), em = 1;
                err = [err str];
            end
            if em
                msg = [msg ' SOLVEU.M' err];
            end
        end
        
        if em
            obj.solveU = 0; r__ = 0;
        end
    else
        r__ = 0;
    end
    
    assert(n == n_ref);
    
    %%%%%%%%%%%%%
    %  part2.m  %
    %%%%%%%%%%%%%
    
    if HWXX.CONST.TESTSCRIPTS
        
        obj.ctx(obj.partNr).addText('    - try ''part2.m'' ..');
        
        fTemp = fopen('temp.txt', 'w');
        msg	= [msg '  -''part2.m'' ..'];
        
        fprintf(fTemp, msg);
        fclose(fTemp);
        try
            part2
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
        msg = [msg ' couldn''t test part2, ''clear'' command used?'];
    else
        r = r__;
    end
    munlock;
end