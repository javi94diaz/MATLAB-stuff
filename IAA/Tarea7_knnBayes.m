%% Inteligencia Artificial Aplicada - Javier Díaz Mena - 12100
% Knn and Bayes clasiffication

clc
clear
close all;
load('data_D2_C2.mat')

%% k-nn
% Creacion del modelo de K-NN (aprendizaje)
knnModel = fitcknn(p.valor',p.clase);

% Prediccion de resultados para los valores p y t
knn_classp = predict(knnModel, p.valor'); 
knn_classt = predict(knnModel, t.valor');

% Numero de errores cometidos para datos p y t (comparar prediccion con realidad)
errores_knn_p = length( find( knn_classp' ~= p.clase))
errores_knn_t = length( find( knn_classt' ~= t.clase))

%% Bayes
% x1p = find(p.clase==1);
% x2p = find(p.clase==2);
% T = length(p.clase);
% Lx1p = length(x1p);
% Lx2p = length(x2p);
% P1 = Lx1p/T;
% P2 = Lx2p/T;
% Creacion del modelo de Bayes (aprendizaje)
bayesModel = fitcnb(p.valor',p.clase');

% Prediccion de resultados para los valores p y t
bayes_classp = predict(bayesModel,p.valor');
bayes_classt = predict(bayesModel,t.valor');

% Numero de errores cometidos para datos p y t (comparar prediccion con realidad)
errores_bayes_p = length( find( bayes_classp' ~=p.clase))
errores_bayes_t = length( find( bayes_classt' ~=t.clase))

%% Bayes con probabilidades a priori (3 casos)
% Se construye el modelo, precide y calcula errores cometidos

%% Caso 1 - P1 = 1, P2 = 0.1
P1 = 1;
P2 = 0.1;
bayesModel1 = fitcnb(p.valor',p.clase','Prior',[P1 P2]);

bayes_classp1 = predict(bayesModel1,p.valor');
bayes_classt1 = predict(bayesModel1,t.valor'); 

errores_bayes_t1 = length(find(bayes_classt1'~=t.clase))

%% Caso 2 - P1 = 1, P2 = 2
P1 = 1;
P2 = 2;
bayesModel2 = fitcnb(p.valor',p.clase','Prior',[P1 P2]);

bayes_classp2 = predict(bayesModel2,p.valor');
bayes_classt2 = predict(bayesModel2,t.valor'); 

errores_bayes_t2 = length(find(bayes_classt2'~=t.clase))

%% Caso 3 - P1 = 1, P2 = 10
P1 = 1;
P2 = 10;
bayesModel3 = fitcnb(p.valor',p.clase','Prior',[P1 P2]);

bayes_classp3 = predict(bayesModel3,p.valor');
bayes_classt3 = predict(bayesModel3,t.valor');

errores_bayes_t3 = length(find(bayes_classt3'~=t.clase))
