clc;
clear all;
close all;

figure;
image = imread('./pic/mario_gray.bmp');
imshow(image);
title('Original Image');
imwrite(image, './pic/HIDEbit/origional.bmp');

figure;
secret = imread('./pic/bird.bmp');
imshow(secret);
title('Secret Image');
imwrite(secret, './pic/HIDEbit/secret.bmp');

[m, n] = size(image);
for i = 1 : m
    for j = 1 : n
        image(i, j) = bitset(image(i, j), 1, secret(i, j));
    end
end

figure;
imshow(image, []);
title('Image with Secret Image');
imwrite(image, './pic/HIDEbit/withSecret.bmp');

[m, n] = size(image);
secretImage = zeros(m, n);
for i = 1 : m
    for j = 1 : n
        secretImage(i, j) = bitget(image(i, j), 1);
    end
end

figure;
imshow(secretImage, []);
title('Extracted Secret Image');
imwrite(secretImage, './pic/HIDEbit/extracted.bmp');