clear, clc, close all

% load the mat data

load courseMaterial/emg4TKEO.mat;

%%plot(emgtime, emg)

emgFiltered = emg;

% Vectorized approach to filter the data

emgFiltered(2:end-1) = emg(2:end-1).^2 - emg(1:end-2).*emg(3:end);

% For statement that does the same thing
%for i = 2 : length(emgf) - 1
%    emgf(i) = emg(i).^2 - emg(i-1) .* emg(i+1);
%end

% find our timepoint for reference (0)

time0 = dsearchn(emgtime', 0);

% Create the z-score to plot
emgZ = (emg - mean(emg(1:time0))) / std(emg(1:time0));

emgZFiltered = (emgFiltered - mean(emgFiltered(1:time0))) ... 
    / std(emgFiltered(1:time0));

figure(1), clf 

subplot(211), hold on
plot(emgtime, emg ./ max(emg), 'b', 'linew', 2);
plot(emgtime, emgFiltered ./ max(emgFiltered), 'm', 'linew', 2); 
xlabel('Time (ms)'), ylabel('Amplitude')
legend({'EMG'; 'EMG energy (TKEO)'});

% Plot the zscore stuff
subplot(212), hold on 
plot(emgtime, emgZ, 'b', 'linew', 2);
plot(emgtime, emgZFiltered, 'm', 'linew', 2);
xlabel('time (ms)'), ylabel('Z score relative to pre-stimulus')
legend({'EMG Z Score', 'Filtered EMG Z Score'});