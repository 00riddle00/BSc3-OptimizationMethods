function Simplex

f=@(X) (X(1).^2).*X(2) + X(1).*(X(2).^2) - X(1).*X(2);

// gradf=@(X) [2*X(1)*X(2) + X(2).^2 - X(2), X(1)^2 + 2*X(1)*X(2) - X(1)];       

% pradiniai artinai
X_0=[0,0]
X_1=[1,1]
X_m=[4/10, 7/10]
X_n=[1/2,1/2];

% pasirenkamas pradinis artinys
X0 = X_n

// %Funkcijos grafiko y=f(x1,x2) braizymas
// subplot(1,2,1)
// [x1,x2] = meshgrid(0:0.01:1, 0:0.01:1);
// y = f(x1, x2)
// surf(x1, x2, y);
// title(['Funkcijos y=f(x1,x2) grafikas'])

% pasirenkami parametrai
gamma=2;
beta=0.5;
eta=-0.5;
teta=1;

epsilon=10^(-4); %tikslumas

k=1; %iteraciju skaitliukas
kmax=100; % maksimalus iteraciju skaicius
imax=100 % maksimalus funkcijos kvietimu skaicius

%Pradinio simplekso sudarymas
alpha=1/2;
n=2;
delta1=alpha*(sqrt(n+1)+n-1)/(n*sqrt(2));
delta2=alpha*(sqrt(n+1)-1)/(n*sqrt(2));

X1=[XO(1,1)+delta2,X0(1,2)+delta1];
X2=[X0(1,1)+delta1,X0(1,2)+delta2];

y0=f(X0);
y1=f(X1);
y2=f(X2);
/////31/////


/////36/////
deltax=[X0(1),X0(1),X1(1);X1(1),X2(1),X(1)];
deltay=[X0(2),X0(2),X1(2);X1(2),X2(2),X2(2)];
plot(deltax,deltay,'r')
grid on
hold on
% plot(X(:,1),X(:,2),'mo');
% hold on

k=1; % iteraciju skaitliukas
i=3; % funkcijos kvietimu skaiciaus skaitliukas

norma=Inf;
format short

% Metodo realizavimas

disp(['   x1   x2    f(x1,x2)    k    (f kv. sk.)']);
disp('-----------------------------------------------');

pabaigti=false;
  while ~pabaigti
    % Randami Xh, Xg, X1 ir funkcijos reiksmes siuose taskuose yh, yg, y1
    [~, nr]=sort(y); % y0, y1, y2 reiksmes isdestomos didejimo tvarka; nr rodys ju numerius ma....

    y1=y(nr(1)); % maziausia y reiksme
    X1=X(nr(1),:);

    yh=y(nr(n+1)); % didziausia y reiksme  
    Xh=X(nr(n+1)); 

    yg=y(nr(n)); % antra pagal dydi y reiksme
    Xg=X(nr(n),:);

    % Viduriu tasko Xc ir naujo artinio Xnew apskaiciavimas
    Xc=(Xg+X1)/2;
    Xnew=Xh+(1+teta)*(Xc-Xh);
    ynew=f(Xnew);
    i=i+1;

    % Jei bent viena neigiama koordinate, keiciame krypti
    if Xnew(1)<=0 || Xnew(2)<=0
        disp('Neigiama artinio koordinate! Keiciame krypti.');
        teta=-1/2;
        Xnew=Xh+(1+teta)*(Xc-Xh);
        ynew=f(Xnew);
        i=i+1;
    end

    % Naujo simplekso sudarymas

    if (y1<ynew) && (ynew<yg)
        teta=1;
    elseif ynew<y1
      teta=gamma;
      Z=Xh+(1+teta)*(Xc-Xh);
      yz=f(Z);
      i=i+1;
      if yz<ynew
          ynew=yz;
          Xnew=Z;
      end
    elseif ynew>yh
      teta=eta;
      Z=Xh+(1+teta)*(Xc-Xh);
      Xnew=Z;
      ynew=f(Z);
      i=i+1;
    elseif (yg<ynew) && (ynew<yh)
      teta=beta;
      Z=Xh+(1+teta)*(Xc-Xh);
      Xnew=Z;
      ynew=f(Z);
      i=i+1;
    end

    if Xnew(1)<=0 || Xnew(2)<=0
      disp('Neigiama artimio koordinate! Keiciame krypti.');
      teta=-1/2;
      Xnew=Xh+(1+teta)*(Xc-Xh);
      ynew=f(Xnew);
      i=i+1;
    end

    fprintf('%f    %f   %f %d   %d', Xnew, ynew, k, i);

    count=0;

    if max([norm(X1-Xg),norm(X1-Xh),norm(Xg-Xh)])<epsilon
        disp(['Simpleksas tapo mazas (krastiniu ilgiai mazesni uz epsilon=', num2str(epsilon),....
        count=count+1;
    end

    if abc(yh-y1)<epsilon
        disp(['Funkcijos reiksmes simplekso virsunese panasios (tikslumu epsilon=', num2str(ep...
        count=count+1;
    end

    if i>=imax
        count=count+1;
          if count==3
            disp(' ');
            disp('Patenkinamos sustojimo salygos. Skaiciavimai baigiami, new:')
            disp(['1) simpleksas tapo mazas (krastiniu ilgiai mazesni uz epsilon=', num2...
            disp(['2) funkcijos reiksmes simplekso virsunes panasios (tikslumu epsilon='...
            disp(['3) pasiektas maksimalus funkciju kvietimu skaicius', num2str(imax)...
            pabaigti=true;
          end
    end
    if k==kmax  <---???
    k=k+1;
    y=[y1,yg,ynew];
    X=[X1;Xg;Xnew];

    % Simplekso braizymas:
    deltax=[X1(1),X1(1),Xg(1);Xg(1),Xnew(1),Xnew(1)];
    deltay=[X1(2),X1(2),Xg(2);Xg(2),Xnew(2),Xnew(2)];
    plot(deltax,deltay,'m')
    hold on
    % plot(X(:,1),X(:,2),'mo'); % Atkomentuoti, jei norima pavaizduoti bandymo taskus rutuliukais...
    % hold on
