n = 10:10:1000;

rn = zeros(length(n), 1); % preallocation
foe = zeros(length(n), 1); % preallocation
fae = zeros(length(n), 1); % preallocation
t = zeros(length(n), 1); % preallocation
urn = zeros(length(n), 1); % preallocation
ufoe = zeros(length(n), 1); % preallocation
ufae = zeros(length(n), 1); % preallocation
ut = zeros(length(n), 1); % preallocation

for k = 1:length(n)
    A = rand(n(k));
    [rn(k), foe(k), fae(k), t(k)] = ref_pluStats(A, n(k));
    [urn(k), ufoe(k), ufae(k), ut(k)] = ref_upluStats(A, n(k));
end

% blocked lu
figure;
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

% unblocked lu
figure;
semilogy (n, urn)
xlabel('n');
ylabel('urel. res.');
legend('urelative residual');
xlim([min(n) max(n)]);

figure;
semilogy (n, ut)
xlabel('n');
ylabel('ut');
legend('runtime');
xlim([min(n) max(n)]);

figure;
semilogy (n, ufoe)
xlabel('n');
ylabel('ufoe');
legend('ufoe');
xlim([min(n) max(n)]);

figure;
semilogy (n, ufae)
xlabel('n');
ylabel('ufae');
legend('ufae');
xlim([min(n) max(n)]);
