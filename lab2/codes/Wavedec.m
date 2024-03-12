clc;
clear all;
close all;

[a, fs] = audioread('./media/lxmliu2002.wav');
plot(a)
title('Original Signal')

[ca1, cd1] = wavedec(a(:, 1), 1,'db4');
a0 = waverec(ca1, cd1, 'db4');
subplot(4, 1, 1);
plot(a(:, 1));
title('Original Signal')
subplot(4, 1, 2);
plot(cd1);
title('Detail Coefficients')
subplot(4, 1, 3);
plot(ca1);
title('Approximation Coefficients')
subplot(4, 1, 4);
plot(a0);
title('Reconstructed Signal')

saveas(gcf, './pic/Wavedec.png');