function [lambda,v,it,erreval,errres] = ref_rqi_k(n,A,x_0,sigma,eps,maxit,l,k)
  validateattributes(n,{'double'},{'size', [1,1],'positive','integer'});
  validateattributes(A,{'double'},{'size', [n,n]});
  validateattributes(x_0,{'double'},{'size', [n,1]});
  validateattributes(sigma,{'double'},{'size', [1,1]});
  validateattributes(eps,{'double'},{'size', [1,1]});
  validateattributes(maxit,{'double'},{'size', [1,1],'positive','integer'});
  validateattributes(l,{'double'},{'size', [1,1]});
  validateattributes(l,{'double'},{'size', [1,1],'positive','integer'});
  
  it=0;
  errres=zeros(maxit,1);
  erreval=zeros(maxit,1);
  
  n=size(A,1);
  A_shift=A-sigma*eye(n);
  [L,U,P]=lu(A_shift);
  
  v=v_prev=x_0/norm(x_0,2);
  errres(it+1) = 1 + eps;
  
  while (errres(it+1) > eps && it < maxit)
    if (mod(it,k)==1)
      A_shift=A-sigma*eye(n);
			if (rcond(A_shift)<10^-16)
				break;
			end
			[L,U,P]=lu(A_shift);
    end
		++it;
		v=L\(P*v);
		v=U\v;
		[v_max,i_max]=max(abs(v));
		d=1/v(i_max);
    v=v*d;
		Av=A*v;
		sigma=(v'*Av)/(v'*v);
		lambda=sigma;
	
		erreval(it + 1) = abs(lambda-l) / abs(l);
    errres(it + 1) = norm(Av - lambda*v, 2);
  end
  
  v=v/norm(v,2);
  errres=errres(1:it);
  erreval=erreval(1:it);

end