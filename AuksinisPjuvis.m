function AuksinioPjuvioPvz
% Aksinio pjuvio metodu randamas funkcijos f(x) minimumas intervale [l,r].

f=@(x)(x.^2-1).^2-1;
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
%L=r-l;      %intervalo ilgis
%xm=(l+r)/2; %intervalo vidurio taskas
%ym=f(xm);

disp(['     xm        ym        k         funkc. kviet. sk']);

format short   % Jeigu noresi trumpesnio formato, uzkomentuok eilute :)

gR = (sqrt(5) - 1) / 2;

L = r-l;
x1 = r-gR*L;
y1 = f(x1);
x2 = l + gR*L;
y2 = f(x2);

while L>= epsilon
      disp([x1, y1, k, k+2]);
      hold on;
      plot(x1, y1, 'ro');
          
      
      if y2 < y1
          l = x1;
          L = r - l;
          x1 = x2;
          y1=y2;
          x2 = l + gR*L;
          y2 = f(x2);
      else
          r = x2;
          L = r - l;
          x2 = x1;
          y2=y1;
          x1 = r - gR*L;
          y1 = f(x1);
      end
            
           

      
          
          
      if k==kmax
          disp(['Pasiektas maksimalus iteraciju skaicius k=', num2str(kmax)]);
          break
      end   
      
      k=k+1;
      L=r-l;
end
end


    
    
     















