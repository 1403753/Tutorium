function [r, msg] = evalRoutinesPart1(obj)
    r = 1;
    msg = '';
    
    %%%%%%%%%%%
    %  plu.m  %
    %%%%%%%%%%%
    
    if obj.plu
        
        [B, P] = plu(obj.A, obj.n);
        
        X = transpose(P)*(tril(B,-1)+eye(obj.n))*triu(B);
        
        R = norm(X - obj.A, 1) / norm(obj.A, 1); % compute output residual
        
        if (R < 0) || (R > 2*obj.plu_r) || (2*R < obj.plu_r)
            msg = ' PLU.M ! dubious result';
            obj.ctx(obj.partNr).addText('    ! plu.m: dubious result\n'), r = 0; obj.plu = 0;
            obj.ctx(obj.partNr).addText(['      - reference residual:          %1.e' '\n'], obj.plu_r);
            obj.ctx(obj.partNr).addText(['      - ''plu.m'' residual:          %1.e' '\n'], R);
        else
            obj.ctx(obj.partNr).addText('    - plu.m: ok\n');
        end
    end
    
    %%%%%%%%%%%%%%%%
    %  pluStats.m  %
    %%%%%%%%%%%%%%%%
    
    if obj.pluStats && ~obj.plu
        str = ' PLUSTATS.M ! required routines missing/not working';
        msg = [msg str];
        obj.ctx(obj.partNr).addText('    ! ''pluStats.m'': required routines missing/not working\n'), r = 0; obj.pluStats = 0;
    end
    
    if obj.pluStats && obj.plu
        
        [rn, foe, fae, t] = pluStats(obj.A, obj.n);
        
        if (rn < 0) || (rn > 2*obj.plu_r) || (2*rn < obj.plu_r) || (t < 0) || ...
                (foe < 0) || (foe > 2*obj.foe) || (2*foe < obj.foe) || ...
                (fae < 0) || (fae > 2*obj.fae) || (2*fae < obj.fae)
            msg = [msg ' PLUSTATS.M ! dubious result(s)'];
            obj.ctx(obj.partNr).addText('    ! pluStats.m: dubious results\n'), r = 0; obj.pluStats = 0;
            
            obj.ctx(obj.partNr).addText(['      - runtime:                     %f s' '\n'], t);
            obj.ctx(obj.partNr).addText(['      - reference rn:                %1.e' '\n'], obj.rn);
            obj.ctx(obj.partNr).addText(['      - ''pluStats.m'' rn:             %1.e' '\n'], rn);
            obj.ctx(obj.partNr).addText(['      - reference foe:               %1.e' '\n'], obj.foe);
            obj.ctx(obj.partNr).addText(['      - ''pluStats.m'' foe:             %1.e' '\n'], foe);
            obj.ctx(obj.partNr).addText(['      - reference fae:               %1.e' '\n'], obj.fae);
            obj.ctx(obj.partNr).addText(['      - ''pluStats.m'' fae:             %1.e' '\n'], fae);
        else
            obj.ctx(obj.partNr).addText('    - pluStats.m: ok\n');
        end
    end
    
    %%%%%%%%%%%%%
    %  results  %
    %%%%%%%%%%%%%
    
    obj.ctx(obj.partNr).addText('\n    - final results:\n');
    
    if obj.plu && obj.pluStats
        
        obj.ctx(obj.partNr).addText('\n      ''lu-decomposition statistics'': \n');
        obj.ctx(obj.partNr).addText(['      - ''pluStats.m'' rn:             %1.e' '\n'], rn);
        obj.ctx(obj.partNr).addText(['      - reference rn:                %1.e' '\n'], obj.plu_r);
        obj.ctx(obj.partNr).addText(['      - ''pluStats.m'' foe:             %1.e' '\n'], foe);
        obj.ctx(obj.partNr).addText(['      - reference foe:               %1.e' '\n'], obj.foe);
        obj.ctx(obj.partNr).addText(['      - ''pluStats.m'' fae:             %1.e' '\n'], fae);
        obj.ctx(obj.partNr).addText(['      - reference fae:               %1.e' '\n'], obj.fae);
        obj.ctx(obj.partNr).addText(['      - runtime:                     %f s' '\n'], t);
        msg = [msg ';' sprintf('%f', t)];
        obj.submission(obj.submissionNr).runtime = t;
        
    else
        obj.ctx(obj.partNr).addText('\n      Couldn''t evaluate ''lu-decomposition statistics'' \n');
        r = 0;
    end
end