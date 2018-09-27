function [r, msg] = evalRoutinesPart2(obj)
    r = 1;
    msg = '';
    
    %%%%%%%%%%%%%%%%
    %  accuracy.m  %
    %%%%%%%%%%%%%%%%
    
    if obj.accuracy
        solveL_r = accuracy(obj.L*obj.solveL_x, obj.solveL_b);
        solveL_f = accuracy(obj.solveL_x, obj.tx);
        
        if (solveL_r < 0 || solveL_f < 0) || (solveL_r > 2*obj.solveL_r || solveL_f > 2*obj.solveL_f) || (2*solveL_r < obj.solveL_r || 2*solveL_f < obj.solveL_f)
            str = ' ACCURACY.M ! dubious result';
            obj.ctx(obj.partNr).addText('    ! ''accuracy.m'': dubious result\n');
            msg = [msg str];
            obj.ctx(obj.partNr).addText(['      - reference residual:          %1.e' '\n'], obj.solveL_r);
            obj.ctx(obj.partNr).addText(['      - ''accuracy.m'' residual:       %1.e' '\n'], solveL_r);
            obj.ctx(obj.partNr).addText(['      - reference fwd err:           %1.e' '\n'], obj.solveL_f);
            obj.ctx(obj.partNr).addText(['      - ''accuracy.m'' fwd err:        %1.e' '\n'], solveL_f);
            r = 0; obj.accuracy = 0;
        else
            obj.ctx(obj.partNr).addText('    - ''accuracy.m'': ok\n');
        end
    end
    
    %%%%%%%%%%%%%%
    %  solveL.m  %
    %%%%%%%%%%%%%%
    
    if obj.solveL
        x1 = solveL(obj.B, obj.solveL_b, obj.n);
        
        solveL_r = norm(obj.L*x1 - obj.solveL_b, 1) / norm(obj.solveL_b, 1);
        solveL_f = norm(x1 - obj.tx, 1) / norm(obj.tx, 1);
        
        if (solveL_r < 0 || solveL_f < 0) || (solveL_r > 2*obj.solveL_r || solveL_f > 2*obj.solveL_f) || (2*solveL_r < obj.solveL_r || 2*solveL_f < obj.solveL_f)
            str = ' SOLVEL.M ! dubious result';
            obj.ctx(obj.partNr).addText('    ! ''solveL.m'': dubious result\n');
            msg = [msg str];
            obj.ctx(obj.partNr).addText(['      - ''solveL'' output residual:    %1.e' '\n'], solveL_r);
            obj.ctx(obj.partNr).addText(['        - reference residual:        %1.e' '\n'], obj.solveL_r);
            obj.ctx(obj.partNr).addText(['      - ''solveL'' output fwd error:   %1.e' '\n'], solveL_f);
            obj.ctx(obj.partNr).addText(['        - reference fwd error:       %1.e' '\n'], obj.solveL_f);
            r = 0; obj.solveL = 0;
        else
            obj.ctx(obj.partNr).addText('    - ''solveL.m'': ok\n');
        end
    end
    
    %%%%%%%%%%%%%%
    %  solveU.m  %
    %%%%%%%%%%%%%%
    
    if obj.solveU
        x2 = solveU(obj.B, obj.solveU_b, obj.n);
        
        solveU_r = norm(obj.U*x2 - obj.solveU_b, 1) / norm(obj.solveU_b, 1);
        solveU_f = norm(x2 - obj.tx, 1) / norm(obj.tx, 1);
        
        if (solveU_r < 0 || solveU_f < 0) || (solveU_r > 2*obj.solveU_r || solveU_f > 2*obj.solveU_f) || (2*solveU_r < obj.solveU_r || 2*solveU_f < obj.solveU_f)
            str = ' SOLVEU.M ! dubious result';
            obj.ctx(obj.partNr).addText('    ! ''solveU.m'': dubious result\n');
            msg = [msg str];
            obj.ctx(obj.partNr).addText(['      - ''solveU'' output residual:    %1.e' '\n'], solveU_r);
            obj.ctx(obj.partNr).addText(['        - reference residual:        %1.e' '\n'], obj.solveU_r);
            obj.ctx(obj.partNr).addText(['      - ''solveU'' output fwd error:   %1.e' '\n'], solveU_f);
            obj.ctx(obj.partNr).addText(['        - reference fwd error:       %1.e' '\n'], obj.solveU_f);
            r = 0; obj.solveU = 0;
        else
            obj.ctx(obj.partNr).addText('    - ''solveU.m'': ok\n');
        end
    end
    
    %%%%%%%%%%%%%
    %  results  %
    %%%%%%%%%%%%%
    
    obj.ctx(obj.partNr).addText('\n    - final results:\n');
    
    if obj.solveL && obj.accuracy
        solveL_r = accuracy(obj.L*x1, obj.solveL_b);
        solveL_f = accuracy(x1, obj.tx);
        
        obj.ctx(obj.partNr).addText('\n      ''lower triangular solve'':\n');
        obj.ctx(obj.partNr).addText(['      - residual (r):                %1.e' '\n'], solveL_r);
        obj.ctx(obj.partNr).addText(['        - reference residual:        %1.e' '\n'], obj.solveL_r);
        obj.ctx(obj.partNr).addText(['      - fwd error (f):               %1.e' '\n'], solveL_f);
        obj.ctx(obj.partNr).addText(['        - reference fwd error:       %1.e' '\n'], obj.solveL_f);
    else
        obj.ctx(obj.partNr).addText('\n      ''lower triangular solve'': routines missing/not working\n');
        r = 0;
    end
    
    if obj.solveU && obj.accuracy
        solveU_r = accuracy(obj.U*x2, obj.solveU_b);
        solveU_f = accuracy(x2, obj.tx);
        
        obj.ctx(obj.partNr).addText('\n      ''upper triangular solve'':\n');
        obj.ctx(obj.partNr).addText(['      - residual (r):                %1.e' '\n'], solveU_r);
        obj.ctx(obj.partNr).addText(['        - reference residual:        %1.e' '\n'], obj.solveU_r);
        obj.ctx(obj.partNr).addText(['      - fwd error (f):               %1.e' '\n'], solveU_f);
        obj.ctx(obj.partNr).addText(['        - reference fwd error:       %1.e' '\n'], obj.solveU_f);
    else
        obj.ctx(obj.partNr).addText('\n      ''upper triangular solve'': routines missing/not working\n');
        r = 0;
    end
end