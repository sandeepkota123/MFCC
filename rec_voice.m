function [x,Fs] = rec_voice()
%this function is for recording an audio signal
clear;
recObj = audiorecorder;
disp('Start speaking.')
recordblocking(recObj, 5);
disp('End of Recording.');

 Fs = 8000;
 t = 0:1/Fs:5-1/Fs;
 
play(recObj);
x= getaudiodata(recObj);
load handel.mat
filename = 'handel.wav';
audiowrite(filename,x,Fs);
N = length(x);
end

