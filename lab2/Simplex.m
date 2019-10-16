function Simplex

f = @(X) (1 / 8) * ((X(1) .^ 2) .* X(2) + X(1) .* (X(2) .^ 2) - X(1) .* X(2));
% pradiniai artiniai
X_0 = [0, 0];
X_1 = [1, 1];
X_m = [4 / 10, 7 / 10];
X_n = [1 / 2, 1 / 2];

% pasirenkamas pradinis artinys
X0 = X_1;

% pasirenkami parametrai
gamma = 2;
beta = 0.5;
eta = - 0.5;
teta = 1;

epsilon = 10 ^ (- 4); % tikslumas

% Pradinio simplekso sudarymas
alpha = 1 / 2; % reguliuoja simplekso krastines ilgi
n = 2; % keliu kintamuju funkcija yra minimizuojama
delta1 = alpha * (sqrt(n + 1) + n - 1) / (n * sqrt(2));
delta2 = alpha * (sqrt(n + 1) - 1) / (n * sqrt(2));

% kitos simplekso virsunes
X1 = [X0(1, 1) + delta2, X0(1, 2) + delta1];
X2 = [X0(1, 1) + delta1, X0(1, 2) + delta2];

% funkcijos reiksmes simplekso virsunese
y0 = f(X0);
y1 = f(X1);
y2 = f(X2);

% simplekso virsuniu masyvas
X = [X0; X1; X2];

% funkcijos reiksmiu simplekso virsunese masyvas
y = [y0, y1, y2];

% Pradinio simplekso braizymas:
deltax = [X0(1), X0(1), X1(1); X1(1), X2(1), X2(1)];
deltay = [X0(2), X0(2), X1(2); X1(2), X2(2), X2(2)];
plot(deltax, deltay, 'b');
grid on;
hold on;
plot(X(:, 1), X(:, 2), 'mo'); % atvaizduoja bandymo taskus rutuliukais
hold on;

k = 1; % iteraciju skaitliukas (pradinio simplekso sudarymas = 1 iteracija)
i = 3; % funkcijos kvietimu skaiciaus skaitliukas
kmax = 100; % maksimalus iteraciju skaicius
imax = 100; % maksimalus funkcijos kvietimu skaicius

format short;

% Metodo realizavimas
disp(['   x1   x2    f(x1,x2)    k    (f kv. sk.)']);
disp('-----------------------------------------------');

goal = false;
while ~ goal
    % Randami Xh, Xg, Xl ir funkcijos reiksmes siuose taskuose yh, yg, yl
    [~, nr] = sort(y); % y0, y1, y2 reiksmes isdestomos didejimo tvarka; nr rodys ju numerius masyve y
 
    yl = y(nr(1)); % maziausia y reiksme
    Xl = X(nr(1), :);
 
    yh = y(nr(n + 1)); % didziausia y reiksme
    Xh = X(nr(n + 1), :);
 
    yg = y(nr(n)); % antra pagal dydi y reiksme
    Xg = X(nr(n), :);
 
    % Viduriu tasko Xc ir naujo artinio Xnew apskaiciavimas
    Xc = (Xg + Xl) / 2;
 
    Xnew = Xh + (1 + teta) * (Xc - Xh);
    ynew = f(Xnew);
    i = i + 1;
 
    % Jei bent viena neigiama koordinate, keiciame krypti
    if Xnew(1) <= 0 || Xnew(2) <= 0
        disp('Neigiama artinio koordinate! Keiciame krypti.');
        teta = - 1 / 2;
        Xnew = Xh + (1 + teta) * (Xc - Xh);
        ynew = f(Xnew);
        i = i + 1;
    endif
 
    % Naujo simplekso sudarymas
    if (yl < ynew) && (ynew < yg)
        teta = 1;
    elseif ynew < yl
        teta = gamma;
        Z = Xh + (1 + teta) * (Xc - Xh);
        yz = f(Z);
        i = i + 1;
        if yz < ynew
            ynew = yz;
            Xnew = Z;
        endif
    elseif ynew > yh
        teta = eta;
        Z = Xh + (1 + teta) * (Xc - Xh);
        Xnew = Z;
        ynew = f(Z);
        i = i + 1;
    elseif (yg < ynew) && (ynew < yh)
        teta = beta;
        Z = Xh + (1 + teta) * (Xc - Xh);
        Xnew = Z;
        ynew = f(Z);
        i = i + 1;
    endif
 
    if Xnew(1) <= 0 || Xnew(2) <= 0
        disp('Neigiama artinio koordinate! Keiciame krypti.');
        teta = - 1 / 2;
        Xnew = Xh + (1 + teta) * (Xc - Xh);
        ynew = f(Xnew);
        i = i + 1;
    endif
 
     fprintf('%f    %f   %f %d   %d', Xnew, ynew, k, i);
 
    count = 0;
 
    if max([norm(Xl - Xg), norm(Xl - Xh), norm(Xg - Xh)]) < epsilon
        disp(' ')
        disp(['Simpleksas tapo mazas (krastiniu ilgiai mazesni uz epsilon=', num2str(epsilon), ')']);
        count = count + 1;
    endif
 
    if max([abs(yl - yg), abs(yl - yh), abs(yg - yh)]) < epsilon
        disp(' ')
        disp(['Funkcijos reiksmes simplekso virsunese panasios (tikslumu epsilon=', num2str(epsilon), ')']);
        count = count + 1;
    endif
 
    if i >= imax
        count = count + 1;
        if count == 3
            disp(' ');
            disp('Patenkinamos sustojimo salygos. Skaiciavimai baigiami, nes:');
            disp(['1) simpleksas tapo mazas (krastiniu ilgiai mazesni uz epsilon=', num2str(epsilon), ')']);
            disp(['2) funkcijos reiksmes simplekso virsunes panasios (tikslumu epsilon=', num2str(epsilon), ')']);
            disp(['3) pasiektas maksimalus funkciju kvietimu skaicius=', num2str(imax), ')']);
            goal = true;
        else
            disp(['Pasiektas maksimalus iteraciju skaicius i=', num2str(imax)]);
        endif
    endif
 
    if k == kmax
        format short;
        disp(['Pasiektas maksimalus iteraciju skaicius k=', num2str(kmax)]);
        break
    endif
 
    k = k + 1;
    y = [yl, yg, ynew];
    X = [Xl; Xg; Xnew];
 
    % Simplekso braizymas:
    deltax = [Xl(1), Xl(1), Xg(1); Xg(1), Xnew(1), Xnew(1)];
    deltay = [Xl(2), Xl(2), Xg(2); Xg(2), Xnew(2), Xnew(2)];
    plot(deltax, deltay, 'b');
    hold on;
    plot(X(:, 1), X(:, 2), 'mo');
    hold on;
 
    % used for pretty output
    if ~ count
        disp(' ');
    endif
 
endwhile
