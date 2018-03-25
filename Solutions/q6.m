function [] = q6(inp)
    if inp==1
        decode('q6/message1.wav');
    end
    if inp==2
        decode('q6/message2.wav');
    end
    if inp==3
        decode('q6/message3.wav');
    end

    function [] = decode(file)
        %%%READ DATA
        [signal , Fs] = audioread(file);
        figure(1);plot(signal);
        %%%SUBTRACTING MEAN
        signal = signal-mean(signal);
        figure(2);plot(signal);
        %%%TAKING FFT OF EXTRA
        ffty = fft(signal);
        figure(3);plot(ffty);
        [r,c] = size(signal);
        %%%%HALF ROWS OF FFT
        f = ffty(1: r/2);
        figure(4);plot(f);
        %%%%ZEROES FROM 4 TO 1/4th of SIZE OF IMAGE 
        [R, C] = size(f);
        z = size(f);
        parts = zeros(4,R/4);

        for i=1:4
            parts(i,:) = f((i-1)*(R/4)+1:((i*(R/4))));
        end

        minimumVAL = 99999999;

        tanswer = [0,0,0,0];

        fanswer = [0,0,0,0];

        final_freq = zeros(size(signal));
        range = 4;
        for i=0:range-1
            for j=0:range-1
                if j==i
                    continue;                
                end
                for k=0:range-1
                    if i+1==k+1 || j+1==k+1                   
                        continue;
                    end                    
                    for l=0:range-1                    
                        if i+1==l+1 || j+1==l+1 || k+1==l+1                        
                            continue;
                        end

                        % START

                        tanswer = [i+1,j+1,k+1,l+1];
                        
                        for x=0:range-1
                        
                            final_freq((x)*(R/4)+1:(((x+1)*(R/4)))) = (parts(tanswer(x+1),:));
                        
                        end
                        final_freq(z+1:z*2) = flipud(final_freq(1:z))';
                        final_sound = ifft(final_freq);
                        differ = sum(abs(diff(final_sound)));
                        if (differ < minimumVAL)
                            minimumVAL = differ;
                            fanswer = [i+1,j+1,k+1,l+1];
                        end

                        % END

                    end
                end
            end
        end

        for x=0:range-1
            final_freq((x)*(R/4)+1:(((x+1)*(R/4)))) = (parts(fanswer(x+1),:));
        end
        final_freq(z+1:z*2) = flipud(final_freq(1:z))';
        final_sound = ifft(final_freq);
        sound(real(final_sound),Fs);
    end
end