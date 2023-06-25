%% Practica 4 Vision por computador

close all;
clear;
clc;

% Imagen original
image = imread('shield3.jpg');

% FT de grises
gray = rgb2gray(image);
F = fft2(gray);
Fs = fftshift(F);
S = abs(Fs);
logF = log(1+S);
img1 = figure('units','normalized','outerposition',[0 0 1 1]);
subplot(1,3,1);
imshow(image);
set(gca,'DefaultTextFontSize',24)
title('Imagen original')
subplot(1,3,2);
imshow(gray)
title('Escala de Grises')
subplot(1,3,3);
imshow(logF, []);
title('FT Escala de Grises')

%% RUIDO ALEATORIO
gray_ruido_aleat = imnoise(gray, 'salt & pepper', 0.02);
F = fft2(gray_ruido_aleat);
Fs = fftshift(F);
S = abs(Fs);
logF = log(1+S);
img2 = figure('units','normalized','outerposition',[0 0 1 1]);
subplot(1,2,1)
imshow(gray_ruido_aleat)
title('Grises + Ruido Aleatorio')
subplot(1,2,2)
imshow(logF, []);
title('FT Grises + Ruido Aleatorio')


% Filtro de la media para Ruido aleatorio
KaverageAleat = filter2( fspecial('average', 2), gray_ruido_aleat );
F = fft2(KaverageAleat);
Fs = fftshift(F);
S = abs(Fs);
logF = log(1+S);
img3 = figure('units','normalized','outerposition',[0 0 1 1]);
subplot(1,2,1)
imshow(rescale(KaverageAleat))
title('Ruido Aleatorio + Filtro de la Media');
subplot(1,2,2)
imshow(logF, []);
title('FT Ruido Aleatorio + Filtro Media');

% Filtro de la mediana para Ruido aleatorio
KmedianAleat = medfilt2(gray_ruido_aleat);
F = fft2(KmedianAleat);
Fs = fftshift(F);
S = abs(Fs);
logF = log(1+S);
img4 = figure('units','normalized','outerposition',[0 0 1 1]);
subplot(1,2,1)
imshow(KmedianAleat)
title('Ruido Aleatorio + Filtro de la Mediana');
subplot(1,2,2)
imshow(logF, []);
title('FT Ruido Aleatorio + Filtro Mediana');


% RUIDO GAUSSIANO
noise_dev = 0.1;
ruido_gauss = noise_dev*randn(size(gray));
gray_ruido_gauss = imadd(double(gray)/255, ruido_gauss);

F = fft2(gray_ruido_gauss);
Fs = fftshift(F);
S = abs(Fs);
logF = log(1+S);
img5 = figure('units','normalized','outerposition',[0 0 1 1]);
subplot(1,2,1)
imshow(gray_ruido_gauss)
title('Gray + Ruido Gaussiano')
subplot(1,2,2)
imshow(logF, []);
title('FT Gray + Ruido Gaussiano')

%Filtro de la media para Ruido Gaussiano
KaverageGauss = filter2( fspecial('average', 2), gray_ruido_gauss );
F = fft2(KaverageGauss);
Fs = fftshift(F);
S = abs(Fs);
logF = log(1+S);
img6 = figure('units','normalized','outerposition',[0 0 1 1]);
subplot(1,2,1)
imshow(rescale(KaverageGauss))
title('Ruido Gaussiano + Filtro de la Media');
subplot(1,2,2)
imshow(logF, []);
title('FT Ruido Gaussiano + Filtro Media');

%Filtro de la mediana para Ruido Gaussiano
KmedianGauss = medfilt2(gray_ruido_gauss);
F = fft2(KmedianGauss);
Fs = fftshift(F);
S = abs(Fs);
logF = log(1+S);
img7 = figure('units','normalized','outerposition',[0 0 1 1]);
subplot(1,2,1)
imshow(rescale(KmedianGauss));
title('Ruido Aleatorio + Filtro de la Mediana');
subplot(1,2,2)
imshow(logF, []);
title('FT Ruido Aleatorio + Filtro Mediana');

% Guardamos las figuras para el documento

saveas(img1, "images_practica4/1_original_y_grises.jpeg");
saveas(img2, "images_practica4/2_grises_aleatorio.jpeg");
saveas(img3, "images_practica4/3_aleatorio_filtro_media.jpeg");
saveas(img4, "images_practica4/4_aleatorio_filtro_mediana.jpeg");
saveas(img5, "images_practica4/5_grises_gaussiano.jpeg");
saveas(img6, "images_practica4/6_gaussiano_filtro_media.jpeg");
saveas(img7, "images_practica4/7_gaussiano_filtro_mediana.jpeg");


