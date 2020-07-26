%if u want to save a different audio signal and find out the MFCC
%coefficients, uncomment the below statement

%[y,Fs]=rec_voice()

[y,Fs] = audioread('handel.wav');
frame=200;
% framing the input speech signal
 N=length(y);
figure
t = 0:1/Fs:N/Fs-1/Fs;
plot(t,y)
title('input signal')
xlabel('t(sec)')
ylabel('amplitude')

x=framer(y,N,Fs);
N=length(x(frame,:));

figure
t = 0:1/Fs:N/Fs-1/Fs;
t=t+(frame+1)*.02
plot(t,x(frame,:),'r')
title('200th frame')
xlabel('t(sec)')
ylabel('amplitude')

figure
plot(t,x(frame,:),'r')
hold on
plot(t+0.02,x(frame+1,:),'g')
title('200th and 201st frame')
xlabel('t(sec)')
ylabel('amplitude')

N=length(x(frame,:));
xdft = (fft(x(frame,:)));
N = length(x(frame,:));
xdftf=fftshift(xdft);
length(xdft);
% 
%freq = 0:Fs/N:Fs*(1-1/N);
k=-N/2:N/2-1;
freq=(Fs/N)*k;
figure
plot(freq,abs(xdftf));
grid on
xlabel('Frequency (Hz)')
title('DFT Using FFT')
ylabel('X(k)')

xdft1 = xdft(1:N/2+1);
psdx = (1/(2*pi*N)) * abs(xdft1).^2;
psdx(2:end-1) = 2*psdx(2:end-1);
freq = 0:Fs/N:Fs/2;

figure
plot(freq,psdx)
grid on
title('Periodogram Using FFT')
xlabel('Frequency (Hz)') 
ylabel('Power/Frequency')


% 
% 
% finding mel filterbanks frequencies


lowerf=20;%taking lowest frequency as 20Hz
highf=2000;%taking highest frequency as 20KHz
mellowerf=mel(lowerf);
melhighf=mel(highf);

% dif=melhighf-mellowerf;

figure
melrange=linspace(mellowerf,melhighf,28);
plot(melrange);
figure
imelrange=imel(melrange);
plot(imelrange);

% appltying mel filterbanks on the periodogram
 for n= 1:26
%  %n=10;
     y=filtergenerator(imelrange(n),imelrange(n+1),imelrange(n+2),N,Fs);
    filteredoutput(n,:)=y.*(psdx);%applying filterbanks on the periodogram of the frame
    
figure

subplot(3,1,1) 
plot(freq,filteredoutput(n,:))
title('Filtered Periodogram')
xlabel('Frequency (Hz)') 
ylabel('spectrum')


subplot(3,1,2)
plot(freq,psdx)
title('Periodogram')
xlabel('Frequency (Hz)') 
ylabel('spectrum')
% 
% 
subplot(3,1,3)
plot(freq,y)
title(['Mel Filterbank ' num2str(n)])
xlabel('Frequency (Hz)') 
ylabel('amplitude')
hold on

 end

[CEP,DCTM]=spec2cep(filteredoutput);
for n=1:13
    figure
    plot(freq,CEP(n,:));
    title(['DCT output ' num2str(n)])
   xlabel('Frequency (Hz)') 
   ylabel('Cepstrum')
end
