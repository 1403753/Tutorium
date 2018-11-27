clear all;

n = 5;

%{
T = rand(n);
dlmwrite('T.txt', T, 'precision', '%.20e');
%}

D = sparse(diag(list_primes(n)));
%T = dlmread('T.txt');
T = rand(n);
Ti = inv(T);
A = Ti*D*T;
l = D(5,5);
sigma = l - 9.96e-1;
eps = 1e-16;
maxit = 100;
x0 = rand(n,1);
[ref_lambda, ref_V, ref_it, ref_errhist] = ref_invit(n, A, x0, sigma, eps, maxit, l);
[lambda, V, it, erreval, errres] = invit(n, A, x0, sigma, eps, maxit, l);
try
validateattributes(errres,{'double'},{'size', [it, 12], '2d'});
catch EM
EM.message
end
format short E

abs(ref_lambda - lambda) / ref_lambda

ref_V = ref_V / norm(ref_V);
V = V / norm(V);

norm(abs(ref_V) - abs(V))


format short

%{
X = rand(n,1);
sigma = eig(A);
sigma = sigma(2) - 40.05;
maxit = 1000;
eps = 1e-4;
[EVEC, EVAL] = eigs(A);
tX = EVEC(2,:);

k = 5;

[lambda, V, it, errhist] = ref_rqi_k(A, X, tX, n, k, sigma, eps, maxit)
% [lambda, V, it, errhist] = ref_rqi(A, X, tX, n, sigma, eps, maxit)
% [lambda, V, it, errhist] = ref_invit(A, X, tX, n, sigma, eps, maxit) 
eig(A)
%}