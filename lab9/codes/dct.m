function main()

    clc;
    clear all;
    close all;

    original_img = (imread('./pic/icon_gray.bmp'));
    secret_img = imbinarize(imread('./pic/star_gray.bmp'));

    figure();
    original_img = imresize(original_img, [256, 256]);
    imshow(original_img);
    imwrite(original_img, './pic/DCT/original.bmp');

    figure();
    secret_img = imresize(~secret_img, [32,32]);
    imshow(secret_img);
    imwrite(secret_img, './pic/DCT/reverse_secret.bmp');

    original_img = double(original_img) / 256;
    secret_img = im2double(secret_img);

    figure();
    with_secret_img = Hide(original_img, secret_img);
    imshow(with_secret_img);
    imwrite(with_secret_img, './pic/DCT/with_secret.bmp');

    figure();
    extract_img = Extract(with_secret_img, original_img);
    imshow(extract_img);
    imwrite(extract_img, './pic/DCT/extract.bmp');

end

function result = Hide(original_img, secret_img)

    size = 256;
    width = 8;
    blocks = size / width;
    result = zeros(size);

    for i = 1 : blocks
        for j = 1 : blocks
            x = (i - 1) * width + 1;
            y = (j - 1) * width + 1;

            tmp_img = original_img(x : (x + width - 1), y : (y + width - 1));
            tmp_img = dct2(tmp_img);

            if secret_img(i, j) == 0
                a = -1;
            else
                a = 1;
            end

            tmp_img(1, 1) = (0.001 * a) + tmp_img(1, 1) * (1 + 0.001 * a);
            tmp_img = idct2(tmp_img);
            result(x : (x + width - 1), y : (y + width - 1)) = tmp_img;

        end
    end

end

function result = Extract(with_secret_img, original_img)

    size = 256;
    width = 8;
    blocks = size / width;

    result = ones(32);

    for i = 1 : blocks
        for j = 1 : blocks
            x = (i - 1) * width + 1;
            y = (j - 1) * width + 1;

            if with_secret_img(x, y) > original_img(x, y)
                result(i, j) = 1;
            else
                result(i, j) = 0;
            end

        end
    end

end