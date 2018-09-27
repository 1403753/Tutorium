n = [10:10:1000];

r = zeros(length(n), 1); % preallocation
t = zeros(length(n), 1); % preallocation

for k = 1:length(n)
    A = rand(n(k));
    [R(k), T(k)] = ref_pluStats(A, n(k));
end

semilogy (n, R)
xlabel('n');
ylabel('rel. res.');
legend('relative residual');
xlim([min(n) max(n)]);

figure;
semilogy (n, T)
xlabel('n');
ylabel('t');
legend('runtime');
xlim([min(n) max(n)]);
