function [A, P] = ref_plu(A, n)
		% validateattributes();
    pvec = [1:n]';
		for k = 1:n-1
			[~, p] = max(abs(A(k:n,k)));
      p = p+k-1;
			if p ~= k
				A([k p],:) = A([p k],:);
        pvec([k p]) = pvec([p k]);
			endif
		  if A(k,k) == 0
        k = k + 1;
      endif
      iDiag = 1 / A(k,k);
      A(k+1:n,k) = A(k+1:n,k)*iDiag;
      A(k+1:n,k+1:n) = A(k+1:n, k+1:n) - A(k+1:n,k)*A(k,k+1:n);
      P = eye(n)(pvec,:);
    endfor
end