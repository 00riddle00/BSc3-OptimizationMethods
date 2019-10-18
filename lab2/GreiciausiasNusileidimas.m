function GreiciausiasNusileidimas

f=@(x1, x2)(x1.^2.*x2+x1.*x2.^2-x1.*x2)/8;
gradf=@(m1, m2)[2*m1.*m2+m2.^2-m2, 2*m1.*m2+m1.^2-m1];
epsilon=10^(-6);

%X0=[0,0];      %X0
%X0=[1,1];      %X1
%X0=[0.5, 0.4]; %Xm

subplot(1,2,1);
[x1,x2] = meshgrid(0:0.01:0.8, 0:0.01:0.8);
y=f(x1,x2);
surf(x1, x2, y);
i=0;
k=1; %iteraciju skaitliukas
kmax=100; % maksimalus iteraciju skaitliukas

disp(['    x1        x2       f(x1,x2)   k         funkc. kviet. sk']);

gradnorma=Inf;
format short

while gradnorma>=epsilon
      grad=gradf(X0(1,1),X0(1,2));
      ats=AuksinisPjuvis(f,X0,grad);
      gamma=ats(1,1);
      i=i+ats(1,2)+1;
      X1=X0-gamma*grad;
      
      disp([X1(1,1), X1(1,2), f(X1(1,1), X1(1,2)), k, i]);
      subplot(1,2,2);
      plot(X1(1,1), X1(1,2) , 'o')
      grid on
      hold on
      if k==kmax
          disp(['Pasiektas maksimalus iteraciju skaicius k=', num2str(kmax)]);
          break
      end 
      k=k+1;
      gradnorma=norm(grad);
      X0=X1;
end
end