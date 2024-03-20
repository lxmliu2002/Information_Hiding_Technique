function main()
    img = imread('./pic/star.jpeg');
    img_gray = rgb2gray(img);
    imwrite(img_gray, './pic/star_gray.bmp');

    img = imread('./pic/icon.jpeg');
    img_gray = rgb2gray(img);
    imwrite(img_gray, './pic/icon_gray.bmp');

    figure;
    original = imread('./pic/star_gray.bmp');
    subplot(1, 2, 1);
    imshow(original);
    title('Original Image');
    secret = imread('./pic/icon_gray.bmp');
    subplot(1, 2, 2);
    imshow(secret);
    title('Secret Image');
    saveas(gcf, './pic/Process/original_secret.png');

    secret_binary = imbinarize(secret);
    figure;
    imshow(secret_binary);
    title('Secret Binary Image');
    saveas(gcf, './pic/Process/secret_binary.png');

    [m, n] = size(secret);
    original_with_secret = Hide(original, m, n, secret_binary);
    figure;
    imshow(original_with_secret);
    title('Original Image with Secret Image');
    saveas(gcf, './pic/Process/original_with_secret.png');

    secret_extracted = Extract(original_with_secret);
    figure;
    imshow(secret_extracted);
    title('Extracted Secret Image');
    saveas(gcf, './pic/Process/secret_extracted.png');
end

function result = checksum(x, i, j)
    % 计算特定一维向量的第 m 个区域的最低位的校验和
    temp = zeros(1, 4);
    temp(1) = bitget(x(2 * i - 1, 2 * j - 1), 1); 
    temp(2) = bitget(x(2 * i - 1, 2 * j), 1); 
    temp(3) = bitget(x(2 * i, 2 * j - 1), 1); 
    temp(4) = bitget(x(2 * i, 2 * j ), 1); 
    result = rem(sum(temp), 2); 
end

function result = Hide(x, m, n, y)
    for i = 1 : m 
        for j = 1 : n 
            if checksum(x, i, j) ~= y(i, j)
                random = int8(rand() * 3); 
                switch random
 				    case 0
 					    x(2 * i - 1, 2 * j - 1) = bitset(x(2 * i - 1, 2 * j - 1), 1, ~ bitget(x(2 * i - 1, 2 * j - 1), 1)); 
				    case 1 
 					    x(2 * i - 1, 2 * j) = bitset(x(2 * i - 1, 2 * j), 1, ~ bitget(x(2 * i - 1, 2 * j), 1)); 
				    case 2
 					    x(2 * i, 2 * j - 1) = bitset(x(2 * i, 2 * j - 1), 1, ~ bitget(x(2 * i, 2 * j - 1), 1)); 
                    case 3
 					    x(2 * i, 2 * j) = bitset(x(2 * i, 2 * j), 1, ~ bitget(x(2 * i, 2 * j), 1)); 
                end
            end
        end
    end
    result = x;
end

function result = Extract(original_with_secret)
    [m, n]= size(original_with_secret); 
    secret = zeros(m / 2, n / 2); 
    for i = 1 : m / 2
        for j = 1: n / 2
            secret(i, j) = checksum(original_with_secret, i, j); 
        end 
    end 
    result = secret;
end