function [lambda, V, it, erreval, errres] = ref_rqi(n, A, x0, sigma, eps, maxit, l)
  errres=zeros(maxit,1);
  A = (A - sigma * eye(n));
	x = x0 / norm(x0);
  y = A\x;
  lambda = y' * x;
  sigma = sigma + 1 / lambda;
  err = norm(y - lambda * x) / norm(y);
  it = 1;

  while ((it < maxit) && (err > eps))
    x = y / norm(y);
    y = (A - sigma * eye(n))\x;
    lambda = y' * x;
    sigma = sigma + 1 / lambda;
    err = norm(y - lambda * x) / norm(y);
    errres(it) = err;
    it = it + 1;
  end
	lambda = sigma;
	V = x;
  it = it - 1;
  errres = errres(1:it);
	erreval = [];
end