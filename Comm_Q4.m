% Parameters for Q-4

fs = 200;
t = 0:1/fs:1;

% Message-1,2 and their Modulated, Demodulated Signals, Spectrums

m1 = 2*cos(2*pi*10*t);                       % Message-1 Signal
m1s = fft(m1);                               % Message-1 Spectrum
m1s = fftshift(abs(m1s));
fm1s = (0:length(m1s)-1)*fs/length(m1s);

m2 = 18*cos(2*pi*20*t);                      % Message-2 Signal
m2s = fft(m2);                               % Message-2 Spectrum
m2s = fftshift(abs(m2s));
fm2s = (0:length(m2s)-1)*fs/length(m2s);

figure();
subplot(4,1,1);
plot(t,m1);
title("Message-1 Signal")
xlabel("Time (t)")
ylabel("Message-1 (t)")
subplot(4,1,2);
plot(t,m2);
title("Message-2 Signal")
xlabel("Time (t)")
ylabel("Message-2 (t)")
subplot(4,1,3);
plot(fm1s,m1s);
title("Message-1 Spectrum")
xlabel("Frequency (s)")
ylabel("Message-1 (s)")
subplot(4,1,4);
plot(fm2s,m2s);
title("Message-2 Spectrum")
xlabel("Frequency (s)")
ylabel("Message-2 (s)")

y = modulate(m1, 90, fs, 'qam', m2);        % Modulated Signal
fftSignal = fft(y);                         % Modulated Spectrum
fftSignal = fftshift(abs(fftSignal));
n = length(t);
f= -fs/2:fs/n:fs/2-fs/n;
z = qamdemod(y.*exp(-1i*pi/32),256);        % Demodulated Signal
fft_demodulated_Signal = fft(z);            % Demodulated Spectrum
fft_demodulated_Signal = fftshift(abs(fft_demodulated_Signal));

figure();
scatter(t, y);
title("Scatter Plot")
xlabel("Time (t)")
ylabel("Signal (t)")

figure();
subplot(4,1,1);
plot(t, y);
title("Modulated Signal")
xlabel("Time (t)")
ylabel("Signal (t)")
subplot(4,1,2);
plot(f, fftSignal);
title("Modulated Spectrum")
xlabel("Frequency (s)")
ylabel("Signal (s)")
subplot(4,1,3);
plot(t, z);
title("Demodul Signal with Offset")
xlabel("Time (t)")
ylabel("Signal (t)")
subplot(4,1,4);
plot(f, fft_demodulated_Signal);
title("Demodulated Spectrum with Offset")
xlabel("Frequency (s)")
ylabel("Message-2 (s)")