function [lambda,v,it,erreval,errres] = ref_invit(n, A, x0, sigma, eps, maxit, l) 
	% Input  - A: nxn matrix
	%        - x0: nx1 starting vector
	%        - l: the true eigenvalue
	%        - sigma: the shift 
	%        - eps: error tolerance
	%        - maxit: maximum number of iterations
	% Output - lambda: the dominant eigenvalue
	%        - v: the dominant eigenvector
	%        - it: the current iteration-number
	%        - errres: itx1 vector, contains the history of the relative residuals
	%        - erreval: itx1 vector, contains the history of the relative eigenvalue approximation errors
	% initialize (A - sigma*I) and paramteres
	it = 0;
	err = eps + 1;
  errres=zeros(maxit,1);
  As = A;
	A = A - sigma*eye(n);
	lambda = 0;

  x = x0 / norm(x0,2);
  
	while ((it < maxit) && (err > eps))
		% solve AY = X
		y = A\x;
		% normalize Y
		c1 = max(abs(y));
		dc = abs(lambda - c1);
		y = (1/c1)*y;
		% update X and lambda and check for convergence
		dv = norm(x-y);
		% err = max(dc,dv);
		x = y;
		err = norm(As*x - (sigma + 1/c1)*x);
		lambda = c1;
 		it = it + 1;
    errres(it) = err;
	end
  errres=errres(1:it);
	lambda = sigma + 1/c1;
	v = x;
  erreval = [];
end