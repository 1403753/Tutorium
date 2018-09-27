function [r, msg] = evalRoutinesPart1(obj)
    r = 1;
    msg = '';
    
    %%%%%%%%%%%
    %  plu.m  %
    %%%%%%%%%%%
    
    if obj.plu
        
        tic;
        [B, P] = plu(obj.A, obj.n);
        runtime = toc;
        
        X = transpose(P)*(tril(B,-1)+eye(obj.n))*triu(B);
        
        R = norm(X - obj.A, 1) / norm(obj.A, 1); % compute output residual
        
        if (R < 0) || (R > 2*obj.plu_r) || (2*R < obj.plu_r)
            msg = ' PLU.M ! dubious result';
            obj.ctx(obj.partNr).addText('    ! plu.m: dubious result\n'), r = 0; obj.plu = 0;
            obj.ctx(obj.partNr).addText(['      - reference residual:          %1.e' '\n'], obj.plu_r);
            obj.ctx(obj.partNr).addText(['      - ''plu.m'' output residual:     %1.e' '\n'], R);
        else
            obj.ctx(obj.partNr).addText('    - plu.m: ok\n');
        end
    end
    
    %%%%%%%%%%%%%%%%
    %  accuracy.m  %
    %%%%%%%%%%%%%%%%
    
    if obj.accuracy
        
        R = accuracy(obj.X, obj.A);
        
        if (R < 0) || (R > 2*obj.plu_r) || (2*R < obj.plu_r)
            msg = [msg ' ACCURACY.M ! dubious result'];
            obj.ctx(obj.partNr).addText('    ! accuracy.m: dubious result\n'), r = 0; obj.accuracy = 0;
            obj.ctx(obj.partNr).addText(['      - reference residual:          %1.e' '\n'], obj.plu_r);
            obj.ctx(obj.partNr).addText(['      - ''accuracy.m'' residual:       %1.e' '\n'], R);
        else
            obj.ctx(obj.partNr).addText('    - accuracy.m: ok\n');
        end
    end
    
    %%%%%%%%%%%%%
    %  results  %
    %%%%%%%%%%%%%
    
    obj.ctx(obj.partNr).addText('\n    - final results:\n');
    
    if obj.plu && obj.accuracy
        
        R = accuracy(X, obj.A);
        
        obj.ctx(obj.partNr).addText('\n      ''lu-decomposition'': \n');
        obj.ctx(obj.partNr).addText(['      - residual (R):                %1.e' '\n'], R);
        obj.ctx(obj.partNr).addText(['      - reference residual:          %1.e' '\n'], obj.plu_r);
        obj.ctx(obj.partNr).addText(['      - ''plu.m'' runtime:             %f s' '\n'], runtime);
        
    else
        obj.ctx(obj.partNr).addText('\n      ''lu-decomposition'': routines missing/not working\n');
        r = 0;
    end
end