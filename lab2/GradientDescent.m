function GradientDescent

f=@(x1, x2)(1/8)*((x1.^2).*x2 + x1.*(x2.^2) - x1.*x2);

% ieskome min(f(x1, x2))

gradf=@(X) [2*X(1)*X(2) + X(2).^2 - X(2), 
            X(1)^2 + 2*X(1)*X(2) - X(1)];

X0 = [1/2,1/2];
#X0 = [0,0]
%X1 = [1,1]
%Xm = [4/10, 7/10]

%gamma_reziai = [0,1]
gamma = 1/2;

epsilon=10^(-4); %tikslumas

k=1; %iteraciju skaitliukas
kmax=100; % maksimalus iteraciju skaitliukas

%Funkcijos grafiko y=f(x) braizymas
%x=l:0.01:r;
%y=f(x);
%plot(x,y,'b');
%grid on;
%xlabel('x asis');
%ylabel('y asis');
%title(['Funkcijos y=f(x) grafikas ir artiniai']);

%Metodo realizavimas

%x0=5;
%delta=1;
disp(['     x1        x2        f(x1,x2)       k         funkc. kviet. sk']);
   
format long

norma = Inf;

while norma >=epsilon
  
      grad = gradf(X0);
      X1 = X0 - gamma * grad;
      norma = norm(grad)
 
      fprintf('%f %f %f %d %d\n', X1, f( X1(1), X1(2) ), k, k);             
      hold on
      plot(x1, y1, 'ro')
      
      if k==kmax
          format short
          disp(['Pasiektas maksimalus iteraciju skaicius k=', num2str(kmax)]);
          break
      end 
      k=k+1;
      X0 = X1;
end
end