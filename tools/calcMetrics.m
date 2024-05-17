close all;
clear all;
thresholds = ["threshold_0.01/","threshold_0.02/","threshold_0.03/","threshold_0.05/","threshold_0.08/","threshold_0.09/",...
    "threshold_0.1/","threshold_0.15/","threshold_0.2/","threshold_0.25/","threshold_0.3/","threshold_0.35/"];

addpath('../data/simData/')

noisyLena = single(imread('noisyLena.png'));
lena = imread('Lena.png');
lena = rgb2gray(lena);
for iThreshold = 1:length(thresholds)
    pathToImage = '../data/output/' + thresholds(iThreshold);
    mssim = [];
    PSNR = [];
    for iImage = 0:300
        
        currentImage = table2array(readtable(pathToImage+"denoisedImage"+string(iImage)+".csv"));
        [mssim_0, ssim_map_0] = ssim_index(lena, currentImage);
        mssim = [mssim, mssim_0];
    
        currentPSNR = 10.*log10(255^2/(norm(single(lena(:))-currentImage(:)))^2);
        PSNR = [PSNR, currentPSNR];
    end

    writematrix(mssim, pathToImage+'mssim.csv');
    writematrix(PSNR, pathToImage+'PSNR.csv');
end




