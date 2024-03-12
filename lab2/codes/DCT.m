clc;
clear all;
close all;

[a, fs] = audioread('./media/lxmliu2002.wav');
plot(a)
title('Original Signal');

a1 = dct(a(:, 1));
a0 = idct(a1);
subplot(3, 1, 1);
plot(a(:, 1));
title('Original Signal');
subplot(3, 1, 2);
plot(a1);
title('DCT Coefficients');
subplot(3, 1, 3);
plot(a0);
title('Reconstructed Signal');

saveas(gcf, './pic/DCT.png');