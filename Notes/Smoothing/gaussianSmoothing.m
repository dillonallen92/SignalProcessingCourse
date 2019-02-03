clear, clc, close all

% Gaussian Smoothing

srate = 1000;
time = 0 : 1/srate : 3;
n = length(time);
p = 15;

noiseamp = 5;

ampl = interp1(rand(p,1) * 30, linspace(1,p,n));
noise = noiseamp * randn(size(time));
signal = noise + ampl;

% Guess the FWHM

fwhm = 25;

% guess the proper k value, also need to plot to compare

k = 50;
gtime = 1000*(-k:k)/srate;

gauswin = exp( - (4*log(2)*gtime.^2) /fwhm^2);

% Check the plot below to make sure the gaussian is where it needs to be
% plot(gtime, gauswin);

% Normalize the gaussian to unit energy

gauswin = gauswin / sum(gauswin);

% Set the filtered signal to the signal (not zeros this time)

filteredSignalG = signal;

for i = k + 1 : n - k - 1;
    filteredSignalG(i) = sum (signal(i-k : i + k) .* gauswin);
end

plot(time, signal, 'b', time, filteredSignalG, 'r', 'linew', 2);