clc;
clear all;
close all;

figure;
img = imread("./pic/NKU70_gray.jpg");
imshow(img);
title('原图像');
imwrite(img, './pic/REMOVEbit1_m/NKU70_gray.bmp');

for t = 1 : 7
    [m, n] = size(img);
    for k = 1 : t
        for i = 1 : m
            for j = 1 : n
                img(i, j) = bitset(img(i, j), k, 0);
            end
        end
    end

    figure;
    imshow(img, []);
    title(['去掉最低 ', num2str(t), ' 个位平面']);
    imwrite(img, ['./pic/REMOVEbit1_m/NKU70_gray_', num2str(t), '.bmp']);
end