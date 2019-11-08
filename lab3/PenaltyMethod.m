function PenaltyMethod

% tikslo funkcija
f = @(X) -X(1) .* X(2) .* X(3);

% apribojimu funkcijos
g = @(X) 2*X(1) .* X(2)+2*X(1) .* X(3) +2*X(2) .* X(3) - 1;

h1 = @(X) -X(1);
h2 = @(X) -X(2);
h3 = @(X) -X(3);

% kvadratine baudos funkcija su apribojimais
b = @(X) (g(X)).^2 + max(0,h1(X)) + max(0,h2(X)) + max(0,h3(X));

% kvadratine baudos funkcija, apimanti tikslo funkcija ir apribojimus
B = @(X,r) f(X) + (1/r) * b(X);

% pasirenkame, kaip maziname parametra r kiekviena iteracija
Fn_decrease_r = @(r) r/2;

% pradiniai artiniai
X_0 = [0, 0, 0];
X_1 = [1, 1, 1];
X_m = [1/10, 4/10, 7/10];

% pasirenkamas pradinis artinys
X_n = [1/2, 1/2, 1/2];
X0 = X_n;

% pasirenkamas pradinis baudos daugiklis
r = 1;

% tikslumas
epsilon = 10 ^ (-6); 

k = 1; % iteraciju skaitliukas (pradinio simplekso sudarymas = 1 iteracija)
i = 0; % funkcijos kvietimu skaiciaus skaitliukas
kmax = 100; % maksimalus iteraciju skaicius
imax = 100; % maksimalus funkcijos kvietimu skaicius

format short;

% Metodo realizavimas
disp(['   x1  x2  x3   f(X)    k    (f kv. sk.)']);
disp('-----------------------------------------------');

norma = Inf;

fn = @(X) (1 / 8) * ((X(1) .^ 2) .* X(2) + X(1) .* (X(2) .^ 2) - X(1) .* X(2));

fn=Simplex(fn,X0);
