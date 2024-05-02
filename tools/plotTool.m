clear all;
close all;

addpath('../data/')
lena = imread('Lena.png');
lena = rgb2gray(lena);

figure; imagesc(lena)
colormap gray

denoisedImage0 = table2array(readtable("denoisedImage0.csv"));
% denoisedImage0 = 255.*denoisedImage0/max(denoisedImage0(:));
figure; imagesc(denoisedImage0)
% colormap gray;
colorbar
figure; surf(denoisedImage0)

% g0 = table2array(readtable("g0.csv"));
% g0 = reshape(g0, [512 512]).';
% figure; imagesc(g0)
% colormap gray;
% figure; surf(g0)


% RHS0 = table2array(readtable("RHS0.csv"));
% %RHS0 = reshape(RHS0, [512 512]).';
% figure; imagesc(RHS0)
% colormap gray;
% figure; surf(RHS0)


denoisedImage1 = table2array(readtable("denoisedImage51.csv"));
% denoisedImage1 = 255.*denoisedImage1/max(denoisedImage1(:));
% denoisedImage1(denoisedImage1<-255) = -255;
%denoisedImage1 = reshape(denoisedImage1, [512 512]);
figure; imagesc(denoisedImage1)
% colormap gray;
colorbar
figure; surf(denoisedImage1)

% g3 = table2array(readtable("g3.csv"));
% g3 = reshape(g3, [512 512]).';
% figure; imagesc(g3)
% colormap gray;
% figure; surf(g3)


% RHS3 = table2array(readtable("RHS3.csv"));
% %RHS7 = reshape(RHS7, [512 512]);
% figure; imagesc(RHS3)
% colormap gray;
% figure; surf(RHS3)





Dy = table2array(readtable("gY.csv"));
% idx = abs(Dy)~=0 & abs(Dy)<15;
% Dy(idx) = 1;
Dy = reshape(Dy, [512 512]).';
figure; imagesc(Dy)
colormap gray;


grad = Dx+Dy;
figure; histogram(grad(:))
idx = abs(grad)<15;
grad(idx) = 0;
%idx = abs(grad)>=40;
% grad(idx) = 1;



% idx = abs(grad)~=0 & abs(grad)~=1;
% grad(idx) = 0;
figure; imagesc(grad)
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

