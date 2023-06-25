close all
clc

%% Load the data
load data_D2_C2.mat

%% Plot the data
n = length(p.valor);
img1 = figure;
hold on

for i = 1:n
    if p.clase(1,i) == 1
        scatter(p.valor(1,i), p.valor(2, i), 15, 'blue', 'filled');
    elseif p.clase(1,i) == 2
        scatter(p.valor(1,i), p.valor(2, i), 15, 'red', 'filled');
    elseif p.clase(1,i) == 3
        scatter(p.valor(1,i), p.valor(2, i), 15, 'black', 'filled');
    end
end

%% a) Train a SOM choosing the adequate number of neurons a SOM

% Matriz con el valor minimo y maximo de cada fila de p.valor
% (sale 2x2 en este caso)
minmaxMatriz = minmax(p.valor);

% Creamos el SOM
% som1 = newsom( minmaxMatriz, [5 6]);
som1 = selforgmap([1 8])

% som1.trainParam.time(1,1)
som1.trainParam.epochs = 1

%% Entrenamos el SOM con el p.valor
som1 = train(som1,p.valor);
plotsom(som1.iw{1,1}, som1.layers{1}.distances)

view(som1)

%% b) Label the neurons using the train data


%% c) Classify the test data and obtain the confusion matrix
% ynt = sim(som1, t.valor);
ynt = som1(t.valor);

% ynt_ind = vec2ind(ynt);
classes = vec2ind(ynt);

%% 
figure
C = confusionmat(t.clase, classes);
confusionchart(C);