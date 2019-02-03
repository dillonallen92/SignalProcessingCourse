% Mean Smoothing of a time series

% Create the signal

srate = 1000; % sample rate in Hz
time = 0 : 1/srate : 2;
n = length(time);
p = 15; % number of poles (?)

noiseamp = 5;

ampl = interp1(rand(p,1)*30, linspace(1,p,n));
noise = noiseamp*randn(size(time));
signal = ampl + noise;

filteredSignal = zeros(size(signal));

% Note, the initialization for filtered signal puts 0 at the ends
% to remove any irregularities with the smoothing

% Mean filter
k = 20; % the higher the k, the 'smoother'
for i = k+1 : n-k-1
    filteredSignal(i) = mean(signal(i-k:i+k));
end

% Plot the signals together to see
plot(time, signal, 'b', time, filteredSignal, 'r');




