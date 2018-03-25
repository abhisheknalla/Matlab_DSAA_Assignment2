function [] = q1(image)
    img = imread(image);
    figure(1); imshow(img)%,title('Original');
    
    %%%USING INBUILT%%%
    
    %img = rgb2gray(img);
    y = fft2(img);
    F = abs(y);% Get the magnitude
    %Fsh = fftshift(y); % Center FFT
    F = log(abs(F)+1); % Use log, for perceptual scaling, and +1 since log(0) is undefined
    %F = mat2gray(F); % Use mat2gray to scale the image between 0 and 1
    % Display the result
    disp(y);
    figure(2); imshow(F,[]), title('Using inbuilt');
    %test_fft(image);
%%%RECURSIVE CODE%%%%
    
    function x =FFT2_f(x)
        [R,C]=size(x);

        for i=1:R
            y=x(i,:);
            x(i,:)=FFT_f(double(y));
        end

        for j=1:C
            y(1,:)=x(:,j);
            x(:,j)=FFT_f(double(y));
        end

        %%%%%%Display the output%%%%%
        figure(3); imshow((x)),title('Recursive Code Result');

        figure(4);imshow(ifft2(x)),title('Result of IFFT2');
    end


    function [out] = FFT_f(inp)
    
        [r, c] = size(inp);
        total_size = r + c -1;
        if size(inp, 2) == 1
            out = inp;
        else
            inp = double(inp);
            
            f1  = FFT_f(inp(1:2:total_size));
            f2  = FFT_f(inp(2:2:total_size));
                  
            no = size(inp,2);
            
            q   = double(exp((-2*1i*pi/no).*(0:no/2-1)));
            
            out(1:no/2) = (f1 + q.*f2);
            
            out((no/2 )+1:no) = (f1 - q.*f2);
         end 
    end

    image =FFT2_f(img);
end