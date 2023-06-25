nc=10; %numero de clases
nmt=10000; %numero total puntos de test

clear matrizconfusion;
matrizconfusion=zeros(nc,nc);
for i=1:nmt
    matrizconfusion(TestLabelsn(i)+1,TestLabelsn(i)+1)=matrizconfusion(TestLabelsn(i)+1,TestLabelsn(i)+1)+1;
end
matrizconfusion

