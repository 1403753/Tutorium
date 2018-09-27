clear all;
n = [2:1:9 10:5:45 50:10:200];

for k = 1:length(n)
  tx = 1*ones(n(k), 1);

	S = -1 + (1+1)*rand(n(k));
	b = S*tx;
	x = linSolve(S, b, n(k));
	
	f(k) = accuracy(S*x, b);	
	r(k) = accuracy(x, tx);
  
	H = zeros(n(k));
			
	for i = 1:n(k)
		for j = 1:n(k)
			H(i,j) = 1 / (i+j-1);
		end
    end
    
    b = H*tx;
	x = linSolve(H, b, n(k));
	f2(k) = accuracy(H*x, b);
    r2(k) = accuracy(x, tx);	
end

set(gca, 'YScale', 'log');
hold on;
semilogy(n, f);
semilogy(n, r);
xlabel('n');
ylabel('rel. fwd. err./rel. res.');
legend('relative forward error', 'relative residual');
hold off;

figure;
set(gca, 'YScale', 'log');
hold on;
semilogy(n, f2);
semilogy(n, r2);
xlabel('n');
ylabel('rel. fwd. err./rel. res.');
legend('relative forward error', 'relative residual');
hold off;

clear;