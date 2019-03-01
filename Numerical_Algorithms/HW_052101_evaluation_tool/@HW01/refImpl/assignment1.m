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

n = [10 100 1000];

for k = 1:length(n)
    
    %%%%%%%%%%%%%%
    %  solveL.m  %
    %%%%%%%%%%%%%%
    
    B = rand(n(k));
    
    ty = ones(n(k), 1);
    
    L = tril(B, -1) + eye(n(k));
    b = L*ty;
    
    y1 = ref_solveL(B, b, n(k));
    
    lr = ref_accuracy(L*y1, b);
    lf = ref_accuracy(y1, ty);
    
    %%%%%%%%%%%%%%
    %  solveU.m  %
    %%%%%%%%%%%%%%
    
    tx = ones(n(k), 1);
    
    U = triu(B);
    y = U*tx;
    
    x = ref_solveU(B, y, n(k));
    
    ur = ref_accuracy(U*x, y);
    uf = ref_accuracy(x, tx);
    
end

n = [2:9 10:5:95 100:10:1000];

r = zeros(length(n), 1);
f = zeros(length(n), 1);
f2 = zeros(length(n), 1);
r2 = zeros(length(n), 1);


for k = 1:length(n)
    tx = 1*ones(n(k), 1);
    
    S = -1 + (1+1)*rand(n(k));
    b = S*tx;
    x = ref_linSolve(S, b, n(k));
    
    f(k) = ref_accuracy(S*x, b);
    r(k) = ref_accuracy(x, tx);
    
    H = zeros(n(k));
    
    for i = 1:n(k)
        for j = 1:n(k)
            H(i,j) = 1 / (i+j-1);
        end
    end
    
    b = H*tx;
    x = ref_linSolve(H, b, n(k));
    f2(k) = ref_accuracy(H*x, b);
    r2(k) = ref_accuracy(x, tx);
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

pause(10);
close all;

clear;
