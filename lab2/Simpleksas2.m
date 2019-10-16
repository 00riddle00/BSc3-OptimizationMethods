function Simpleksas2
f=@(X)((X(1).^2).*X(2)+X(1).*(X(2).^2)-X(1).*X(2));%/8;
epsilon=10^(-6);

n=2;
alpha=1;
beta=0.5;
gamma=2;
eta=-0.5;
theta=1;

delta1=((sqrt(n+1)+n-1)/(n*sqrt(2)))*alpha;
delta2=((sqrt(n+1)-1)/(n*sqrt(2)))*alpha;

% X0=[0,0];      %X0
% X0=[1,1];      %X1
X0=[1, 1]; %Xm
X1=[X0(1)+delta2, X0(2)+delta1];
X2=[X0(1)+delta1, X0(2)+delta2];

Y0=f(X0);
Y1=f(X1);
Y2=f(X2);

Y=[Y0,Y1,Y2];
X=[X0;X1;X2];

deltax=[X0(1),X0(1),X1(1);X1(1),X2(1),X2(1)];
deltay=[X0(2),X0(2),X1(2);X1(2),X2(2),X2(2)];

plot(deltax, deltay, 'r');
      grid on;
      hold on;

i=3; %funkcij� kvietimo skaitliukas
imax=100; %maksimalus funkciju kvietimo skaicius
k=0; %iteraciju skaitliukas
kmax=2; %maksimalus iteraciju skaitliukas

disp(['    x1        x2       f(x1,x2)   k         funkc. kviet. sk']);

fprintf("debug0: %f %f %f", X, Y);

fprintf("debug1");
X
Y

testi=true;
while testi

    k=k+1;
    [~,nr]=sort(Y);

    fprintf("debug2");
    nr

% Ma�iausias
    yl=Y(nr(1));
    Xl=X(nr(1),:);
% Did�iausias
    yh=Y(nr(3));
    Xh=X(nr(3),:);
% Antras pagal dyd�
    yg=Y(nr(2));
    Xg=X(nr(2),:);

    Xc=(Xg+Xl)/2;

    Xl
    Xg
    Xh
    Xc
    
    Xnaujas=Xh+(1+theta)*(Xc-Xh);
    ynaujas=f(Xnaujas);
    fprintf("debug3: %f %f %f", Xnaujas, ynaujas);
    i=i+1;
    if Xnaujas(1) <= 0 || Xnaujas(2) <= 0
        theta=eta;
        Xnaujas=Xh+(1+theta)*(Xc-Xh);
        ynaujas=f(Xnaujas);
        i=i+1;
        disp('keiciame krypti');
    end
    
    if yl < ynaujas && ynaujas < yg
        theta=1;
    elseif ynaujas < yl
        theta=gamma;
        Z=Xh+(1+theta)*(Xc-Xh);
        yz=f(Xnaujas);
        i=i+1;
        if yz < ynaujas
            Xnaujas=Z;
            ynaujas=yz;
        end
    elseif (ynaujas > yh)
        theta=eta;
        Xnaujas=Xh+(1+theta)*(Xc-Xh);
        ynaujas=f(Xnaujas);
        i=i+1;
    elseif yg < ynaujas && ynaujas < yh
        theta=beta;
        Xnaujas=Xh+(1+theta)*(Xc-Xh);
        ynaujas=f(Xnaujas);
        i=i+1;
    end 
    
    if Xnaujas(1) <= 0 || Xnaujas(2) <= 0
        theta=eta;
        Xnaujas=Xh+(1+theta)*(Xc-Xh);
        ynaujas=f(Xnaujas);
        i=i+1;
        disp('keiciame krypti');
    end
    
    X=[Xl;Xg;Xnaujas];
    Y=[yl,yg,ynaujas];
    
    deltax=[Xl(1),Xl(1),Xg(1);Xg(1),Xnaujas(1),Xnaujas(1)];
    deltay=[Xl(2),Xl(2),Xg(2);Xg(2),Xnaujas(2),Xnaujas(2)];

    plot(deltax, deltay, 'r');
        hold on;
        
    fprintf('%d %d %f %f %f\n', k, i, Xnaujas, ynaujas);
      if k==kmax
          disp(['Pasiektas maksimalus iteraciju skaicius k=', num2str(kmax)]);
          break;
      end 
      
      count=0;
      
      if i>=imax
          disp(['Pasiektas maksimalus funkciju kvietimo skaicius i=', num2str(imax)]);
          count=count+1;
      end 
      
      if max([norm(Xl-Xg), norm(Xl-Xnaujas), norm(Xnaujas-Xg)]) < epsilon
          count=count+1;
          disp('Simpleksas tapo labai ma�as');
      end
      
      if max([abs(yl-yg), abs(yl-ynaujas), abs(ynaujas-yg)]) < epsilon
          count=count+1;
          disp('Reik�m�s vir��n�se tampa pana�ios');
      end
      
      if count == 3
          testi=false;
      end
end
hold off
end