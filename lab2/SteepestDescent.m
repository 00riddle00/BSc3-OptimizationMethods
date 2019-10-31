function SteepestDescent

f=@(X) (1 / 8) * (X(1)^2.*X(2)+X(1)*X(2)^2-X(1)*X(2));
% ieskome min(f(X))

gradf = @(X) [2 * X(1) * X(2) + X(2) .^ 2 - X(2), X(1) ^ 2 + 2 * X(1) * X(2) - X(1)];

% pradiniai artiniai
X_0 = [0, 0];
X_1 = [1, 1];
X_m = [4 / 10, 7 / 10];

% pasirenkamas pradinis artinys
X0 = X_m;

epsilon = 10 ^ (- 4); % tikslumas

i=0; % funkcijos kvietimu skaicius
k=1; %iteraciju skaitliukas
kmax=100; % maksimalus iteraciju skaitliukas

% Metodo realizavimas

disp(['x1       x2       f(x1,x2)  k (funkc. kviet. sk)']);

format short;

norma = Inf;

while norma>=epsilon
      grad=gradf(X0);
      res=GoldenSection(f,X0,grad);
      gamma=res(1);
      i=i+res(2)+1;
      X0 = X0 - gamma .* grad; % naujas artinys
      norma = norm(grad);
    
      fprintf('%f %f %f %d %d\n', X0, f(X0), k, i);
      
      subplot(1, 2, 2);
      grid on;
      title(['Artiniai (pradinis taškas: Xm)']);
      plot(X0(1), X0(2), 'mo');
      hold on;

      if k==kmax
          disp(['Pasiektas maksimalus iteraciju skaicius k=', num2str(kmax)]);
          break
      end
      k=k+1;
end
end