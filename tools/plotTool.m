clear all;
close all;

addpath('../data/')

% localSmoothness = table2array(readtable("localSmoothness.csv"));
% generalAverage = table2array(readtable("generalAverage.csv"));
% gradient = table2array(readtable("gradient.csv"));
denoisedImage0 = table2array(readtable("denoisedImages0.csv"));
denoisedImage500 = table2array(readtable("denoisedImages60.csv"));
%denoisedImage500 = denoisedImage500./max(denoisedImage500);


% figure; imagesc(reshape(localSmoothness, [512 512]).')
% colormap gray
% figure; imagesc(reshape(generalAverage, [512 512]).')
% colormap gray
% 
% 
% filteredImage = ones(512*512,1);
% filteredImage(localSmoothness<.92) = 0;
% figure; imagesc(reshape(filteredImage, [512 512]).')
% colormap gray
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

