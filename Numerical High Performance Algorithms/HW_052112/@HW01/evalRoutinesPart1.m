function [r, msg] = evalRoutinesPart1(obj)
    r = 1;
    msg = '';
    tol = 1e+05;
    %%%%%%%%%%%
    %  plu.m  %
    %%%%%%%%%%%
    
    if obj.plu
				tic;
        [B, P] = plu(obj.A, obj.n);
        obj.submission(obj.submissionNr).observed_t = toc;
				
				X = transpose(P)*(tril(B,-1)+eye(obj.n))*triu(B);
        
        R = norm(X - obj.A, 1) / norm(obj.A, 1); % compute output residual
        
        if (R < 0) || (R > tol*obj.plu_r) || (tol*R < obj.plu_r)
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
        
        obj.submission(obj.submissionNr).t = t;
				obj.submission(obj.submissionNr).rn = rn;
				obj.submission(obj.submissionNr).foe = foe;
				obj.submission(obj.submissionNr).fae = fae;
        
        if (rn < 0) || (rn > tol*obj.rn) || (tol*rn < obj.rn) || (t < 0) || ...
                (foe < 0) || (foe > tol*obj.foe) || (tol*foe < obj.foe) || ...
                (fae < 0) || (fae > tol*obj.fae) || (tol*fae < obj.fae)
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
   
    %%%%%%%%%%%%
    %  uplu.m  %
    %%%%%%%%%%%%
    
    if obj.uplu
        tic;
        [B, P] = uplu(obj.A, obj.n);
        obj.submission(obj.submissionNr).observed_ut = toc;
        
        X = transpose(P)*(tril(B,-1)+eye(obj.n))*triu(B);
        
        R = norm(X - obj.A, 1) / norm(obj.A, 1); % compute output residual
        
        if (R < 0) || (R > tol*obj.plu_r) || (tol*R < obj.plu_r)
            msg = ' UPLU.M ! dubious result';
            obj.ctx(obj.partNr).addText('    ! uplu.m: dubious result\n'), r = 0; obj.uplu = 0;
            obj.ctx(obj.partNr).addText(['      - reference residual:          %1.e' '\n'], obj.plu_r);
            obj.ctx(obj.partNr).addText(['      - ''uplu.m'' residual:           %1.e' '\n'], R);
        else
            obj.ctx(obj.partNr).addText('    - uplu.m: ok\n');
        end
    end
    
    %%%%%%%%%%%%%%%%%
    %  upluStats.m  %
    %%%%%%%%%%%%%%%%%
    
    if obj.upluStats && ~obj.uplu
        str = ' UPLUSTATS.M ! required routines missing/not working';
        msg = [msg str];
        obj.ctx(obj.partNr).addText('    ! ''upluStats.m'': required routines missing/not working\n'), r = 0; obj.upluStats = 0;
    end
    
    if obj.upluStats && obj.uplu
        
        [urn, ufoe, ufae, ut] = upluStats(obj.A, obj.n);
        
 				obj.submission(obj.submissionNr).ut = ut;
				obj.submission(obj.submissionNr).urn = urn;
				obj.submission(obj.submissionNr).ufoe = ufoe;
				obj.submission(obj.submissionNr).ufae = ufae;
        
        if (urn < 0) || (urn > tol*obj.rn) || (tol*urn < obj.rn) || (ut < 0) || ...
                (ufoe < 0) || (ufoe > tol*obj.foe) || (tol*ufoe < obj.foe) || ...
                (ufae < 0) || (ufae > tol*obj.fae) || (tol*ufae < obj.fae)
            msg = [msg ' UPLUSTATS.M ! dubious result(s)'];
            obj.ctx(obj.partNr).addText('    ! upluStats.m: dubious results\n'), r = 0; obj.upluStats = 0;
            
            obj.ctx(obj.partNr).addText(['      - runtime uplu:                %f s' '\n'], ut);            
            obj.ctx(obj.partNr).addText(['      - reference rn:                %1.e' '\n'], obj.rn);
            obj.ctx(obj.partNr).addText(['      - ''upluStats.m'' rn:            %1.e' '\n'], urn);
            obj.ctx(obj.partNr).addText(['      - reference foe:               %1.e' '\n'], obj.foe);
            obj.ctx(obj.partNr).addText(['      - ''upluStats.m'' foe:            %1.e' '\n'], ufoe);            
            obj.ctx(obj.partNr).addText(['      - reference fae:               %1.e' '\n'], obj.fae);
            obj.ctx(obj.partNr).addText(['      - ''upluStats.m'' fae:            %1.e' '\n'], ufae);
        else
            obj.ctx(obj.partNr).addText('    - upluStats.m: ok\n');
        end
    end
    
    %%%%%%%%%%%%%
    %  results  %
    %%%%%%%%%%%%%
    
    obj.ctx(obj.partNr).addText('\n    - final results:\n');
    
    if obj.plu && obj.pluStats && obj.pluStats && obj.plu
        
        obj.ctx(obj.partNr).addText('\n      ''lu-decomposition statistics'': \n');
        obj.ctx(obj.partNr).addText(['      - runtime plu:                 %f s' '\n'], t);
        obj.ctx(obj.partNr).addText(['      - runtime uplu:                %f s' '\n'], ut);
        obj.ctx(obj.partNr).addText(['      - reference rn:                %1.e' '\n'], obj.rn);
        obj.ctx(obj.partNr).addText(['      - ''pluStats.m'' rn:             %1.e' '\n'], rn);
        obj.ctx(obj.partNr).addText(['      - ''upluStats.m'' rn:            %1.e' '\n'], urn);
        obj.ctx(obj.partNr).addText(['      - reference foe:               %1.e' '\n'], obj.foe);
        obj.ctx(obj.partNr).addText(['      - ''pluStats.m'' foe:             %1.e' '\n'], foe);
        obj.ctx(obj.partNr).addText(['      - ''upluStats.m'' foe:            %1.e' '\n'], ufoe);
        obj.ctx(obj.partNr).addText(['      - reference fae:               %1.e' '\n'], obj.fae);
        obj.ctx(obj.partNr).addText(['      - ''pluStats.m'' fae:             %1.e' '\n'], fae);
        obj.ctx(obj.partNr).addText(['      - ''upluStats.m'' fae:            %1.e' '\n'], ufae);
        
        msg = [msg ';' sprintf('%f', t)];

    else
        obj.ctx(obj.partNr).addText('\n      Couldn''t evaluate ''lu-decomposition statistics'' \n');
        r = 0;
    end
end