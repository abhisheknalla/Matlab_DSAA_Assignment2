load q2/q2.mat
%sound(X, Fs);
fftresult = fft(X);
N = size(X,1);
df = Fs / N;
w = (-(N/2):(N/2)-1)*df;
y = fft(X(:,1), N) / N; 
%y2 = fftshift(y);
figure;
plot(w,abs(y));
%figure(1); plot(fd);
[val, ind] = sort(fftresult);%%%Sorting to get highest frequencies at end of signal

[m,n] = size(fftresult);
%figure(1); plot(fd);
filld = ones(1, m);
filtfd = zeros(1, m);

for i = 1:m
    if i == ind(m)
        disp('flag1');
        filtfd(i) = fftresult(i);
    end
    
    if i == ind(m-1)
        disp('flag2');
        filtfd(i) = fftresult(i);
    end
    
end

filtered_signal = ifft(filtfd);

sound(filtered_signal, Fs);

audiowrite('q2/filtered.wav',filtered_signal ,Fs);
