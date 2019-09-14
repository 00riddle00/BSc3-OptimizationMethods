function DalijimasPusiauPvz
% Dalijimo pusiau metodu randamas funkcijos f(x) minimumas intervale [l,r].

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
L=r-l;      %intervalo ilgis
xm=(l+r)/2; %intervalo vidurio taskas
ym=f(xm);

disp(['     xm        ym        k         funkc. kviet. sk']);

format short   % Jeigu noresi trumpesnio formato, uzkomentuok eilute :)
while L>= epsilon
      disp([xm, ym, k, 2*k+1]);
      hold on;
      plot(xm, ym, 'ro');
      
      x1=l+L/4; y1=f(x1);
      x2=r-L/4; y2=f(x2);      
      
      if y1 < ym
          r = xm;
          xm = x1;
          ym = y1;
          % ciklas tesiasi
      elseif y2 < ym
          l = xm;
          xm = x2;
          ym = y2;
      else
          l = x1;
          r = x2;
      end
            
           

      
          
          
      if k==kmax
          disp(['Pasiektas maksimalus iteraciju skaicius k=', num2str(kmax)]);
          break
      end   
      
      k=k+1;
      L=r-l;
end
end


    
    
     















