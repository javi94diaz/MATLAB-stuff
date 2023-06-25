%% Inteligencia Artificial Aplicada - Javier Díaz Mena - 12100
% Print two different handwritten images of the same number for 4 different numbers.

clc
clear
close all
load Trainnumbers.mat

a = find(Trainnumbers.label==1, 2);
b = find(Trainnumbers.label==6, 2);
c = find(Trainnumbers.label==7, 2);
d = find(Trainnumbers.label==9, 2);
indexes= [a b c d];

figure;
for i = 1:8
    eval( sprintf( "subplot(2,4,%d)", i) );
    eval( sprintf ("digit_display(indexes(%d))", i) );
end
sgtitle('Train Numbers');