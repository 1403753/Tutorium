n = 10:10:100;
rRes = zeros(length(n),1);
for k = 1:length(n)
    A = rand(n(k));
    [B P] = plu(A, n(k));
    X = transpose(P)*(tril(B,-1)+eye(n(k)))*triu(B);
    R(k) = accuracy(X, A);
end

p1 = semilogy (n, R);
xlabel('n');
ylabel('rel. res.');
legend('relative residual');
xlim([min(n) max(n)]);
% saveas(p1, 'ref_plot.png');
