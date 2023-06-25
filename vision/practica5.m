%% Practica 5 - Segmentacion

close all;
clear;
clc;

% Imagenes de los ODIS y escala de grises
shield = imread('shield3.jpg');
gray_shield = rgb2gray(shield);
inverse_gray_shield = uint8(255) - gray_shield;

odis = imread('ODIS.jpg');
gray_odis = rgb2gray(odis);
inverse_gray_odis = uint8(255) - gray_odis;

% Representacion
img1 = figure('units','normalized','outerposition',[0 0 1 1]);
set(gca,'DefaultTextFontSize',24)
subplot(1,3,1); imshow(shield);
title('ODI original')
subplot(1,3,2); imshow(gray_shield);
title('Escala de Grises')
subplot(1,3,3); imshow(inverse_gray_shield);
title('Escala de Grises Inversa')

img2 = figure('units','normalized','outerposition',[0 0 1 1]);
subplot(1,3,1); imshow(odis);
title('ODI y distractor')
subplot(1,3,2); imshow(gray_odis);
title('ODI y distractor en grises')
subplot(1,3,3); imshow(inverse_gray_odis);
title('ODI y distractor en grises inversos')

% Binarizacion
bin_shield = imbinarize(inverse_gray_shield);
bin_odis = imbinarize(inverse_gray_odis);

% Rellenar huecos
filled_shield = imfill(bin_shield, 'holes');
filled_odis = imfill(bin_odis, 'holes'); 

% Representacion
img3 = figure('units','normalized','outerposition',[0 0 1 1]);
subplot(1,2,1); imshow(bin_shield);
title('ODI binarizado')
subplot(1,2,2); imshow(filled_shield);
title('Rellenado de huecos')

img4 = figure('units','normalized','outerposition',[0 0 1 1]);
subplot(1,2,1); imshow(bin_odis);
title('ODI y distractor binarizados')
subplot(1,2,2); imshow(filled_odis);
title('Rellenado de huecos con distractor')

%% Propiedades
caract = regionprops(filled_shield, 'all');
caract_odis = regionprops(filled_odis, 'Area', 'BoundingBox', 'Perimeter');

%% Buscar zona de mayor area y zona con mayor compacidad
clc;

% Primero para la imagen del ODI individual
x = size(caract);
n = x(1);     % Numero de elementos del struct de caracteristicas
max_comp1 = 0; % Buscamos compacidad maxima
max_area1 = 0; % Buscamos area maxima
for i = 1:n
    
    % Obtenemos area, perimetro y compacidad del elemento i
    currArea = caract(i).Area;
    currPerim = caract(i).Perimeter;
    comp = currArea/currPerim;
    
    if currArea > max_area1
        max_area1 = currArea;
        index1 = i; % Guardamos el indice del area mas grande
        disp("actualizo area");
    end
    
    if comp > max_comp1
        max_comp1 = comp;
        indice1 = i; % Guardamos el indice del area con mayor compacidad
        disp("actualizo compacidad");
    end
end


% Ahora para la imagen del ODI y el distractor
x = size(caract_odis);
n = x(1);     % Numero de elementos del struct de caracteristicas
max_comp2 = 0; % Buscamos compacidad maxima
max_area2 = 0; % Buscamos area maxima
for i = 1:n
    
    % Obtenemos area, perimetro y compacidad del elemento i
    currArea = caract_odis(i).Area;
    currPerim = caract_odis(i).Perimeter;
    comp = currArea/currPerim;
    
    if currArea > max_area2
        max_area2 = currArea;
        index2 = i; % Guardamos el indice del area mas grande
        disp("actualizo area");
    end
    
    if comp > max_comp2
        max_comp2 = comp;
        indice2 = i; % Guardamos el indice del area con mayor compacidad
        disp("actualizo compacidad");
    end
end



%% Obtenemos coordenadas (Bounding Box)del objeto localizado
% por area o por compacidad
max_areaBB1 = caract(index1).BoundingBox;
max_compBB1 = caract(indice1).BoundingBox;

max_areaBB2 = caract_odis(index2).BoundingBox;
max_compBB2 = caract_odis(indice2).BoundingBox;

% Representamos sobre la imagen binarizada y sin huecos y sobre ella
% pintamos un rectangulo para localizarla
img5 = figure('units','normalized','outerposition',[0 0 1 1]);
imshow(filled_shield)
title('ODI identificado')
hold on
rectangle('Position',max_areaBB1,'EdgeColor','g','LineWidth', 2)

img6 = figure('units','normalized','outerposition',[0 0 1 1]);
imshow(filled_odis)
title('ODI identificado frente a distractor')
hold on
% axis on
% plot(max_areaBB, 'bo');
% plot(max_compBB,'ro');
rectangle('Position',max_areaBB2,'EdgeColor','g','LineWidth', 2)
rectangle('Position',max_compBB2,'EdgeColor','r','LineWidth', 2)

%% Guardamos las figuras para el documento

saveas(img1, "images_practica5/1_originales_y_grises.jpeg");
saveas(img2, "images_practica5/2_distractor_y_grises.jpeg");
saveas(img3, "images_practica5/3_binarizacion_y_huecos.jpeg");
saveas(img4, "images_practica5/4_binarizacion_y_huecos_distractor.jpeg");
saveas(img5, "images_practica5/5_ODI_identificado.jpeg");
saveas(img6, "images_practica5/6_ODI_identificado_distractor.jpeg");
