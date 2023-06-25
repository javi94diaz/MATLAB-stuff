%% Inteligencia Artificial Aplicada - Javier Díaz Mena - 12100
% Linear Discriminant Analysis (Fisher)

clc
clear
close all;
load('data_D2_C2.mat')

%Identificación indices por clases
pclase1 = find(p.clase==1);
pclase2 = find(p.clase==2);
tclase1 = find(t.clase==1);
tclase2 = find(t.clase==2);

% Ploteo datos iniciales
% figure;
% plot(p.valor(1,pclase1),p.valor(2,pclase1),'*'); hold all;
% plot(p.valor(1,pclase2),p.valor(2,pclase2),'*');
% title("Datos p iniciales");
% 
% figure;
% plot(t.valor(1,1:100),t.valor(2,1:100),'*'); hold all;
% plot(t.valor(1,101:300),t.valor(2,101:300),'*');
% title("Datos t iniciales");

%% Normalizacion de los datos

[~,N]=size(p.valor); 
[D,Nt]=size(t.valor);

meanp = mean(p.valor')';
stdp = std(p.valor')';

for i=1:N
    pn(:,i)=(p.valor(:,i)-meanp)./stdp; 
end
for i=1:Nt
    %Utilizamos meanp y stdp sobre t, ya que no tenemos info 
    % sobre t(teoricamente) asumimos que la media de t es parecida a la de p
    tn(:,i)=(t.valor(:,i)-meanp)./stdp; 
end

% Ploteo datos normalizados
% figure;
% plot(pn(1,pclase1),pn(2,pclase1),'*'); hold all;
% plot(pn(1,pclase2),pn(2,pclase2),'*');
% 
% figure;
% plot(tn(1,tclase1),tn(2,tclase1),'*'); hold all;
% plot(tn(1,tclase2),tn(2,tclase2),'*');

%% Medias globales normalizados (puntos centrales para p y t)
mp = mean(pn')';%media global p
mt = mean(tn')';%media global t

%Longitud de cada clase
nc1p = length(pclase1);
nc2p = length(pclase2);
nc1t = length(tclase1); 
nc2t = length(tclase2);

%Para los datos normalizados, separamos los datos en clases
%Vectores para p de clase 1 y clase 2
v_valor_cp1 = pn(:,pclase1);        
v_valor_cp2 = pn(:,pclase2);
%Vectores para t de clase 1 y clase 2
v_valor_ct1 = tn(:,tclase1);
v_valor_ct2 = tn(:,tclase2);

%Matrices dispersion dentro de las clases
Sc1p = cov(v_valor_cp1',1)*nc1p;
Sc2p = cov(v_valor_cp2',1)*nc2p;
Sc1t = cov(v_valor_ct1',1)*nc1t;
Sc2t = cov(v_valor_ct2',1)*nc2t;

Swt = Sc1t + Sc2t;
Swp = Sc1p + Sc2p;           

%Medias de cada clase
mc1p = mean(v_valor_cp1')';
mc2p = mean(v_valor_cp2')';
mc1t = mean(v_valor_ct1')';
mc2t = mean(v_valor_ct2')';

% Varianzas de cada clase
vc1p = var(v_valor_cp1')';
vc2p = var(v_valor_cp2')';
vc1t = var(v_valor_ct1')';
vc2t = var(v_valor_ct2')';

%Matrices de dispersion entre clases
SB1p = nc1p*(mc1p-mp)*(mc1p-mp)';
SB2p = nc2p*(mc2p-mp)*(mc2p-mp)';
SBp = SB1p + SB2p;  

SB1t = nc1t*(mc1t-mt)*(mc1t-mt)';
SB2t = nc2t*(mc2t-mt)*(mc2t-mt)';
SBt = SB1t + SB2t;

% LDA                                     

%% Multidimensional Fisher

[Wmulti, Diag] = eig ( inv(Swp)*SBp )

%Multidimensional
% [transMatc,Diag] = eig(cov(pn'));
% [Wmulti,Diag] = eig (cov(inv(Swp).*SBp)); %Autovectores y dirección en la que se dispersan los datos (Autovalores)    Construcción de W
% [Wmulti,Diag]=eig(inv(Swp)*SBp);
% J = trace(inv(Wmulti.'.*Swp.*Wmulti).*Wmulti.'.*SBp.*Wmulti)
% Jprueba2 = trace(inv(Swp).*SBp)

% Autovectores
w1= Wmulti(:,1);
w2=Wmulti(:,2);

% Proyectamos los datos
% Direccion de mayor separabilidad
tn_proj2 = w2'*tn; % 1D
tnrecons2 = w2*tn_proj2; % 2D reconstruido

% Ploteo todo junto normalizado
figure;
plot(tnrecons2(1,:), tnrecons2(2,:), '*'); hold on; % Datos proyectados 1a direccion de mayor separabilidad (del autovalor mayor)
plot(tn_proj2, tn_proj2, '*');
plot(tn(1,tclase1),tn(2,tclase1),'*'); % Datos separados por clases
plot(tn(1,tclase2),tn(2,tclase2),'*');
title('Datos normalizados');
hold off;

% Desnormalización de los datos proyectados
for i=1:Nt
    tnrecons_des(:,i)=(tnrecons2(:,i).*stdp) + meanp;
    tn_proj_des = (tn_proj2.*stdp) + meanp;
end

figure;
plot(tnrecons_des(1,:),tnrecons_des(2,:),'*'); hold on;
plot(tn_proj_des(1,:), tn_proj_des(2,:), '*');
plot(t.valor(1,tclase1),t.valor(2,tclase1),'*');
plot(t.valor(1,tclase2),t.valor(2,tclase2),'*');
title('Datos desnormalizados');
hold off;

% Error MSE
errorDatosNorm = D*immse(tnrecons2, tn)
errorDatosSinNorm = D*immse(tnrecons_des, t.valor)



