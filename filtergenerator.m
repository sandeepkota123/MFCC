    function [y] = filtergenerator(a,c,b,N,Fs)
% this function creates the mel filterbanks by inputing the corresponding frequency values
f = 0:Fs/N:Fs/2;
ua=(f>=a);
umidlow=(f<c);
umidhigh=(f>=c);
rampa=(f-a)/(c-a).*ua.*umidlow;
ub=(f<=b);
rampb=(b-f)/(c-a).*ub.*umidhigh;

 y=1*(rampa+rampb);

end

