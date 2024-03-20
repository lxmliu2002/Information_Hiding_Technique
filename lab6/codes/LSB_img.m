function main()
    clc;
    clear all;
    close all;

    figure;
    x = imread('./pic/mario_gray.bmp');
    m = imread('./pic/bird.bmp');
    subplot(1,2,1);
    imshow(x);
    title('Cover Image');
    subplot(1,2,2);
    imshow(m);
    title('Message Image');
    saveas(gcf, './pic/LSB_img/origional.png');

    lsb_watermarked = Hide(x, m);
    Extract(lsb_watermarked);
end

function lsb_watermarked = Hide(cover, message)
    [Mc, Nc] = size(cover);
    lsb_watermarked = uint8(zeros(size(cover)));

    for i = 1 : Mc
        for j = 1 : Nc
            lsb_watermarked(i, j) = bitset(cover(i, j), 1, message(i, j));
        end
    end

    figure;
    imshow(lsb_watermarked);
    title('LSB Watermarked Image');
    saveas(gcf, './pic/LSB_img/lsb_watermarked.png');
end

function Extract(lsb_watermarked)
    [Mw, Nw] = size(lsb_watermarked);
    message = uint8(zeros(size(lsb_watermarked)));

    for i = 1 : Mw
        for j = 1 : Nw
            message(i, j) = bitget(lsb_watermarked(i, j), 1);
        end
    end

    figure;
    imshow(message, []);
    title('Extracted Message Image');
    saveas(gcf, './pic/LSB_img/extracted.png');
end