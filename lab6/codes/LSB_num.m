function main()
    clc;
    clear all;
    close all;

    figure;
    x = imread('./pic/mario_gray.bmp');
    m = 2112492;
    imshow(x);
    title('Cover Image');
    saveas(gcf, './pic/LSB_num/origional.png');

    lsb_watermarked = Hide(x, m);
    Extract(lsb_watermarked);
end

function lsb_watermarked = Hide(cover, message)
    lsb_watermarked = cover;

    for t = 1 : 30
        s = bitget(message, t);
        lsb_watermarked(1, t) = bitset(cover(1, t), 1, s);
    end

    figure;
    imshow(lsb_watermarked);
    title('LSB Watermarked Image');
    saveas(gcf, './pic/LSB_num/lsb_watermarked.png');
end

function Extract(lsb_watermarked)

    y = zeros(1);
    for t = 1 : 30
        k = bitget(lsb_watermarked(1, t), 1);
        y = bitset(y, t, k);
    end

    disp('Extracted Message:');
    disp(y);
end