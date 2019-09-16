function NiutonoMetodas
% Dalijimo pusiau metodu randamas funkcijos f(x) minimumas intervale [l,r].

f=@(x)(x.^2-5).^2/4-1;
f1=@(x)x*(x.^2-5);
f2=@(x)3*x.^2-5;
l=0;   % apatinis intervalo rezis
r=10;  % desinysis intervalo rezis

epsilon=10^(-4); %tikslumas

k=1; %iteraciju skaitliukas
kmax=100; % maksimalus iteraciju skaitliukas

%Funkcijos grafiko y=f(x) braizymas
x=l:0.01:r;
y=f(x);
plot(x,y,'b');
grid on;
xlabel('x asis');
ylabel('y asis');
title(['Funkcijos y=f(x) grafikas ir artiniai']);


%Metodo realizavimas

x0=5;
delta=1;
disp(['     x1        x2        k         funkc. kviet. sk']);

format short   % Jeigu noresi trumpesnio formato, uzkomentuok eilute :)

while delta>=epsilon
      x1=x0-f1(x0)/f2(x0);
      y1=f(x1);
      delta=abs(x1-x0);
      x0=x1;
      disp([x1, y1, k, 2*k]);
      hold on
      plot(x1, y1, 'ro')
      
      if k==kmax
          disp(['Pasiektas maksimalus iteraciju skaicius k=', num2str(kmax)]);
          break
      end 
      k=k+1;
end
ends