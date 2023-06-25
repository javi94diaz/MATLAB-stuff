%% Inteligencia Artificial Aplicada - Javier Díaz Mena - 12100
% SOM  for classification

close all;
clc;

load data_D2_C2.mat

% Create a Self-Organizing Map
dimension1 = 4;
dimension2 = 2;
SOM = selforgmap([dimension1 dimension2]);

%% Train a SOM choosing the adequate number of neurons

% Adapting the network to the input values
SOM = configure(SOM, p.valor);
plotsom(SOM.iw{1,1}, SOM.layers{1}.distances)

% figure, plotsompos(SOM,x)

%% Training
SOM = train(SOM,p.valor);

% View the Network
view(SOM)

%% Classify the test data and obtain the confusion matrix

% Test the Network
y = SOM(t.valor);

% Classification
classes = vec2ind(y);

% Confusion matrix
figure
C = confusionmat(t.clase, classes);
confusionchart(C);

%% Plots
% figure, plotsomtop(net)
% figure, plotsomnc(net)
% figure, plotsomnd(net)
% figure, plotsomplanes(net)
% figure, plotsomhits(net,x)
% figure, plotsompos(SOM,x)

