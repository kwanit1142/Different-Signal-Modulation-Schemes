% Parameters for Q-3

Am=1;                                % Amplitude of Message Signal
Ac=1;                                % Amplitude of Carrier Signal
N = 1080;                            % Number of Samples
fm = 10;                             % Frequency of Message Signal
fc = 250;                            % Frequency of Carrier Signal
fs = 2*(fc + 2*fm)*10;
f= -fs/2:fs/N:fs/2-fs/N;
t=0:1/fs:(2/fm-1/fs);

% Message, Carrier and Modulated, Demodulated Signals with their Spectrums

m = Am*cos(2*pi*fm*t);               % Message Signal
ms = fft(m);                         % Message Spectrum
ms = fftshift(abs(ms));
fms = (0:length(ms)-1)*fs/length(ms);

c = Ac*cos(2*pi*fc*t);               % Carrier Signal
cs = fft(c);                         % Carrier Spectrum
cs = fftshift(abs(cs));
fcs = (0:length(cs)-1)*fc/length(cs);

s_usb = ssbmod(m,fc,fs,0,"upper");   % SSB-SC Modulated Signal
y_hat = ssbdemod(s_usb,fc,fs,0);     % SSB-SC Demodulated Signal
ft_usb = fft(s_usb);                 % SSB-SC Modulated Spectrum
ft_usb = fftshift(abs(ft_usb));
ft_dem = fft(y_hat);                 % SSB-SC Demodulated Spectrum
ft_dem = fftshift(abs(ft_dem));

figure();
subplot(4,1,1)
plot(t,m);
title("Message Signal")
xlabel("Time (t)")
ylabel("Message (t)")

subplot(4,1,2)
plot(t,c);
title("Carrier Signal")
xlabel("Time (t)")
ylabel("Carrier (t)")

subplot(4,1,3)
plot(t,s_usb);
title("SSB-SC Modulated Message Signal")
xlabel("Time (t)")
ylabel("Signal (t)")

subplot(4,1,4)
plot(t,y_hat);
title("SSB-SC Demodulated Message Signal")
xlabel("Time (t)")
ylabel("Signal (t)")

figure();

subplot(4,1,1)
plot(fms,ms);
title("Message Spectrum")
xlabel("Frequency (s)")
ylabel("Message (s)")

subplot(4,1,2)
plot(fcs,cs);
title("Carrier Spectrum")
xlabel("Frequency (s)")
ylabel("Carrier (s)")

subplot(4,1,3)
plot(f,ft_usb);
title("SSB-SC Modulated Message Spectrum")
xlabel("Frequency (s)")
ylabel("Spectrum (s)")

subplot(4,1,4)
plot(f,ft_dem);
title("SSB-SC Demodulated Message Spectrum")
xlabel("Frequency (s)")
ylabel("Spectrum (s)")