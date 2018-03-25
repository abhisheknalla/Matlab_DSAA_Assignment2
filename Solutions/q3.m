function [result] = q3(file,windowsize,stride_len)
    %right=y(:,2); % Right channel

    figure(1);spectrogram(file,windowsize,windowsize-stride_len);title('Using in-built function');

    [rows,cols] = size(file);
    filter = gausswin(windowsize);

    no_of_rows = ceil(rows/(windowsize-stride_len));

    range = [no_of_rows,windowsize];
    i = 1;start = 1;

    while 1

        endindex = start + windowsize - 1;
        if endindex > rows
             break;
        end
        temp = file(start:endindex);
        a = temp.*filter;

        a = abs(fft(a));

        range(i,1:windowsize) = a;

        i = i + 1;

        start = start + windowsize - stride_len;
    end
    yy = log(range(:,1:windowsize/2)); 

    figure(2); imagesc(flipud(yy));title('Using Code');
    % colorbar;
    result = range;
end