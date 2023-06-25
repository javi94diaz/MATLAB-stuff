%% Principal Component Analysis

clc
clear
close all
load 'data_D2_C2.mat'

% Normalizacion de los datos (p y t)
[~,N] = size(p.valor);
[D,Nt]= size(t.valor);

% Media y desviacion de los datos p
meanp = mean(p.valor')';
stdp= std(p.valor')';

matrp = cov(p.valor')

% Operacion de normalizacion
for i=1:N
    pn(:,i)=(p.valor(:,i)-meanp)./stdp;
end

for i=1:Nt
    tn(:,i)=(t.valor(:,i)-meanp)./stdp;
end

% Diagonalizacion de la matriz de dispersion (datos normalizados)
[Wc, Diag] = eig(cov(pn'));
matrizvarianzas = cov(pn')

% Extrae la columna D+1-i de la matriz de autovectores (autovector del mayor autovalor)
ncomPCA = 1;
for i  = 1:ncomPCA
    W(i, :) = Wc(:, D+1-i) 
end

% Proyectar los datos p sobre la direccion principal
pnproj = W*pn;
pnrecons = W'*pnproj;

% Proyectar los datos t sobre la direccion principal
tnproj = W*tn;
tnrecons = W'*tnproj;

% Representar datos t normalizados
figure
plot(tnrecons(1,:), tnrecons(2,:), 'b*');
hold on;
plot(tn(1,:), tn(2,:), 'r*');
hold off;
title('Datos t normalizados') 

% Desnormalizamos datos p y t reconstruidos
for i=1:N
    pproj_des(:,i)=pnrecons(:,i).*stdp + meanp;
end

for i=1:Nt
    tproj_des(:,i)=tnrecons(:,i).*stdp + meanp;
end

% Representar datos t desnormalizados
figure
plot(tproj_des(1,:), tproj_des(2,:), '*');
hold on;
plot(t.valor(1,:), t.valor(2,:), '*');
hold off;
title('Datos t desnormalizados')

% Error esperado
expectedError = Diag(1,1)

% MSE de datos normalizados y no normalizados
errorDatosNorm = D*immse(tnrecons, tn)
errorDatosSinNorm = D*immse(tproj_des, t.valor)

% NOTA: los reconstruidos y los proj, son los mismos datos (los datos 
% proyectados sobre la direccion ppal), pero expresados en 2D o en 
% 1D respectivamente

trace (Diag) % debe sumar 2, que es el numero de dimensiones

