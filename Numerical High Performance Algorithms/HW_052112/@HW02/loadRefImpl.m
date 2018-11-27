function loadRefImpl(obj)
    obj.loadTestInput(HWXX.CONST.INPUTFNAME);
		% obj.n = 19;
		% obj.T = rand(obj.n);
		obj.Ti = inv(obj.T);
		obj.D = sparse(diag(list_primes(obj.n)));
		obj.A = obj.Ti*obj.D*obj.T;
		obj.x0 = rand(obj.n,1);
		obj.eps = 1e-16;
		obj.maxit = 500;
		obj.l = obj.D(5,5);
		obj.sigma = obj.l - 9e-1
		obj.k = 3;
		
    oldDir = pwd;
    cd(HWXX.CONST.REFIMPLDIR);
    
    %%%%%%%%%%%%%%%%%
    %  assinment 2  %
    %%%%%%%%%%%%%%%%%

		[obj.lambda, obj.V, obj.it, obj.erreval, obj.errres] = ref_invit(obj.n, obj.A, obj.x0, obj.sigma, obj.eps, obj.maxit, obj.l);
    obj.V = obj.V / norm(obj.V);
		
    cd(oldDir);
end