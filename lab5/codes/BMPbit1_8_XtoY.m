clc;
clear all;
close all;

figure;
img = imread("./pic/NKU70_gray.jpg");
imshow(img);
title('原图像');
imwrite(img, './pic/BMPbit1_8_XtoY/NKU70_gray.bmp');

for t = 1 : 8
    [m, n] = size(img);
    y = zeros(m, n);
    for i = 1 : m
        for j = 1 : n
            x(i, j) = bitget(img(i, j), t);
        end
    end

    figure;
    imshow(x, []);
    title(['第 ', num2str(t), ' 个位平面']);
    imwrite(x, ['./pic/BMPbit1_8_XtoY/NKU70_gray_', num2str(t), '.bmp']);

    for i = 1 : m
        for j = 1 : n
            y(i, j) = bitset(y(i, j), t, x(i, j));
        end
    end

    figure;
    imshow(y, []);
    title(['第 1 - ', num2str(t), ' 个位平面']);
    imwrite(y, ['./pic/BMPbit1_8_XtoY/NKU70_gray_', num2str(t), '_rebuild.bmp']);
end
