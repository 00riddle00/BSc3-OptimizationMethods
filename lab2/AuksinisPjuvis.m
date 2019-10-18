function res=AuksinisPjuvis(f, X0, grad)

f1=@(x) f(X0(1,1)-x.*grad(1,1), X0(1,2)-x.*grad(1,2));
l=0;   % apatinis intervalo rezis
r=5;  % desinysis intervalo rezis

epsilon=10^(-4); %tikslumas

k=1; %iteraciju skaitliukas
kmax=100; % maksimalus iteraciju skaitliukas

%Metodo realizavimas
L=r-l;      %intervalo ilgis
t=(sqrt(5)-1)/2;
x1=r-t*L; y1=f1(x1);
x2=l+t*L; y2=f1(x2);

format short

while L>= epsilon
      if y2<y1
          l=x1;
          L=r-l;
          x1=x2;
          y1=y2;
          x2=l+t*L;
          y2=f1(x2);
      else
          r=x2;
          L=r-l;
          x2=x1;
          y2=y1;
          x1=r-t*L;
          y1=f1(x1);
      end
      if k==kmax
          break
      end 
      k=k+1;
end
res=[x1, k+2];
end