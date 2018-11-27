function [r, msg] = checkInterfacePart1(obj)
    mlock
    
    persistent r__
    persistent n_ref
    
    n = 5;
    assert (n >= 2);
    assert ((~isinf(n) && floor(n) == n) || n > 1);
    
    n_ref = n;
    r__ = 1;
    msg = '';
    
    assert(n == n_ref);
    
		T = rand(n);
    D = diag(list_primes(n));
		A = inv(T)*D*T;
		x0 = rand(n,1);
		sigma = 35;
		eps = 1e-10;
		maxit = 100;
		l = eig(A)(1);
		
    %%%%%%%%%%%%%
    %  invit.m  %
    %%%%%%%%%%%%%
    
    if obj.invit
        em = 0;
        obj.ctx(obj.partNr).addText('    - try ''invit.m'' ..');
        
        try
            [lambda, V, it, erreval, errres] = invit(n, A, x0, sigma, eps, maxit, l);
            obj.ctx(obj.partNr).addText(' ok\n');
        catch ME
            msg = ' INVIT.M ! error in function';
            obj.ctx(obj.partNr).addText(' failed\n\n'), em = 1;
            obj.ctx(obj.partNr).addErrMsg(ME);
        end
        
				if exist('lambda', 'var') && exist('V', 'var') && exist('it', 'var') && exist('erreval', 'var') && exist('errres', 'var')
					err = '';
					try
						validateattributes(lambda,{'double'},{'size', [1,1], 'scalar'});
					catch ME
						err = [err ME.message]; em = 1;
					end
					try
						validateattributes(V,{'double'},{'size', [n,1], '2d'});
					catch ME
						err = [err ME.message]; em = 1;
					end
					try
						validateattributes(it,{'double'},{'size', [1,1], 'positive', 'integer', 'scalar'});
					catch ME
						err = [err ME.message]; em = 1;
					end
					try
						validateattributes(erreval,{'double'},{'size', [it,1], '2d'});
					catch ME
						err = [err ME.message]; em = 1;
					end
					try	
						validateattributes(errres,{'double'},{'size', [it,1], '2d'});
					catch ME
						err = [err ME.message]; em = 1;
					end
					clear lambda V it erreval errres;
				end
				if em
            obj.invit = 0; r__ = 0;
        end
        
    assert(n == n_ref);
    
    %%%%%%%%%%%%
    %  rqi.m  %
    %%%%%%%%%%%%
		


 		T = rand(n);
    D = diag(list_primes(n));
		A = inv(T)*D*T;
		x0 = rand(n,1);
		sigma = 35;
		eps = 1e-10;
		maxit = 100;
		l = eig(A)(1);		
		
    if obj.rqi
        em = 0;
        obj.ctx(obj.partNr).addText('    - try ''rqi.m'' ..');
        
        try
            [lambda, V, it, erreval, errres] = rqi(n, A, x0, sigma, eps, maxit, l);
            obj.ctx(obj.partNr).addText(' ok\n');
        catch ME
            msg = ' RQI.M ! error in function';
            obj.ctx(obj.partNr).addText(' failed\n\n'), em = 1;
            obj.ctx(obj.partNr).addErrMsg(ME);
        end
        
				if exist('lambda', 'var') && exist('V', 'var') && exist('it', 'var') && exist('erreval', 'var') && exist('errres', 'var')
					err = '';
					try
						validateattributes(lambda,{'double'},{'size', [1,1], 'scalar'});
					catch ME
						err = [err ME.message]; em = 1;
					end
					try
						validateattributes(V,{'double'},{'size', [n,1], '2d'});
					catch ME
						err = [err ME.message]; em = 1;
					end
					try
						validateattributes(it,{'double'},{'size', [1,1], 'positive', 'integer', 'scalar'});
					catch ME
						err = [err ME.message]; em = 1;
					end
					try
						validateattributes(erreval,{'double'},{'size', [it,1], '2d'});
					catch ME
						err = [err ME.message]; em = 1;
					end
					try	
						validateattributes(errres,{'double'},{'size', [it,1], '2d'});
					catch ME
						err = [err ME.message]; em = 1;
					end
					clear lambda V it erreval errres;
				end
				if em
            obj.rqi = 0; r__ = 0;
        end
    else
        r__ = 0;
    end
    
    assert(n == n_ref);
    
    %%%%%%%%%%%%%
    %  rqi_k.m  %
    %%%%%%%%%%%%%
		

 		T = rand(n);
    D = diag(list_primes(n));
		A = inv(T)*D*T;
		x0 = rand(n,1);
		sigma = 35;
		eps = 1e-10;
		maxit = 100;
		l = eig(A)(1);
    k = 3;
		
    if obj.rqi_k
        em = 0;
        obj.ctx(obj.partNr).addText('    - try ''rqi_k.m'' ..');
        
        try
            [lambda, V, it, erreval, errres] = rqi_k(n, A, x0, sigma, eps, maxit, l, k);
            obj.ctx(obj.partNr).addText(' ok\n');
        catch ME
            msg = ' RQI_K.M ! error in function';
            obj.ctx(obj.partNr).addText(' failed\n\n'), em = 1;
            obj.ctx(obj.partNr).addErrMsg(ME);
        end
        
				if exist('lambda', 'var') && exist('V', 'var') && exist('it', 'var') && exist('erreval', 'var') && exist('errres', 'var')
					err = '';
					try
						validateattributes(lambda,{'double'},{'size', [1,1], 'scalar'});
					catch ME
						err = [err ME.message]; em = 1;
					end
					try
						validateattributes(V,{'double'},{'size', [n,1], '2d'});
					catch ME
						err = [err ME.message]; em = 1;
					end
					try
						validateattributes(it,{'double'},{'size', [1,1], 'positive', 'integer', 'scalar'});
					catch ME
						err = [err ME.message]; em = 1;
					end
					try
						validateattributes(erreval,{'double'},{'size', [it,1], '2d'});
					catch ME
						err = [err ME.message]; em = 1;
					end
					try	
						validateattributes(errres,{'double'},{'size', [it,1], '2d'});
					catch ME
						err = [err ME.message]; em = 1;
					end
					clear lambda V it erreval errres k;
				end
				if em
            obj.rqi_k = 0; r__ = 0;
        end
    else
        r__ = 0;
    end
    
    assert(n == n_ref);

    
    %%%%%%%%%%%%%%%%%%%
    %  assignment2.m  %
    %%%%%%%%%%%%%%%%%%%
    
    if HWXX.CONST.TESTSCRIPTS
        
        obj.ctx(obj.partNr).addText('    - try ''assignment2.m'' ..');
        
        fTemp = fopen('temp.txt', 'w');
        msg	= [msg '  -''assignment2.m'' ..'];
        
        fprintf(fTemp, msg);
        fclose(fTemp);
        try
            assignment2
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
        msg = [msg ' couldn''t test assignment2, ''clear'' command used?'];
    else
        r = r__;
    end
    munlock;
end