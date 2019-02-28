n = [10:10:1000];

R = zeros(length(n),1); % preallocation
for idx = 1:length(n)
    A = rand(n(idx));
    [B, P] = ref_plu(A, n(idx));
    X = transpose(P)*(tril(B,-1)+eye(n(idx)))*triu(B);
    R(idx) = ref_accuracy(X, A);
end

p1 = semilogy (n, R);
xlabel('n');
ylabel('rel. res.');
legend('relative residual');
xlim([min(n) max(n)]);
% saveas(p1, 'ref_plot.png');
