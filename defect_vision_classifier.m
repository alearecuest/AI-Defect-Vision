% Automatización de inspección óptica con Visión Computacional
clear; clc; close all;

% 1. Crear una imagen sintética de microscopio con defectos
img_fondo = 50 * ones(300, 300, 'uint8');
img_ruido = imnoise(img_fondo, 'gaussian', 0, 0.01);

% Agregar defectos (polvo, puntadas)
img_ruido(50:55, 60:65) = 200; 
img_ruido(200:215, 180:190) = 220; 
img_ruido(120:122, 250:255) = 180;

% 2. Procesamiento de Imagen (Umbralización y Morfología)
umbral = 100;
mascara_defectos = img_ruido > umbral;

% Etiquetado de regiones conectadas
propiedades = regionprops(mascara_defectos, 'Area', 'Centroid', 'BoundingBox');

% 3. Visualización y Reporte
figure('Name', 'Inspección AIT Automatizada', 'Color', 'w');
imshow(img_ruido); hold on;
title(sprintf('Inspección Automática: %d defectos encontrados', length(propiedades)));

for i = 1:length(propiedades)
    centro = propiedades(i).Centroid;
    caja = propiedades(i).BoundingBox;
    area = propiedades(i).Area;
    
    % Dibujar rectángulos alrededor de los defectos
    rectangle('Position', caja, 'EdgeColor', 'r', 'LineWidth', 2);
    text(centro(1)+10, centro(2), sprintf('A: %d px', area), 'Color', 'y', 'FontSize', 10);
end
hold off;