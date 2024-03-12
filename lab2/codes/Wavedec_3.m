clc;
clear all;
close all;

[a, fs] = audioread('./media/lxmliu2002.wav');
plot(a)

[c,l]=wavedec(a(:,2),3 ,'db4') ;
ca3=appcoef(c,l,'db4',3) ;
cd3=detcoef(c,l,3) ;
cd2=detcoef(c,l,2) ;
cd1=detcoef(c,l,1) ;
a0=waverec(c,l,'db4') ;

subplot(6, 1, 1);
plot(a(:, 2));
title('Original Signal');
subplot(6, 1, 2);
plot(cd1);
title('Detail Coefficient 1');
subplot(6, 1, 3);
plot(cd2);
title('Detail Coefficient 2');
subplot(6, 1, 4);
plot(cd3);
title('Detail Coefficient 3');
subplot(6, 1, 5);
plot(ca3);
title('Approximation Coefficient 3');
subplot(6, 1, 6);
plot(a0);
title('Reconstructed Signal');

saveas(gcf, './pic/Wavedec_3.png');