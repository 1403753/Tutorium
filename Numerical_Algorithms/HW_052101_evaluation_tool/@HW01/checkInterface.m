function checkInterface(obj)
	n = [2,3,4,5,6,7,8,9,10];
	persistent r__
  persistent n_ref
  
  msg = '';
	
  for i = 1:length(n)
		mlock
		
    assert (n(i) >= 2);
    assert ((~isinf(n(i)) && floor(n(i)) == n(i)) || n(i) > 1);
    
    n_ref = n(i);
    r__ = 1;
    msg = '';

    assert(n(i) == n_ref);
    
    A = rand(n(i));
    
    %%%%%%%%%%%
    %  plu.m  %
    %%%%%%%%%%%
    
    if obj.plu
		
        em = 0;
				err = '';

        try
            [B, P] = plu(A, n(i));
        catch ME
            em = 1;
        end
        
        
        if exist('B', 'var') && exist('P', 'var')
            if ~isnumeric(B)
                err = [err "Output matrix A is not numeric.  "]; em = 1;
            end
            if diff(size(B))
                err = [err "Output matrix A is not square.  "]; em = 1;
            end
            if size(B, 1) ~= n(i)
                err = [err sprintf("Output matrix A has wrong dimension (dim(A) == %d).  ", size(B, 1))]; em = 1;
            end
            if ~isnumeric(P)
                err = [err "output matrix P is not numeric.  "]; em = 1;
            end
            if size(P, 1) ~= n(i)
                err = [err sprintf("Output matrix P has wrong dimension (dim(P) == %d).  ", size(P, 1))]; em = 1;
            end
            if ~isequal(P * P', eye(size(P, 1)))
                err = [err "Output matrix P is not orthonormal.  "]; em = 1;
            end
        end
        if em
            obj.plu = 0; r__ = 0; obj.submission(obj.submissionNr).ctx.addText(["Error in function PLU.  " err]);
        end
    else
        r__ = 0;
    end
   
    assert(n(i) == n_ref);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %  accuracy.m (matrix input)  %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		
    if obj.accuracy
        
        A = rand(n(i));
        [B, P] = lu(A);
        X = transpose(P)*(tril(B,-1) + eye(n_ref))*triu(B);
        
        em = 0;
        err = '';
				
        try
            rres = accuracy(X, A);
        catch ME
						em = 1;
        end
        
        if exist('rres', 'var')
            
            if ~isscalar(rres)
                err = [err "Residual is not a scalar.  "]; em = 1;
            end
            if ~isnumeric(rres)
                err = [err "Residual has wrong type.  "]; em = 1;
            end
        end
        
        if em
            obj.accuracy = 0; r__ = 0; obj.submission(obj.submissionNr).ctx.addText(["Error in function ACCURACY.  " err]);
        end
    else
        r__ = 0;
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %  accuracy.m (vector input)  %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    if obj.accuracy
        
        x = rand(n(i), 1);
        y = rand(n(i), 1);
				
        em = 0;
        err = '';
				
        try
            rres = accuracy(X, A);
        catch ME
						em = 1;
        end
        
        if exist('rres', 'var')
            
            if ~isscalar(rres)
                err = [err "Residual is not a scalar.  "]; em = 1;
            end
            if ~isnumeric(rres)
                err = [err "Residual has wrong type.  "]; em = 1;
            end
        end
        
        if em
            obj.accuracy = 0; r__ = 0; obj.submission(obj.submissionNr).ctx.addText(["Error in function ACCURACY.  " err]);
        end
    else
        r__ = 0;
    end        


    %%%%%%%%%%%%%%
    %  solveL.m  %
    %%%%%%%%%%%%%%
    
    if obj.solveL
        
        ty = ones(n(i), 1);
        L = tril(rand(n(i)));
        b = L*ty;
        
        em = 0;
				err = '';

        try
            y = solveL(L, b, n(i));
        catch ME
						em = 1;
        end
        
        if exist('y', 'var')
            if ~isnumeric(y)
                err = [err "Output vector is not numeric.  "]; em = 1;
            end
            if length(y) ~= n(i)
                err = [err sprintf("Output vector has wrong dimension (dim(x) == %i), n == %i.  ", length(y), n_ref)]; em = 1;
            end
        end
        if em
            obj.solveL = 0; r__ = 0; obj.submission(obj.submissionNr).ctx.addText(["Error in function SOLVEL.  " err]);
        end
    else
        r__ = 0;
    end
   
    assert(n(i) == n_ref);
    
    %%%%%%%%%%%%%%
    %  solveU.m	 %
    %%%%%%%%%%%%%%
    
    if obj.solveU
        
        tx = ones(n(i), 1);
        U = triu(rand(n(i)));
        y = U*tx;
        
        em = 0;
				err = '';

        try
            x = solveU(U, y, n(i));
        catch ME
            em = 1;
        end
        
        if exist('x', 'var')
            if ~isnumeric(x)
                err = [err "Output vector is not numeric.  "]; em = 1;
            end
            if length(x) ~= n(i)
                err = [err sprintf("Output vector has wrong dimension (dim(x) == %i), n == %i.  ", length(x), n_ref)]; em = 1;
            end
        end
        
        if em
            obj.solveU = 0; r__ = 0; obj.submission(obj.submissionNr).ctx.addText(["Error in function SOLVEU.  " err]);
        end
    else
        r__ = 0;
    end
		
    %%%%%%%%%%%%%%%%
    %  linSolve.m  %
    %%%%%%%%%%%%%%%%
    
    if obj.linSolve && ~(obj.plu && obj.solveL && obj.solveU)
        r__ = 0; obj.linSolve = 0; obj.submission(obj.submissionNr).ctx.addText("Error in function LINSOLVE.  Required routines missing/not working.  ");
    end
    
    if obj.linSolve
        
        tx = 2*ones(n(i),1);
        b = A*tx;
        
        em = 0;
        err = '';
						
        try
            x = linSolve(A, b, n(i));
        catch ME
						em = 1;
        end
        
        if exist('x', 'var')
            if ~isnumeric(x)
                err = [err "Output vector is not numeric.  "]; em = 1;
            end
            if length(x) ~= n(i)
                err = [err "Output vector has wrong dimension.  "]; em = 1;
            end
        end
        
        if em
            obj.linSolve = 0; r__ = 0; obj.submission(obj.submissionNr).ctx.addText(["Error in function LINSOLVE.  " err]);
        end
    else
        r__ = 0;
    end
    
    assert(n(i) == n_ref);
		
		r = r__;
		
		if r__ == 0
			break;
		endif
    
		munlock;
	endfor

end