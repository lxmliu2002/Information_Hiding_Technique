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
    x = zeros(m, n);
    y = zeros(m, n);
    z = zeros(m, n);
    for i = 1 : m
        for j = 1 : n
            x(i, j) = bitget(img(i, j), t);
        end
    end

    figure;
    imshow(x, []);
    title(['第 ', num2str(t), ' 个位平面']);
    imwrite(x, ['./pic/BMPbit1_8_XtoY/NKU70_gray_', num2str(t), '.png']);


    for k = 1 : t
        x = zeros(m, n);

        for i = 1 : m
            for j = 1 : n
                x(i, j) = bitget(img(i, j), k);
            end
        end

        for i = 1 : m
            for j = 1 : n
                y(i, j) = bitset(y(i, j), k, x(i, j));
            end
        end
    end

    figure;
    imshow(y, []);
    title(['第 1 - ', num2str(t), ' 个位平面']);
    imwrite(y, ['./pic/BMPbit1_8_XtoY/NKU70_gray_lo_', num2str(t), '_rebuild.png']);

    for k = t + 1 : 8
        x = zeros(m, n);
        for i = 1 : m
            for j = 1 : n
                x(i, j) = bitget(img(i, j), k);
            end
        end
        for i = 1 : m
            for j = 1 : n
                z(i, j) = bitset(z(i, j), k, x(i, j));
            end
        end
    end

    figure;
    imshow(z, []);
    title(['第 ', num2str(t) + 1, ' - 8 个位平面']);
    imwrite(z, ['./pic/BMPbit1_8_XtoY/NKU70_gray_hi_', num2str(t), '_rebuild.png']);
end
    