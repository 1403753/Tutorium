function [r, msg] = evalRoutinesPart1(obj)
    r = 1;
    msg = '';
    tol = 1e-10;
		
    %%%%%%%%%%%%%
    %  invit.m  %
    %%%%%%%%%%%%%
    
    if obj.invit
				tic;
        [lambda, V, it, erreval, errres] = invit(obj.n, obj.A, obj.x0, obj.sigma, obj.eps, obj.maxit, obj.l);
				invit_t = toc;
				
        obj.submission(obj.submissionNr).invit_t = invit_t;
				
				rerrl1 = abs(obj.lambda - lambda) / obj.lambda; % compute relative lambda error
        obj.submission(obj.submissionNr).rerrl1 = rerrl1;
				
				V = V / norm(V);
				errV1 = norm(abs(obj.V) - abs(V));
				obj.submission(obj.submissionNr).errV1 = errV1;
				
        if (rerrl1 > tol) || (errV1 > tol)
            msg = ' INVIT.M ! dubious result';
            obj.ctx(obj.partNr).addText('    ! invit.m: dubious result\n'), r = 0; obj.invit = 0;
            obj.ctx(obj.partNr).addText(['      - relative error in lambda:    %1.e' '\n'], rerrl1);
            obj.ctx(obj.partNr).addText(['      - absolute error in evec:      %1.e' '\n'], errV1);
        else
            obj.ctx(obj.partNr).addText('    - invit.m: ok\n');
        end
    end
    
    %%%%%%%%%%%
    %  rqi.m  %
    %%%%%%%%%%%
    
    if obj.rqi
				tic;
        [lambda2, V2, it2, erreval2, errres2] = rqi(obj.n, obj.A, obj.x0, obj.sigma, obj.eps, obj.maxit, obj.l);
        rqi_t = toc;
				obj.submission(obj.submissionNr).rqi_t = rqi_t;
				rerrl2 = abs(obj.lambda - lambda2) / obj.lambda; % compute relative lambda error
        obj.submission(obj.submissionNr).rerrl2 = rerrl2;
				
				V2 = V2 / norm(V2);
				errV2 = norm(abs(obj.V) - abs(V2));
				obj.submission(obj.submissionNr).errV2 = errV2;
				
        if (rerrl2 > tol) || (errV2 > tol)
            msg = ' RQI.M ! dubious result';
            obj.ctx(obj.partNr).addText('    ! rqi.m: dubious result\n'), r = 0; obj.rqi = 0;
            obj.ctx(obj.partNr).addText(['      - relative error in lambda:    %1.e' '\n'], rerrl2);
            obj.ctx(obj.partNr).addText(['      - absolute error in evec:      %1.e' '\n'], errV2);
        else
            obj.ctx(obj.partNr).addText('    - rqi.m: ok\n');
        end
    end

    %%%%%%%%%%%%%
    %  rqi_k.m  %
    %%%%%%%%%%%%%
    
    if obj.rqi_k
				tic;
        [lambda3, V3, it3, erreval3, errres3] = rqi_k(obj.n, obj.A, obj.x0, obj.sigma, obj.eps, obj.maxit, obj.l, obj.k);
        rqi_k_t = toc;
				obj.submission(obj.submissionNr).rqi_k_t = rqi_k_t;
				rerrl3 = abs(obj.lambda - lambda3) / obj.lambda; % compute relative lambda error
        obj.submission(obj.submissionNr).rerrl3 = rerrl3;
				
				V3 = V3 / norm(V3);
				errV3 = norm(abs(obj.V) - abs(V3));
				obj.submission(obj.submissionNr).errV3 = errV3;
				
        if (rerrl3 > tol) || (errV3 > tol)
            msg = ' RQI_K.M ! dubious result';
            obj.ctx(obj.partNr).addText('    ! rqi_k.m: dubious result\n'), r = 0; obj.rqi_k = 0;
            obj.ctx(obj.partNr).addText(['      - relative error in lambda:    %1.e' '\n'], rerrl3);
            obj.ctx(obj.partNr).addText(['      - absolute error in evec:      %1.e' '\n'], errV3);
        else
            obj.ctx(obj.partNr).addText('    - rqi_k.m: ok\n');
        end
    end
    
    %%%%%%%%%%%%%
    %  results  %
    %%%%%%%%%%%%%
    
    obj.ctx(obj.partNr).addText('\n    - final results:\n');
    
    if obj.invit && obj.rqi && obj.rqi_k
        
        obj.ctx(obj.partNr).addText(['      - runtime invit:                 %f s' '\n'], invit_t);
        obj.ctx(obj.partNr).addText(['      - runtime rqi:                   %f s' '\n'], rqi_t);
        obj.ctx(obj.partNr).addText(['      - runtime rqi_k:                 %f s' '\n'], rqi_k_t);
        obj.ctx(obj.partNr).addText(['      - invit rel. error in lambda:    %1.e' '\n'], rerrl1);
        obj.ctx(obj.partNr).addText(['      - invit abs. error in evec:      %1.e' '\n'], errV1);
        obj.ctx(obj.partNr).addText(['      - rqi rel. error in lambda:      %1.e' '\n'], rerrl2);
        obj.ctx(obj.partNr).addText(['      - rqi abs. error in evec:        %1.e' '\n'], errV2);
        obj.ctx(obj.partNr).addText(['      - rqi_k rel. error in lambda:    %1.e' '\n'], rerrl3);
        obj.ctx(obj.partNr).addText(['      - rqi_k abs. error in evec:      %1.e' '\n'], errV3);
        
        msg = [msg ';' sprintf('%f, %f, %f', invit_t, rqi_t, rqi_k_t)];

    else
        obj.ctx(obj.partNr).addText('\n      Couldn''t evaluate results .. \n');
        r = 0;
    end
end