clear all;
close all;

thresholds = ["threshold_0.01/","threshold_0.02/","threshold_0.03/","threshold_0.05/","threshold_0.08/","threshold_0.09/",...
    "threshold_0.1/","threshold_0.15/","threshold_0.2/","threshold_0.25/","threshold_0.3/","threshold_0.35/"];

figure; 
hold on;
for iThreshold = 1:length(thresholds)
    pathToMetrics = '../data/output/' + thresholds(iThreshold);
    mssim = table2array(readtable(pathToMetrics+"mssim.csv"));
    plot(mssim)
end

legend(["threshold 0.01","threshold 0.02","threshold 0.03","threshold 0.05","threshold 0.08","threshold 0.09",...
    "threshold 0.1","threshold 0.15","threshold 0.2","threshold 0.25","threshold 0.3","threshold 0.35"])

xlabel('Time Step')
ylabel('MSSIM')












mssim_0_05_1 = table2array(readtable("../data/output/threshold_0_1/mssim.csv"));
mssim_0_05_2 = table2array(readtable("../data/output2/threshold_0_1/mssim.csv"));
figure; 
plot(mssim_0_05_1, '-o')
hold on;
plot(mssim_0_05_2, '-*')











mssim_0_05 = table2array(readtable("../data/threshold_0_05/mssim.csv"));
mssim_0_08 = table2array(readtable("../data/threshold_0_08/mssim.csv"));
mssim_0_09 = table2array(readtable("../data/threshold_0_09/mssim.csv"));
mssim_0_1 = table2array(readtable("../data/threshold_0_1/mssim.csv"));
mssim_0_2 = table2array(readtable("../data/threshold_0_2/mssim.csv"));
mssim_0_3 = table2array(readtable("../data/threshold_0_3/mssim.csv"));


figure; 
plot(mssim_0_05, '-o')
hold on;
plot(mssim_0_08,'-.')
plot(mssim_0_09,'-.')
plot(mssim_0_1,'-o')
plot(mssim_0_2,'-*')
plot(mssim_0_3,'-^')
grid on;
legend('mssim_0_05','mssim_0_08','mssim_0_09','mssim_0_1','mssim_0_2','mssim_0_3')



psnr_0_05 = table2array(readtable("../data/threshold_0_05/PSNR.csv"));
psnr_0_08 = table2array(readtable("../data/threshold_0_08/PSNR.csv"));
psnr_0_09 = table2array(readtable("../data/threshold_0_09/PSNR.csv"));
psnr_0_1 = table2array(readtable("../data/threshold_0_1/PSNR.csv"));
psnr_0_2 = table2array(readtable("../data/threshold_0_2/PSNR.csv"));
psnr_0_3 = table2array(readtable("../data/threshold_0_3/PSNR.csv"));


figure; 
plot(psnr_0_05, '-o')
hold on;
plot(psnr_0_08,'-.')
plot(psnr_0_09,'-.')
plot(psnr_0_1,'-o')
plot(psnr_0_2,'-*')
plot(psnr_0_3,'-^')
grid on;
legend('psnr_0_05','psnr_0_08','psnr_0_09','psnr_0_1','psnr_0_2','psnr_0_3')
