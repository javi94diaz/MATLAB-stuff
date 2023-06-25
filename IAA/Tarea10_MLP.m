%% Inteligencia Artificial Aplicada - Javier Díaz Mena - 12100
% MLP

clc
clear
close all

%% Training data
num_train = 50; 
% xi = linspace(0,2*pi, num_train);
xi = 2*pi*rand(1, num_train);

for i=1:num_train
    yd(i) = sin(xi(i)) + normrnd(0,0.1);
end

% Test data
num_test = 1000;
xt = linspace(0,2*pi, num_test);
yt_gt = sin(xt); % ground truth

for i=1:num_test
    yt(i) = yt_gt(i) + normrnd(0,0.1);
end

net = feedforwardnet(4);

%% Entrenamos con datos de training y perform con los datos training
net = train(net,xi,yd);
y = net(xt);
% Testeamos con datos de entrenamiento
perf1 = perform(net,xi,yd);

figure
plot(xi,yd,'b.');
hold on;
plot(xt,yt_gt,'r-'); 
plot(xt, y, 'g-');
hold off;

%% Entrenamos con datos de training y perform con los datos test
net = train(net,xi,yd);
y = net(xt);
% Testeamos con datos de test
perf2 = perform(net,xt,yt);

figure
plot(xi,yd,'b.');
hold on;
plot(xt,yt_gt,'r-'); 
plot(xt, y, 'g-');
hold off;

%% Entrenamos con datos de ground truth y perform con datos ground truth
net = train(net,xt,yt_gt);
y = net(xt);
% Testeamos con datos de test
perf3 = perform(net,xt,yt_gt);

figure
plot(xi,yd,'b.');
hold on;
plot(xt,yt_gt,'r-');
plot(xt, y, 'g-');
hold off;

