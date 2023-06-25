% **** Practica 3 Vision por computador *****

close all;
clear;
clc;

%Imagen original
image = imread('shield3.jpg');

% Transformaciones
I = rgb2ntsc(image);
R = I(:,:,1);
G = I(:,:,2);
B = I(:,:,3);
gray1 = rgb2gray(I);

% **** Representacion de las imagenes *****
figure;
subplot(2,3,1); imshow(image);
title('Imagen original')
subplot(2,3,2); imshow(I);
title('NTSC')
subplot(2,3,3); imshow(gray1);
title('Grises_N_T_S_C')
subplot(2,3,4); imshow(R);
title('R_N_T_S_C')
subplot(2,3,5); imshow(G);
title('G_N_T_S_C')
subplot(2,3,6); imshow(B);
title('B_N_T_S_C')

% ***** Histogramas *****
figure;
subplot(4,1,1)
imhist(R)
title('Histograma R_N_T_S_C')

subplot(4,1,2)
imhist(G)
title('Histograma G_N_T_S_C')

subplot(4,1,3)
imhist(B)
title('Histograma B_N_T_S_C')

subplot(4,1,4)
imhist(gray1)
title('Histograma Gray_N_T_S_C')

% ***** Binarización (Blanco y negro) *****
BW_gray = imbinarize(gray1, 0.1); % indicar valor/abscisa maxima
BW2_gray = imbinarize(gray1);
BW_R = imbinarize(R, 0.5);
BW2_R = imbinarize(R);

figure;
subplot(2,2,1);
imshow(BW_gray);
title('Binarización de Grises a mano');

subplot(2,2,2);
imshow(BW_R);
title('Binarizacion del canal R a mano');

subplot(2,2,3);
imshow(BW2_gray);
title('Binarizacion Otsu de Grises');

subplot(2,2,4);
imshow(BW2_R);
title('Binarizacion Otsu del canal R');

% ***** Adicion y filtrado de ruido *****

% Ruido salt%pepper (aleatorio)
J = imnoise(R, 'salt & pepper', 0.02);

% Filtros de la media y la mediana para Ruido salt&pepper
KaverageJ = filter2( fspecial('average', 3), J );
KmedianJ = medfilt2(J);

%Ruido gaussiano
noise_dev = 0.1;
ruido_gauss = noise_dev*randn(size(R));
J3 = imadd(double(R), ruido_gauss);

%Filtros de la media y la mediana para Ruido Gaussiano
KaverageJ3 = filter2( fspecial('average', 3), J3 );
KmedianJ3 = medfilt2(J3);

figure;
subplot(2,3,1); imshow(J);
title('R_N_T_S_C con Ruido salt&pepper')

subplot(2,3,2); imshow(KaverageJ)
title('Ruido salt&pepper con Filtro de la media')

subplot(2,3,3); imshow(KmedianJ)
title('Ruido salt&pepper Filtro de la mediana')

subplot(2,3,4); imshow(J3);
title('R_N_T_S_C con Ruido Gaussiano')

subplot(2,3,5); imshow(KaverageJ3)
title('Ruido gaussiano con Filtro de la media ')

subplot(2,3,6); imshow(KmedianJ3)
title('Ruido gaussiano con Filtro de la mediana')
