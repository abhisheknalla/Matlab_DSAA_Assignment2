function [] = q4(x)

image = imread(x);
figure(1); imshow(image);title('Original');
%%%USING INBUILT%%%
%image = rgb2gray(image );
 xx = fft2(image(:,:,1));
 yy = fft2(image(:,:,2));
 zz = fft2(image(:,:,3));
 y = cat(3,xx,yy,zz);
%F = log(abs(y)+1); % Use log, for perceptual scaling, and +1 since log(0) is undefined
% Display the result
figure(2); imshow(y,[]); title('After FFT');

image = image(:,:,1);
% image = image + 100;

[m, n] = size(image);

output = zeros([m,n]);

for i = [1:m]
    y = image(i,:);
    Y = fft(double(y));
    Y = (fftshift(Y));
    
    rect = zeros(size(Y));
    
    rect(size(Y,2)/2-50:size(Y,2)/2+50) = 1;

    Y1 = Y.*rect;
    
    y_rect = real(ifft(ifftshift(Y1)));

    output(i,:) = y_rect(1,:);
    
end


for i = [1:n]
    y = output(:,i);
    Y = fft(double(y).');
    Y = (fftshift(Y));
    
    rect = zeros(size(Y));
    
    rect(size(Y,2)/2-50:size(Y,2)/2+50) = 1;

    Y1 = Y.*rect;
    
    y_rect = real(ifft(ifftshift(Y1)));

    output(:,i) = y_rect(1,:);
    
end



figure(3);imshow(uint8(output));title('Removed Noise');