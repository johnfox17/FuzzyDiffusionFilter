close all;
clear all;
addpath('../data')
addpath('../data/threshold_0_3/')

noisyLena = single(imread('noisyLena.png'));
lena = imread('Lena.png');
lena = rgb2gray(lena);
mssim = [];
PSNR = [];
for iImage = 0:300
    currentImage = table2array(readtable("denoisedImage"+string(iImage)+".csv"));
    [mssim_0, ssim_map_0] = ssim_index(lena, currentImage);
    mssim = [mssim, mssim_0];

    currentPSNR = 10.*log10(255^2/(norm(single(lena(:))-currentImage(:)))^2);
    PSNR = [PSNR, currentPSNR];
end

writematrix(mssim, '../data/threshold_0_3/mssim.csv');
writematrix(PSNR, '../data/threshold_0_3/PSNR.csv');




