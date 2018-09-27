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
						obj.ctx(obj.partNr).addText(['    ! plu.m: dubious result\n']), r = 0; obj.plu = 0;
						obj.ctx(obj.partNr).addText(['      - reference residual:          %1.e' '\n'], obj.plu_r);
						obj.ctx(obj.partNr).addText(['      - ''plu.m'' output residual:     %1.e' '\n'], R);
				else
						obj.ctx(obj.partNr).addText(['    - plu.m: ok\n']);
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
		
				[R, T] = pluStats(obj.A, obj.n);
				
				if (R < 0) || (R > 2*obj.plu_r) || (2*R < obj.plu_r) || (T < 0)
						msg = [msg ' PLUSTATS.M ! dubious result(s)'];
						obj.ctx(obj.partNr).addText(['    ! pluStats.m: dubious results\n']), r = 0; obj.pluStats = 0;

						obj.ctx(obj.partNr).addText(['      - runtime:                     %f s' '\n'], T);
						obj.ctx(obj.partNr).addText(['      - reference residual:          %1.e' '\n'], obj.plu_r);
						obj.ctx(obj.partNr).addText(['      - ''pluStats.m'' residual:       %1.e' '\n'], R);
					
				else
						obj.ctx(obj.partNr).addText(['    - pluStats.m: ok\n']);
				end			
		end
    
    %%%%%%%%%%%%%
    %  results  %
    %%%%%%%%%%%%%

		obj.ctx(obj.partNr).addText('\n    - final results:\n');
		
		if obj.plu && obj.pluStats

				obj.ctx(obj.partNr).addText('\n      ''lu-decomposition statistics'': \n');
				obj.ctx(obj.partNr).addText(['      - residual (R):                %1.e' '\n'], R);
				obj.ctx(obj.partNr).addText(['      - reference residual:          %1.e' '\n'], obj.plu_r);
				obj.ctx(obj.partNr).addText(['      - runtime:                     %f s' '\n'], T);
				msg = [msg ';' sprintf('%f', T)];
				obj.submission(obj.submissionNr).runtime = T;
		
		else
        obj.ctx(obj.partNr).addText('\n      Couldn''t evaluate ''lu-decomposition statistics'' \n');
        r = 0;
		end
end