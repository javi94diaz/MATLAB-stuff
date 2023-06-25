close all
clearvars
clc

load data_D2_C2.mat;
[D,N]=size(p.valor);
[D,Nt]=size(t.valor);
ns=10:10:N;
nt2a=400;
for i=1:length(ns)
    nsi=ns(i);
    for j=1:nt2a
        ind_rand=randperm(N);
        ind=ind_rand(1:nsi);
        while (length(find(p.clase(:,ind)==1))<3)||(length(find(p.clase(:,ind)==2))<3)
            ind_rand=randperm(N);
            ind=ind_rand(1:nsi);
        end
        bayMdl=fitcnb(p.valor(:,ind)',p.clase(:,ind)');
        bayclass_train=predict(bayMdl,p.valor(:,ind)');
        bayclass_test=predict(bayMdl,t.valor');
        error_train(j,i)=length(find(bayclass_train'~=p.clase(:,ind)));
        error_test(j,i)=length(find(bayclass_test'~=t.clase));
    end
    error_train_m(i)=mean(error_train(:,i))/nsi;
    error_test_m(i)=mean(error_test(:,i))/Nt;
end
plot(ns,error_train_m,'b',ns,error_test_m,'g');
legend('train error','test error');
xlabel('# of training samples');