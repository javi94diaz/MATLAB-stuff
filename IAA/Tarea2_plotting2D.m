%% Inteligencia Artificial Aplicada - Javier Díaz Mena - 12100
% Print p.value using a diferent color for each clase determined in p.class

clc
clear
close all

load data_D2_C3_S1.mat;
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

saveas(img1, "plotting2Ddata.jpeg");
