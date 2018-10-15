n = 10:10:1000;

rn = zeros(length(n), 1); % preallocation
foe = zeros(length(n), 1); % preallocation
fae = zeros(length(n), 1); % preallocation
t = zeros(length(n), 1); % preallocation

for k = 1:length(n)
    A = rand(n(k));
    [rn(k), foe(k), fae(k), t(k)] = ref_pluStats(A, n(k));
end

semilogy (n, rn)
xlabel('n');
ylabel('rel. res.');
legend('relative residual');
xlim([min(n) max(n)]);

figure;
semilogy (n, t)
xlabel('n');
ylabel('t');
legend('runtime');
xlim([min(n) max(n)]);

figure;
semilogy (n, foe)
xlabel('n');
ylabel('foe');
legend('foe');
xlim([min(n) max(n)]);

figure;
semilogy (n, fae)
xlabel('n');
ylabel('fae');
legend('fae');
xlim([min(n) max(n)]);
