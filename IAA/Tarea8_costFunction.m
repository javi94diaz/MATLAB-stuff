%% Inteligencia Artificial Aplicada - Javier Díaz Mena - 12100
% Cost function

% Notacion
% P1 representa P(C1)
% P2 representa P(C2)
% predicted_probs son P(C1|x) y P(C2|x) que las da la funcion predict
% Esto evita tener que extraer P(x|C1) y P(x|C2) del histograma aproximado
% como una distribucion normal
% Cost (matriz de costes) contiene C(C1|C1), C(C1|C2), C(C2|C1), C(C2|C2)

clc
clear
close all
load('data_D1_C2.mat')

% Representar los datos p en un histograma
figure
histogram(p.valor(1,1:100));
hold on;
histogram(p.valor(1,101:300));
hold off;
title('Histograma datos p')
%% Apartado a)

% Entrenamiento del modelo Bayesiano
x = 0.9;
P1 = 1;
P2 = 1;
bayesModel = fitcnb(p.valor',p.clase','Prior',[P1 P2]);

% Predice que x = 0.9 es de clase 1
[bayes_classp,predicted_probs] = predict(bayesModel,x)

%% Apartado b)
x1p = find(p.clase==1);
x2p = find(p.clase==2);

% Calcular probabilidad de cada clase (nº datos de la clase/nº datos totales)
T = length(p.clase);
Lx1p = length(x1p);
Lx2p = length(x2p);
P1 = Lx1p/T;
P2 = Lx2p/T;

bayesModel1 = fitcnb(p.valor',p.clase','Prior',[P1 P2]);
[bayes_classp,predicted_probs] = predict(bayesModel1,x) % Predice que es de clase 2

%% Apartado c)

figure
histogram(p.valor(1,1:100), 'Normalization','probability');
hold on;
histogram(p.valor(1,101:300), 'Normalization','probability');
hold off;
title('Aproximación a distribución normal (datos p)')

% Matriz de costes
Cost = [1.1 1.1; 8 0.1]; 
bayesModelCost = fitcnb(p.valor',p.clase','Prior',[P1 P2]);

% Predice que es de clase 2
[bayclasscost,predicted_probs] = predict(bayesModelCost,x)

% Coste para x = 0.9 por ser de clase 1 o de clase 2
C1_x = Cost(1,1)*predicted_probs(1) + Cost(1,2)*predicted_probs(2);
C2_x = Cost(2,1)*predicted_probs(1) + Cost(2,2)*predicted_probs(2);

