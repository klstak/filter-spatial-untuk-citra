% Daftar nama file gambar
nama_file_gambar = {'p1.jpeg', 'p2.jpeg', 'p3.jpeg', 'p4.jpeg', 'p5.jpeg'};

% Loop untuk memproses setiap gambar
for k = 1:length(nama_file_gambar)
    % Membaca citra
    originalImage = imread(nama_file_gambar{k});
    
    % Mengubah citra ke dalam bentuk grayscale
    grayImage = rgb2gray(originalImage);

    % Menampilkan citra asli
    figure;
    subplot(2, 3, 1);
    imshow(grayImage);
    title(['Citra Asli ', num2str(k)]);

    % 1. Operator Penghalusan (Filter Averaging)
    filterAveraging = fspecial('average', [3 3]);
    resultAveraging = imfilter(grayImage, filterAveraging);
    subplot(2, 3, 2);
    imshow(resultAveraging, []);
    title('Penghalusan (Filter Averaging)');

    % 2. Operator Sharpening (Filter Laplacian)
    filterLaplacian = fspecial('laplacian', 0.5);
    resultSharpening = imfilter(grayImage, filterLaplacian);
    subplot(2, 3, 3);
    imshow(resultSharpening, []);
    title('Sharpening (Filter Laplacian)');

    % 3. Kombinasi Penghalusan dan Sharpening
    resultCombined = grayImage + 0.8 * (grayImage - resultAveraging);
    subplot(2, 3, 4);
    imshow(resultCombined, []);
    title('Kombinasi Penghalusan dan Sharpening');

    % 4. Operator Gaussian untuk Penghalusan
    filterGaussian = fspecial('gaussian', [3 3], 1);
    resultGaussian = imfilter(grayImage, filterGaussian);
    subplot(2, 3, 5);
    imshow(resultGaussian, []);
    title('Penghalusan (Filter Gaussian)');

    % 5. Kombinasi Penghalusan dan Citra Asli
    resultHybrid = 0.6 * grayImage + 0.4 * resultGaussian;
    subplot(2, 3, 6);
    imshow(resultHybrid, []);
    title('Kombinasi Penghalusan dan Citra Asli');

    % Menambahkan metrik - Indeks Ketajaman
    sharpnessIndex = calculateSharpness(grayImage, resultHybrid);
    fprintf('Indeks Ketajaman Citra %d: %.4f\n', k, sharpnessIndex);

    % Menambahkan metrik - PSNR
    psnrValue = psnr(resultHybrid, grayImage);
    fprintf('PSNR Citra %d: %.4f dB\n', k, psnrValue);

    % Menambahkan judul
    sgtitle(['Implementasi Operator Filter Spasial untuk Meningkatkan Kualitas Citra - Gambar ', num2str(k)]);
end
