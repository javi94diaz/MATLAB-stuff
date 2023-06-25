%% Scatter matrices

clc
clear
close all

load data_D2_C2.mat

%% DATOS P
% Representamos los datos "p"
% figure;
% plot( p.valor(1,1:100), p.valor(2,1:100),'r*');
% hold all;
% plot( p.valor(1,101:300), p.valor(2,101:300),'g*');

% Localizamos indices de los valores de clase 1 y de clase 2
ind_clasep1 = find(p.clase==1);
ind_clasep2 = find(p.clase==2);

% Calculamos matriz de dispersion para los valores de clase 1
Scp1=cov( p.valor(1,ind_clasep1), p.valor(2,ind_clasep1) )*(100-1)
trazaScp1 = trace(Scp1)

% Calculamos matriz de dispersion para los valores de clase 2
Scp2=cov( p.valor(1,ind_clasep2), p.valor(2,ind_clasep2) )*(200-1)
trazaScp2 = trace(Scp2)

% Matriz de varianzas Within p
SWp = Scp1 + Scp2
trazaSWp = trace(SWp)

% Extraemos en dos vectores los datos de clase 1 y de clase 2
valoresClasep1 = p.valor(:, ind_clasep1);
valoresClasep2 = p.valor(:, ind_clasep2);

