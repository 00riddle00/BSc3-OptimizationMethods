function PenaltyMethod

% tikslo funkcija
f = @(X) -X(1) .* X(2) .* X(3);

% apribojimu funkcijos
g = @(X) 2*X(1) .* X(2)+2*X(1) .* X(3) +2*X(2) .* X(3) - 1;

h1 = @(X) -X(1);
h2 = @(X) -X(2);
h3 = @(X) -X(3);

% kvadratine baudos funkcija su apribojimais
b = @(X) (g(X)).^2 + max(0,h1(X)).^2 + max(0,h2(X)).^2 + max(0,h3(X)).^2;

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
X0 = X_0;

% pasirenkamas pradinis baudos daugiklis
r = 1;

% tikslumas
epsilon = 10 ^ (-4); 

k = 1; % iteraciju skaitliukas (pradinio simplekso sudarymas = 1 iteracija)
i = 0; % funkcijos kvietimu skaiciaus skaitliukas
kmax = 100; % maksimalus iteraciju skaicius
imax = 100; % maksimalus funkcijos kvietimu skaicius

format short;

% Metodo realizavimas
disp(['   x1  x2  x3   f(X) B(x,r)   k    (f kv. sk.)']);
disp('-----------------------------------------------');

norma = Inf;


while norma >= epsilon
  
    res=Simplex(B,X0,r);
    % naujas artinys
    X1 = res(1:3);
    norma = norm(X0-X1);
    % sekame funkciju kvietimu skaiciu
    i = i + res(4) + 1;
    
    fprintf('%f %f %f %d %d %d %d\n', X1, f(X1), B(X1,r), k, i);
    
    % maziname r
    r = Fn_decrease_r(r);
    X0 = X1;
    k = k+1;
    
endwhile
disp("pabaiga");
endfunction