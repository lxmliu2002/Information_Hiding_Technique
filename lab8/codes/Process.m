function main()
    original = imread('./pic/star_gray.bmp');
    secret = imread('./pic/icon_gray.bmp');
    figure;
    subplot(1, 2, 1);
    imshow(original);
    title('original');
    subplot(1, 2, 2);
    imshow(secret);
    title('secret');
    saveas(gcf, './pic/Process/original_secret.png');

    original_binary = imbinarize(original);
    secret_binary = imbinarize(secret);
    figure;
    subplot(1, 2, 1);
    imshow(original_binary);
    title('original binary');
    subplot(1, 2, 2);
    imshow(secret_binary);
    title('secret binary');
    saveas(gcf, './pic/Process/original_secret_binary.png');

    [m, n] = size(secret_binary);

    original_with_secret = Hide(original_binary, m, n, secret_binary);
    figure;
    imshow(original_with_secret);
    title('original with secret');
    saveas(gcf, './pic/Process/original_with_secret.bmp');

    secret_extracted = Extract(original_with_secret);
    figure;
    imshow(secret_extracted);
    title('secret extracted');
    saveas(gcf, './pic/Process/secret_extracted.bmp');

end

function blackCount = BlackNum(imageMatrix, row, col) 
    [~, n] = size(imageMatrix);
    halfWidth = n / 2;
    positionInRow = (row - 1) * halfWidth + col;
    positionInMatrix = positionInRow * 4 - 3;
    matrixRow = idivide(int32(positionInMatrix), int32(n), "ceil");
    matrixCol = positionInMatrix - (matrixRow - 1) * n;
    blackCount = 0;
    for t = 0 : 3
        if imageMatrix(matrixRow, matrixCol + t) == 0
            blackCount = blackCount + 1;
        end
    end
end

function result = changeToZero(imageMatrix, row, col, tmp)
    [~, n] = size(imageMatrix);
    halfWidth = n / 2;
    positionInRow = (row - 1) * halfWidth + col;
    positionInMatrix = positionInRow * 4 - 3;
    matrixRow = idivide(int32(positionInMatrix), int32(n), "ceil");
    matrixCol = positionInMatrix - (matrixRow - 1) * n;
    
    if tmp == 1
        rand1 = int8(rand() * 2 + 1);
        rand2 = int8(rand() * 2 + 1);
        while rand1 == rand2
            rand1 = int8(rand() * 2 + 1);
            rand2 = int8(rand() * 2 + 1);
        end

        t = 0;
        for q = 0 : 3
            if imageMatrix(matrixRow, matrixCol + q) == 1
                t = t + 1;
                if t == rand1 || t == rand2
                    imageMatrix(matrixRow, matrixCol + q) = 0;
                end
            end
        end

    elseif tmp == 2
        randk = int8(rand() + 1);
        t = 0;
        for q = 0 : 3
            if imageMatrix(matrixRow, matrixCol + q) == 1
                t = t + 1;
                if t == randk
                    imageMatrix(matrixRow, matrixCol + q) = 0;
                end
            end
        end

    elseif tmp == 4
        randk = int32(rand() * 3);
        imageMatrix(matrixRow, matrixCol + randk) = 1;
    end
    
    result = imageMatrix;
end

function result = changeToOne(imageMatrix, row, col, tmp)
    [~, n] = size(imageMatrix);
    halfWidth = n / 2;
    positionInRow = (row - 1) * halfWidth + col;
    positionInMatrix = positionInRow * 4 - 3;
    matrixRow = idivide(int32(positionInMatrix), int32(n), "ceil");
    matrixCol = positionInMatrix - (matrixRow - 1) * n;
    
    if tmp == 0
        randk = int32(rand() * 3);
        imageMatrix(matrixRow, matrixCol + randk) = 0;

    elseif tmp == 2
        randk = int8(rand() + 1);
        t = 0;
        for q = 0 : 3
            if imageMatrix(matrixRow, matrixCol + q) == 0
                t = t + 1;
                if t == randk
                    imageMatrix(matrixRow, matrixCol + q) = 1;
                end
            end
        end

    elseif tmp == 3
        rand1 = int8(rand() * 2 + 1);
        rand2 = int8(rand() * 2 + 1);
        while rand1 == rand2
            rand1 = int8(rand() * 2 + 1);
            rand2 = int8(rand() * 2 + 1);
        end

        t = 0;
        for q = 0 : 3
            if imageMatrix(matrixRow, matrixCol + q) == 0
                t = t + 1;
                if t == rand1 || t == rand2
                    imageMatrix(matrixRow, matrixCol + q) = 1;
                end
            end
        end

    end
    result = imageMatrix;
end

function result = Hide(imageMatrix, numRows, numCols, secretMatrix)
    for i = 1 : numRows
        for j = 1 : numCols
            blackCount = BlackNum(imageMatrix, i, j);
            if secretMatrix(i, j) == 0
                if blackCount == 1 || blackCount == 2 || blackCount == 4
                    imageMatrix = changeToZero(imageMatrix, i, j, blackCount);
                end
            elseif secretMatrix(i, j) == 1
                if blackCount == 0 || blackCount == 2 || blackCount == 3
                    imageMatrix = changeToOne(imageMatrix, i, j, blackCount);
                end
            end
        end
    end

    result = imageMatrix;
end

function result = Extract(originalWithSecret)
    [m, n] = size(originalWithSecret); 
    result = zeros(m / 2, n / 2);

    for i = 1 : m / 2
        for j = 1 : n / 2
            blackCount = BlackNum(originalWithSecret, i, j);
            if blackCount == 1
                result(i, j) = 1;
            elseif blackCount == 3
                result(i, j) = 0;
            elseif blackCount == 0
                result(i, j) = 0;
            elseif blackCount == 4
                result(i, j) = 1;
            end
        end 
    end
end
