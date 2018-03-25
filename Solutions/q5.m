function [number] = q5(soundData)

    info = audioinfo(soundData);

    samplerate = info.SampleRate;

    signaltime = info.Duration;

    bitsperSample = info.TotalSamples;

    f0 = audioread('q5/0.ogg');
    f1 = audioread('q5/1.ogg');
    f2 = audioread('q5/2.ogg');
    f3 = audioread('q5/3.ogg');
    f4 = audioread('q5/4.ogg');
    f5 = audioread('q5/5.ogg');
    f6 = audioread('q5/6.ogg');
    f7 = audioread('q5/7.ogg');
    f8 = audioread('q5/8.ogg');
    f9 = audioread('q5/9.ogg');
% Reading audio data of digits pressed and performing fft
    fd0 = fft(f0);
    fd1 = fft(f1);
    fd2 = fft(f2);
    fd3 = fft(f3);
    fd4 = fft(f4);
    fd5 = fft(f5);
    fd6 = fft(f6);
    fd7 = fft(f7);
    fd8 = fft(f8);
    fd9 = fft(f9);
% fd = ones(0:10);
% fd(0) = fft(audioread('q5/0.ogg'));
% fd(1) = fft(audioread('q5/1.ogg'));
% fd(2) = fft(audioread('q5/2.ogg'));
% fd(3) = fft(audioread('q5/3.ogg'));
% fd(4) = fft(audioread('q5/4.ogg'));
% fd(5) = fft(audioread('q5/5.ogg'));
% fd(6) = fft(audioread('q5/6.ogg'));
% fd(7) = fft(audioread('q5/7.ogg'));
% fd(8) = fft(audioread('q5/8.ogg'));
% fd(9) = fft(audioread('q5/9.ogg'));
% 

    arr = [fd0, fd1, fd2, fd3, fd4, fd5, fd6, fd7, fd8, fd9];

    number = uint64(0);
    range = 9;
% Reading given audio data for finding number dialed
    for i = 1:signaltime
        yy = [(i-1)*samplerate+1, i*samplerate];
        [sampledata, f] = audioread(soundData, yy);
        
        prev = 0;
        fftresult = fft(sampledata);
        curr = -1;
        
        for j = 0:range
            dotProduct = 0;
        
            dotProduct = dot(fftresult , arr(:,j+1));
            if dotProduct > prev
                prev = dotProduct;
                curr = j;
            
            end
        end
        
        number = number*10 + curr;
        
        disp(number);
    end
end

    