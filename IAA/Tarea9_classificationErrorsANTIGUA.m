%% Inteligencia Artificial Aplicada - Javier Díaz Mena - 12100
% Machine Learning Classification Errors

clc
clear
close all;
load data_D2_C2;
%%
bayesModel = fitcnb(p.valor',p.clase');

% Number of samples (increases each time)
ns = 5:3:100;

for i = ns
    for j=1:100 % number of tries to average
        ind_rand = randperm(300);
        ind = ind_rand(1:i);
        bayes_class_train = classify( p.valor', bayesModel.X, p.clase ); 
        error_train(j) = length( find( bayes_class_train'~=bayesModel.Y )); 
        bayes_class_test = classify( t.valor', bayesModel.X, t.clase ); 
        error_test(j) = length( find( bayes_class_test'~=bayesModel.Y ));
    end
    error_train_v(i) = mean(error_train)/i;
    error_test_v(i) = mean(error_test)/size(t.valor, 2);
end
%%
figure('Color', [0 1 0]);
plot (ns,error_train_v(ns), 'b'); 
hold on; 
plot (ns,error_test_v(ns),'g'); 
hold off; 
legend('train error', 'test error');
xlabel('# of training samples');
title('Errors');