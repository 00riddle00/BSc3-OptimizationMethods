
function res=Simplex(B,X0,r)
  
f = @(X) B(X,r);

% pasirenkami parametrai
alpha = 0.5; % reguliuoja pradinio simplekso krastines ilgi
teta = 1.0; % reguliuoja tieses lygti, breziamos per vidurio taska, ieskant naujos virsunes
% simplekso deformavimo koeficientai
gamma = 2.0; % reguliuoja simplekso ispletima, gamma > 1
beta = 0.5; % reguliuoja simplekso suspaudima, 0 < beta < 1
eta = - 0.5; % reguliuoja simplekso suspaudima, -1 < eta < 0

% tikslumas
epsilon = 10 ^ (-6); 

% Pradinio simplekso sudarymas
n = 3; % keliu kintamuju funkcija yra minimizuojama
delta1 = alpha * (sqrt(n + 1) + n - 1) / (n * sqrt(2));
delta2 = alpha * (sqrt(n + 1) - 1) / (n * sqrt(2));

% kitos simplekso virsunes (apskaiciuojame pagal teorine medziaga)
X1 = [X0(1, 1) + delta2, X0(1, 2) + delta1, X0(1, 3) + delta1];
X2 = [X0(1, 1) + delta1, X0(1, 2) + delta2, X0(1, 3) + delta1];
X3 = [X0(1, 1) + delta1, X0(1, 2) + delta1, X0(1, 3) + delta2];

% funkcijos reiksmes simplekso virsunese
y0 = f(X0);
y1 = f(X1);
y2 = f(X2);
y3 = f(X3);

% simplekso virsuniu masyvas
X = [X0; X1; X2; X3];

% funkcijos reiksmiu simplekso virsunese masyvas
y = [y0, y1, y2, y3];

k = 1; % iteraciju skaitliukas (pradinio simplekso sudarymas = 1 iteracija)
i = 4; % funkcijos kvietimu skaiciaus skaitliukas
kmax = 100; % maksimalus iteraciju skaicius
imax = 100; % maksimalus funkcijos kvietimu skaicius

format short;

% Metodo realizavimas

goal = false;
while ~ goal
    % Randami Xh, Xg, Xl ir funkcijos reiksmes siuose taskuose yh, yg, yl
    [~, nr] = sort(y); % y0, y1, y2, y3 reiksmes isdestomos didejimo tvarka; nr rodys ju numerius masyve y
 
    yl = y(nr(1)); % maziausia y reiksme
    Xl = X(nr(1), :);
 
    yh = y(nr(n + 1)); % didziausia y reiksme
    Xh = X(nr(n + 1), :);
 
    yg = y(nr(n)); % antra pagal dydi y reiksme
    Xg = X(nr(n), :);
    
    yi = y(nr(2)); % likusi vidurine reiksme
    Xi = X(nr(2), :);
    
    % Viduriu tasko Xc ir naujo artinio Xnew apskaiciavimas
    Xc = (Xg + Xl + Xi) / 3;
 
    Xnew = Xh + (1 + teta) * (Xc - Xh);
    ynew = f(Xnew);
    i = i + 1;
 
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
  
    count = 0;
 
    if max([norm(Xl - Xi), norm(Xl - Xg), norm(Xl - Xh), norm(Xi - Xg), norm(Xi - Xh), norm(Xg - Xh)]) < epsilon
        count = count + 1;
    endif
 
    if max([abs(yl - yi), abs(yl - yg), abs(yl - yh), abs(yi - yg), abs(yi - yh), abs(yg - yh)]) < epsilon
        if ~count
        endif  
        count = count + 1;
    endif
 
    if i >= imax
        count = count + 1;
        if count == 3
            goal = true;
        endif
    endif
 
    k = k + 1;
    % naujas artinys
    X = [Xl; Xi; Xg; Xnew];
    % funkcijos reiksmes naujame artinyje
    y = [yl, yi, yg, ynew];

 
endwhile
res=[Xnew,i];
endfunction



