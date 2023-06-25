%% Inteligencia Artificial Aplicada - Javier Díaz Mena - 12100
% Machine Learning Classification Errors

clc
clear
close all

load data_D2_C2.mat;

[~,N]=size(p.valor);
[D,Nt]=size(t.valor);

% Number of samples (increasing)
ns=10:10:N; 
nt2a = 400;

% Creation and performance of the model
for i=1:length(ns) 
    nsi=ns(i);
    for j=1:nt2a
        ind_rand = randperm(N); 
        ind = ind_rand(1:nsi);
        while (length(find(p.clase(:,ind)==1))<3) ||(length(find(p.clase(:,ind)==2))<3)
            ind_rand = randperm(N); 
            ind = ind_rand(1:nsi);
        end
        % Training and prediction epochs
        bayesModel = fitcnb( p.valor(:,ind)', p.clase(:,ind)');
        bayes_class_train = predict( bayesModel, p.valor(:,ind)' );
        bayes_class_test = predict( bayesModel, t.valor' );
        error_train(j,i) = length(find(bayes_class_train' ~= p.clase(:,ind) ));
        error_test(j,i) = length(find(bayes_class_test' ~= t.clase ));
    end
    error_train_m(i)=mean(error_train(:,i))/nsi;
    error_test_m(i)=mean(error_test(:,i))/Nt;
end

% Plotting errors against number of samples
plot(ns,error_train_m,'b',ns,error_test_m,'g');
legend('train error','test error');
xlabel('# of training samples');



