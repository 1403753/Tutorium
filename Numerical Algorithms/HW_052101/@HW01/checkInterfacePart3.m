function [r, msg] = checkInterfacePart3(obj)
    
    persistent r__
    persistent n_ref
    
    n = 5;
    assert (n >= 2);
    assert ((~isinf(n) && floor(n) == n) || n > 1);
    
    n_ref = n;
    r__ = 1;
    msg = '';
    
    assert(n == n_ref);
    
    A = rand(n);
    
    %%%%%%%%%%%%%%%%
    %  linSolve.m  %
    %%%%%%%%%%%%%%%%
    
    if obj.linSolve && ~(obj.plu && obj.solveL && obj.solveU)
        str = ' LINSOLVE.M ! required routines missing/not working';
        msg = [msg str];
        obj.ctx(obj.partNr).addText('    ! ''linSolve.m'': required routines missing/not working\n');
        r__ = 0; obj.linSolve = 0;
    end
    
    if obj.linSolve
        
        tx = 2*ones(n,1);
        b = A*tx;
        
        em = 0;
        obj.ctx(obj.partNr).addText('    - try ''linSolve.m'' ..');
        
        try
            x = linSolve(A, b, n);
            obj.ctx(obj.partNr).addText(' ok\n');
        catch ME
            str = ' LINSOLVE.M ! error in function';
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
                obj.ctx(obj.partNr).addText(['    ' str ' (dim(x) == %i), n== %i\n'], length(x), n_ref), em = 1;
                err = [err str];
            end
            if em
                msg = [msg ' LINSOLVE.M' err];
            end
        end
        
        if em
            obj.linSolve = 0; r__ = 0;
        end
    else
        r__ = 0;
    end
    
    assert(n == n_ref);
    
    %%%%%%%%%%%%%
    %  part3.m  %
    %%%%%%%%%%%%%
    
    if HWXX.CONST.TESTSCRIPTS
        
        obj.ctx(obj.partNr).addText('    - try ''part1.m'' ..');
        
        fTemp = fopen('temp.txt', 'w');
        msg	= [msg '  -''part1.m'' ..'];
        
        fprintf(fTemp, msg);
        fclose(fTemp);
        try
            part3
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
        msg = [msg ' couldn''t test part3, ''clear'' command used?'];
    else
        r = r__;
    end
    munlock;
end