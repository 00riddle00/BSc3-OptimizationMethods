function res=AuksinisPjuvis(f, X0, grad)

f1=@(x) f(X0(1,1)-x.*grad(1,1), X0(1,2)-x.*grad(1,2));

  
% Aksinio pjuvio metodu randamas funkcijos f(x) minimumas intervale [l,r].

%f=@(x)(((x.^2-4).^2)/7) - 1;

l=0;   % apatinis intervalo rezis
r=10;  % desinysis intervalo rezis

epsilon=10^(-4); %tikslumas

k=1; %iteraciju skaitliukas
kmax=100; % maksimalus iteraciju skaitliukas

%Metodo realizavimas
disp(['     x1        y1        k         funkc. kviet. sk']);

format long

gR = (sqrt(5) - 1) / 2;

L = r-l; % intervalo ilgis
x1 = r-gR*L;
y1 = f1(x1);
x2 = l + gR*L;
y2 = f1(x2);

while L>= epsilon
      format long
      disp([x1, y1]);
      format short
      disp([k, k+2]);
            
      hold on;
      plot(x1, y1, 'ro');
          
      
      if y2 < y1
          l = x1;
          L = r - l;
          x1 = x2;
          y1=y2;
          x2 = l + gR*L;
          y2 = f1(x2);
      else
          r = x2;
          L = r - l;
          x2 = x1;
          y2=y1;
          x1 = r - gR*L;
          y1 = f1(x1);
      end 
          
      if k==kmax
          format short
          disp(['Pasiektas maksimalus iteraciju skaicius k=', num2str(kmax)]);
          break
      end   
      
      k=k+1;
      L=r-l;
end
res=[x1, k+2];
end
