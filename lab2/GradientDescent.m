function GradientDescent

f = @(x1, x2) (1 / 8) * ((x1 .^ 2) .* x2 + x1 .* (x2 .^ 2) - x1 .* x2);
% ieskome min(f(x1, x2))

gradf = @(X) [2 * X(1) * X(2) + X(2) .^ 2 - X(2), X(1) ^ 2 + 2 * X(1) * X(2) - X(1)];

% pradiniai artiniai
X_0 = [0, 0];
X_1 = [1, 1];
X_m = [4 / 10, 7 / 10];
X_n = [1 / 2, 1 / 2];

% pasirenkamas pradinis artinys
X0 = X_1;

% Funkcijos grafiko y=f(x1,x2) braizymas
subplot(1, 2, 1);
[x1, x2] = meshgrid(0:0.01:1, 0:0.01:1);
y = f(x1, x2);
surf(x1, x2, y);
title(['Funkcijos y=f(x1,x2) grafikas']);

% pasirenkamas parametras
gamma = 0.33;

epsilon = 10 ^ (- 4); % tikslumas

k = 1; % iteraciju skaitliukas
kmax = 100; % maksimalus iteraciju skaitliukas

% Metodo realizavimas

disp(['x1       x2       f(x1,x2)  k (funkc. kviet. sk)']);

format long;

norma = Inf;

while norma >= epsilon
 
    grad = gradf(X0);
    X0 = X0 - gamma .* grad; % naujas artinys
    norma = norm(grad);
 
     fprintf('%f %f %f %d %d\n', X0, f(X0(1), X0(2)), k, k);
 
    subplot(1, 2, 2);
    title(['Artiniai (pradinis taškas: X1)']);
    plot(X0(1), X0(2), 'mo');
    hold on;
 
    if k == kmax
        format short;
        disp(['Pasiektas maksimalus iteraciju skaicius k=', num2str(kmax)]);
        break
    endif
    k = k + 1;
 
endwhile
grid on;
hold off;
endprogram