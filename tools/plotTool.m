clear;
close all;

threshold = "0.02";
addpath('../data/output/threshold_'+threshold)

lena = imread('../data/simData/Lena.png');
lena = rgb2gray(lena);
figure; imagesc(lena)
colormap gray

denoisedImage0 = table2array(readtable("denoisedImage0.csv"));
g0 = table2array(readtable("g0.csv"));
g0 = reshape(g0, [512 512]).';
RHS0 = table2array(readtable("RHS0.csv"));
localSmoothness0 = table2array(readtable("localSmoothness0.csv"));

figure;
tiledlayout(2,2);

ax1 = nexttile;
imagesc(denoisedImage0)
colormap gray
colorbar
title("Lena")

ax2 = nexttile;
imagesc(g0)
title('Gradient ')
colormap gray;
colorbar

ax3 = nexttile;
imagesc(RHS0)
title('Right Hand Side')
colormap gray;
colorbar

ax4 = nexttile;
imagesc(localSmoothness0)
title('Local Smoothness')
colormap gray;
colorbar

linkaxes([ax1 ax2 ax3 ax4])



numInteration = "10";
denoisedImage1 = table2array(readtable("denoisedImage"+numInteration+".csv"));
g1 = table2array(readtable("g"+ numInteration +".csv"));
g1 = reshape(g1, [512 512]).';
RHS1 = table2array(readtable("RHS"+ numInteration +".csv"));
localSmoothness1 = table2array(readtable("localSmoothness" + numInteration +".csv"));


figure;
tiledlayout(2,2);

ax5 = nexttile;
imagesc(denoisedImage0)
colormap gray
title("Lena")
colorbar

ax6 = nexttile;
imagesc(g0)
title('Gradient ')
colormap gray;
colorbar

ax7 = nexttile;
imagesc(RHS0)
title('Right Hand Side')
colormap gray;
colorbar

ax8 = nexttile;
imagesc(localSmoothness0)
title('Local Smoothness')
colormap gray;
colorbar

linkaxes([ax5 ax6 ax7 ax8])



numInteration = "163";
denoisedImage2 = table2array(readtable("denoisedImage"+numInteration+".csv"));
g2 = table2array(readtable("g"+ numInteration +".csv"));
g2 = reshape(g2, [512 512]).';
RHS2 = table2array(readtable("RHS"+ numInteration +".csv"));
localSmoothness2 = table2array(readtable("localSmoothness" + numInteration +".csv"));


figure;
tiledlayout(2,2);

ax9 = nexttile;
imagesc(denoisedImage2)
colormap gray
title("Lena")
colorbar

ax10 = nexttile;
imagesc(g2)
title('Gradient ')
colormap gray;
colorbar

ax11 = nexttile;
imagesc(RHS2)
title('Right Hand Side')
colormap gray;
colorbar

ax12 = nexttile;
imagesc(localSmoothness2)
title('Local Smoothness')
colormap gray;
colorbar

linkaxes([ax9 ax10 ax11 ax12])