% Calculamos vector de medias total, y vector de medias de cada clase
m = mean(p.valor')';
m1 = mean(valoresClasep1')';
m2 = mean(valoresClasep2')';

% Numero de datos de cada clase
np1 = length(ind_clasep1);
np2 = length(ind_clasep2);

% Calculamos matriz de dispersion Between los grupos (SB)
SB1p = np1*(m1-m)*(m1-m)';
SB2p = np2*(m2-m)*(m2-m)';

SBp = SB1p + SB2p
trazaSBp = trace(SBp)

% Matriz de dispersion total
STp = SWp + SBp
trazaSTp = trace(STp)

%% DATOS T
% Representamos los datos "t"
% figure;
% plot( t.valor(1,1:100), t.valor(2,1:100),'r*');
% hold all;
% plot( t.valor(1,101:300), t.valor(2,101:300),'g*');

% Localizamos indices de los valores de clase 1 y de clase 2
ind_claset1 = find(t.clase==1);
ind_claset2 = find(t.clase==2);

% Calculamos matriz de dispersion para los valores de clase 1
Sct1=cov( t.valor(1,ind_claset1), t.valor(2,ind_claset1) )*(107-1)
trazaSct1 = trace(Sct1)

% Calculamos matriz de dispersion para los valores de clase 2
Sct2=cov( t.valor(1,ind_claset2), t.valor(2,ind_claset2) )*(193-1)
trazaSct2 = trace(Sct2)

% Matriz de varianzas Within t
SWt = Sct1 + Sct2
trazaSWt = trace(SWt)

% Extraemos en dos vectores los datos de clase 1 y de clase 2
valoresClaset1 = t.valor(:, ind_claset1);
valoresClaset2 = t.valor(:, ind_claset2);

% Calculamos vector de medias total, y vector de medias de cada clase
m = mean(t.valor')';
m1 = mean(valoresClaset1')';
m2 = mean(valoresClaset2')';

% Numero de datos de cada clase
nt1 = length(ind_claset1);
nt2 = length(ind_claset2);

% Calculamos matriz de dispersion Between los grupos (SB)
SB1t = nt1*(m1-m)*(m1-m)';
SB2t = nt2*(m2-m)*(m2-m)';

SBt = SB1t + SB2t
trazaSBt = trace(SBt)

% Matriz de dispersion total
STt = SWt + SBt
trazaSTt = trace(STt)

%% Normalizacion

[D,N]=size(p.valor);
[D,Nt]=size(t.valor);
clear pn meanp stdp;
meanp = mean(p.valor')';
stdp= std(p.valor')';

for i=1:N
    pn(:,i)=(p.valor(:,i)-meanp)./stdp;
end

for i=1:Nt
    tn(:,i)=(t.valor(:,i)-meanp)./stdp;
end

% Y ahora repetimos todo el codigo pero con los datos normalizados pn y tn
% en vez de p.valor y t.valor

%% DATOS P NORMALIZADOS (subindice _n)
% Representamos los datos "p"
% figure;
% plot( pn.valor(1,1:100), pn.valor(2,1:100),'r*');
% hold all;
% plot( pn.valor(1,101:300), pn.valor(2,101:300),'g*');

% Calculamos matriz de dispersion para los valores de clase 1
Scp1_n=cov( pn(1,ind_clasep1), pn(2,ind_clasep1) )*(100-1)
trazaScp1_n = trace(Scp1_n)

% Calculamos matriz de dispersion para los valores de clase 2
Scp2_n=cov( pn(1,ind_clasep2), pn(2,ind_clasep2) )*(200-1)
trazaScp2_n = trace(Scp2_n)

% Matriz de varianzas Within p
SWp_n = Scp1_n + Scp2_n
trazaSWp_n = trace(SWp_n)

% Extraemos en dos vectores los datos de clase 1 y de clase 2
valoresClasep1_n = pn(:, ind_clasep1);
valoresClasep2_n = pn(:, ind_clasep2);

% Calculamos vector de medias total, y vector de medias de cada clase
m_n = mean(pn')';
m1_n = mean(valoresClasep1_n')';
m2_n = mean(valoresClasep2_n')';

% Numero de datos de cada clase
np1_n = length(ind_clasep1);
np2_n = length(ind_clasep2);

% Calculamos matriz de dispersion Between los grupos (SB)
SB1p_n = np1_n*(m1_n-m_n)*(m1_n-m_n)';
SB2p_n = np2_n*(m2_n-m_n)*(m2_n-m_n)';

SBp_n = SB1p_n + SB2p_n
trazaSBp_n = trace(SBp_n)

% Matriz de dispersion total
STp_n = SWp_n + SBp_n
trazaSTp_n = trace(STp_n)

%% DATOS T NORMALIZADOS (subindice _n)
% Representamos los datos "t"
% figure;
% plot( tn.valor(1,1:100), tn.valor(2,1:100),'r*');
% hold all;
% plot( tn.valor(1,101:300), tn.valor(2,101:300),'g*');

% Calculamos matriz de dispersion para los valores de clase 1
Sct1_n=cov( tn(1,ind_claset1), tn(2,ind_claset1) )*(107-1)
trazaSct1_n = trace(Sct1_n)

% Calculamos matriz de dispersion para los valores de clase 2
Sct2_n=cov( tn(1,ind_claset2), tn(2,ind_claset2) )*(193-1)
trazaSct2_n = trace(Sct2_n)

% Matriz de varianzas Within t
SWt_n = Sct1_n + Sct2_n
trazaSWt_n = trace(SWt_n)

% Extraemos en dos vectores los datos de clase 1 y de clase 2
valoresClaset1_n = tn(:, ind_claset1);
valoresClaset2_n = tn(:, ind_claset2);

% Calculamos vector de medias total, y vector de medias de cada clase
m_n = mean(tn')';
m1_n = mean(valoresClaset1_n')';
m2_n = mean(valoresClaset2_n')';

% Numero de datos de cada clase
nt1_n = length(ind_claset1);
nt2_n = length(ind_claset2);

% Calculamos matriz de dispersion Between los grupos (SB)
SB1t_n = nt1_n*(m1_n-m_n)*(m1_n-m_n)';
SB2t_n = nt2_n*(m2_n-m_n)*(m2_n-m_n)';

SBt_n = SB1t_n + SB2t_n
trazaSBt_n = trace(SBt_n)

% Matriz de dispersion total
STt_n = SWt_n + SBt_n
trazaSTt_n = trace(STt_n)

