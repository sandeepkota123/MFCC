function [y] = framer(x,N,Fs)

framerate=50;%taking frame width as 50sec
framesteprate=20;%taking framestep width as 20sec
framesmpl=round(framerate*Fs*.001);%calculating the no. of samples in each frame-411(for the values we have taken)
framestep=round(framesteprate*Fs*.001);%calculating the no. of samples for each framestep

n=1:N;
totalitr=round(N/framestep)

for i=0:(totalitr-1)
    
startsmpl=i*framestep;
endsmpl=startsmpl+framesmpl;
if(endsmpl<N)
y(i+1,:)=x(startsmpl+1:endsmpl+1)';
else
y(i+1,:)=[x(startsmpl+1:N)' zeros(1,endsmpl-N+1)];    
end
end

