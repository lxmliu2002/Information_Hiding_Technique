clc;
clear all;
close all;

b = imread("./pic/mario.jpeg"); % 读入图像，像素值在b中
b = rgb2gray(b); % 转换为灰度图像

figure(1);
imshow(b);
title("(a) 原图像");
imwrite(b,"./pic/2DCT/mario.jpeg");


I = im2bw(b);
figure(2);
imshow(I);
title("(b) 二值化图像");
imwrite(I,"./pic/2DCT/mario_bw.jpeg");

c = dct2(I); % 进行离散余弦变换
figure(3);
imshow(c);
title("(c) DCT 变换系数");
imwrite(c,"./pic/2DCT/mario_dct.jpeg");

figure(4);
mesh(c); % 画网格曲面图
title("(d) DCT 变换系数（立体视图）");
saveas(gcf, "./pic/2DCT/mario_mesh.jpeg");