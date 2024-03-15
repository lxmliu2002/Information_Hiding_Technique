clc;
clear all;
close all;

b = imread("./pic/mario.jpeg"); % 读入图像，像素值在b中
b = rgb2gray(b); % 转换为灰度图像

figure(1);

imshow(b);
title("(a) 原图像");
imwrite(b,"./pic/2DFT/mario.jpeg");

figure(2);
I = im2bw(b);
imshow(I);
title("(b) 二值化图像");
imwrite(I,"./pic/2DFT/mario_bw.jpeg");


figure(3);
fa = fft2(I); % 使用 fft 函数进行快速傅里叶变换
ffa = fftshift(fa); % fftshift 函数调整 fft 函数的输出顺序，将零频位置移到频谱的中心

imshow(ffa,[200,225]); % 显示灰度在 200 − 255 之间的像
title("(c) 幅度谱");
saveas(gcf, "./pic/2DFT/mario_fft.jpeg");

figure(3);
l = mesh(abs(ffa)); % 画网格曲面图
title("(d) 幅度谱的能量分布");
saveas(gcf, "./pic/2DFT/mario_mesh.jpeg");