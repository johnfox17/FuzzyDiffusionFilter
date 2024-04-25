clear all;
close all;

addpath('../data/')
lena = imread('Lena.png');
lena = rgb2gray(lena);

figure; imagesc(lena)
colormap gray

Dx = table2array(readtable("Dx.csv"));
figure; imagesc(reshape(Dx, [512 512]))
colormap gray;

Dy = table2array(readtable("Dy.csv"));
figure; imagesc(reshape(Dy, [512 512]))
colormap gray;

figure; imagesc(reshape(Dx+Dy, [512 512]))
colormap gray;



figure; imagesc(reshape(image(:,1), [514 514]).')
colormap gray

figure; imagesc(reshape(image(:,2), [514 514]).')
colormap gray
% denoisedImages0 = table2array(readtable("denoisedImages0.csv"));
%denoisedImages1 = table2array(readtable("denoisedImages230.csv"));
localSmoothness0 = table2array(readtable("localSmoothness0.csv"));
% localSmoothness11 = table2array(readtable("localSmoothness11.csv"));
% localSmoothness12 = table2array(readtable("localSmoothness90.csv"));

% 
figure; imagesc(reshape(denoisedImages0, [512 512]).')
colormap gray
figure; surf(reshape(denoisedImages0, [512 512]).')

figure; imagesc(reshape(denoisedImages1, [512 512]).')
colormap gray
figure; surf(reshape(denoisedImages1, [512 512]).')

figure; imagesc(reshape(localSmoothness0-localSmoothness1, [512 512]).')
% 
% figure; imagesc(reshape(localSmoothness10, [512 512]).')
% colormap gray
% 
% figure; imagesc(reshape(localSmoothness11, [512 512]).')
% colormap gray
% 
% figure; imagesc(reshape(localSmoothness12, [512 512]).')
% colormap gray

% generalAverage = table2array(readtable("generalAverage.csv"));
% gradient = table2array(readtable("gradient.csv"));
%denoisedImage0 = table2array(readtable("denoisedImages0.csv"));
%denoisedImage500 = table2array(readtable("denoisedImages60.csv"));
%denoisedImage500 = denoisedImage500./max(denoisedImage500);


% figure; imagesc(reshape(localSmoothness, [512 512]).')
% colormap gray
% figure; imagesc(reshape(generalAverage, [512 512]).')
% colormap gray
% 
% 
filteredImage = ones(512*512,1);
filteredImage(localSmoothness0<.35) = 0;
figure; imagesc(reshape(filteredImage, [512 512]).')
colormap gray
% 
% filteredImage = ones(512*512,1);
% filteredImage(generalAverage<.92) = 0;
% figure; imagesc(reshape(filteredImage, [512 512]).')
% colormap gray
% 
% figure; imagesc(reshape(gradient, [512 512]).')
% colormap gray
% figure; surf(reshape(gradient, [512 512]).')


figure; imagesc(reshape(denoisedImage0, [512 512]).')
colormap gray
figure; surf(reshape(denoisedImage0, [512 512]).')


figure; imagesc((reshape(denoisedImage500, [512 512]).'))
colormap gray
figure; surf(reshape(denoisedImage500, [512 512]).')

