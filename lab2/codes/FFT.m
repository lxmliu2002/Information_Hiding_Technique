clc;
clear all;
close all;

[x, fs] = audioread('./media/lxmliu2002.wav');
fx = fft(x); % fft 函数——快速傅里叶变换


subplot(2, 1, 1);
plot(x);
title('Original Signal');
subplot(2, 1, 2);
plot(abs(fftshift(fx))); % fftshift 函数——将频谱移到中心
title('Frequency Spectrum');

saveas(gcf, './pic/FFT.png');
