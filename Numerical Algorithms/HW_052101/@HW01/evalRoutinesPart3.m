function [r, msg] = evalRoutinesPart3(obj)
    r = 1;
    msg = '';
    
    %%%%%%%%%%%%%%%%
    %  linSolve.m  %
    %%%%%%%%%%%%%%%%
    
    if obj.linSolve && ~(obj.plu && obj.solveL && obj.solveU)
        str = ' LINSOLVE.M ! dependent routines missing/not working';
        msg = [msg str];
        obj.ctx(obj.partNr).addText('    ! ''linSolve.m'': dependent routines missing/not working\n');
				r = 0; obj.linSolve = 0;
    end
    
    if obj.linSolve
        
        x = linSolve(obj.A, obj.linSolve_b, obj.n);
        
        linSolve_r = norm(obj.A*x - obj.linSolve_b, 1) / norm(obj.linSolve_b, 1);
        linSolve_f = norm(x - obj.tx, 1) / norm(obj.tx, 1);
        
        if (linSolve_r < 0 || linSolve_f < 0) || (linSolve_r > 2*obj.linSolve_r || linSolve_f > 2*obj.linSolve_f) || (2*linSolve_r < obj.linSolve_r || 2*linSolve_f < obj.linSolve_f)
            str = ' LINSOLVE.M ! dubious result';
            obj.ctx(obj.partNr).addText('    ! ''linSolve.m'': dubious result\n'), r = 0; obj.linSolve = 0;
            
            msg = [msg str];
            obj.ctx(obj.partNr).addText(['      - ''linSolve'' output residual:  %1.e' '\n'], linSolve_r);
            obj.ctx(obj.partNr).addText(['        - reference residual:        %1.e' '\n'], obj.linSolve_r);
            obj.ctx(obj.partNr).addText(['      - ''linSolve'' output fwd error: %1.e' '\n'], linSolve_f);
            obj.ctx(obj.partNr).addText(['        - reference fwd error:       %1.e' '\n'], obj.linSolve_f);
        else
            obj.ctx(obj.partNr).addText('    - ''linSolve.m'': ok\n');
        end
    end
    
    %%%%%%%%%%%%%
    %  results  %
    %%%%%%%%%%%%%
    
    obj.ctx(obj.partNr).addText('\n    - final results:\n');
    
    if obj.accuracy && obj.linSolve
        
        linSolve_r = accuracy(obj.A*x, obj.linSolve_b);
        linSolve_f = accuracy(x, obj.tx);
        
        obj.ctx(obj.partNr).addText('\n      ''linear solve'':\n');
        obj.ctx(obj.partNr).addText(['      - residual (r):                %1.e' '\n'], linSolve_r);
        obj.ctx(obj.partNr).addText(['        - reference residual:        %1.e' '\n'], obj.linSolve_r);
        obj.ctx(obj.partNr).addText(['      - fwd error (f):               %1.e' '\n'], linSolve_f);
        obj.ctx(obj.partNr).addText(['        - reference fwd error:       %1.e' '\n'], obj.linSolve_f);
        
    else
        obj.ctx(obj.partNr).addText('\n      ''linear solve'': routines missing/not working\n');;
        r = 0;
    end
    
end