function evalRoutines(obj)

    %%%%%%%%%%%
    %  plu.m  %
    %%%%%%%%%%%
    
    if obj.plu

        [B, P] = plu(obj.A, obj.n);
				
				L = tril(B, -1) + eye(obj.n);
				U = triu(B);
				X = P'*L*U;
				
        if obj.accuracy
					obj.submission(obj.submissionNr).R = accuracy(X, obj.A);
				else
					obj.submission(obj.submissionNr).R = norm(X - obj.A, 1) / norm(obj.A, 1);
				end
    end

		%%%%%%%%%%%%%%
		%  solveL.m  %
		%%%%%%%%%%%%%%

		if obj.solveL
						
			ty = 2*ones(obj.n, 1);
      [L, U, P] = lu(obj.A);
			B = (L - eye(obj.n)) + U;
			b = L*ty;
			
			y = solveL(B, b, obj.n);
			
			if obj.accuracy
				obj.submission(obj.submissionNr).rn_L = accuracy(L*y, b); 
				obj.submission(obj.submissionNr).foe_L = accuracy(y, ty);				
			else
				obj.submission(obj.submissionNr).rn_L = norm(L*y - b, 1) / norm(b, 1);
				obj.submission(obj.submissionNr).foe_L = norm(y - ty, 1) / norm(ty, 1);
			end
    end
		
    %%%%%%%%%%%%%%
    %  solveU.m  %
    %%%%%%%%%%%%%%
		
		if obj.solveU

			tx = 2*ones(obj.n, 1);
			[L, U, P] = lu(rand(obj.n));
      B = (L - eye(obj.n)) + U;
			y = U*tx;
			x = solveU(B, y, obj.n);

			if obj.accuracy
				obj.submission(obj.submissionNr).rn_U = accuracy(U*x, y);
				obj.submission(obj.submissionNr).foe_U = accuracy(x, tx);
			else
				obj.submission(obj.submissionNr).rn_U = norm(U*x - y, 1) / norm(y, 1);
				obj.submission(obj.submissionNr).foe_U = norm(x - tx, 1) / norm(tx, 1);
			end
		end

		if obj.linSolve
			
			tx = 2*ones(obj.n, 1);
			
		  b = obj.A * tx;
			x = linSolve(obj.A, b, obj.n);
			
			if obj.accuracy
				obj.submission(obj.submissionNr).rn_linSol = accuracy(obj.A*x, b);
				obj.submission(obj.submissionNr).foe_linSol = accuracy(x, tx);				
			else
				obj.submission(obj.submissionNr).rn_linSol = norm(obj.A*x - b, 1) / norm(b, 1);
				obj.submission(obj.submissionNr).foe_linSol = norm(x - tx, 1) / norm(tx, 1);
			end
		end
end