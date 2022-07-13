% Time and Frequency for sample simulation

Ts = 0.001;
fs = 1/Ts;
t = (0:Ts:1);

% Amplitudes, Frequency and Sensitivity Parameters for Waveforms

Am = 1;                          % Message Amplitude
Ac = 1;                          % Carrier Amplitude
fc = 100;                        % Carrier Frequency
ka=[0.5,1,1.5];                  % Amplitude Sensitivity = Modulation Index
fm = 10;                         % Message Frequency

% Message Waveform and Spectrum Plots

mt = Am*cos(2*pi*fm*t);          % Message Signal
ct = Ac*cos(2*pi*fc*t);          % Carrier Signal
ms = fft(mt);                    % Message Spectrum
ms = fftshift(abs(ms));
fms = (0:length(ms)-1)*fs/length(ms);
cs = fft(ct);                    % Carrier Spectrum
cs = fftshift(abs(cs));
fcs = (0:length(cs)-1)*fc/length(cs);
figure();
subplot(4,1,1);
plot(t,mt);
title("Message Signal")
xlabel("Time (t)")
ylabel("Message (t)")
subplot(4,1,2);
plot(t,ct);
title("Carrier Signal")
xlabel("Time (t)")
ylabel("Carrier (t)")
subplot(4,1,3);
plot(fms,ms);
title("Message Spectrum")
xlabel("Frequency (s)")
ylabel("Message (s)")
subplot(4,1,4);
plot(fcs,cs);
title("Carrier Spectrum")
xlabel("Frequency (s)")
ylabel("Message (s)")

% Amplitude Modulation for Resultant Waveforms and their Spectrums

xt1 = Ac*(1+(ka(1)*mt)).*cos(2*pi*fc*t);          % Modulated Signal at modulation index=0.5
xt2 = Ac*(1+(ka(2)*mt)).*cos(2*pi*fc*t);          % Modulated Signal at modulation index=1
xt3 = Ac*(1+(ka(3)*mt)).*cos(2*pi*fc*t);          % Modulated Signal at modulation index=1.5
ms1 = fft(xt1);                                   % Modulated Spectrum at modulation index=0.5
ms2 = fft(xt2);                                   % Modulated Spectrum at modulation index=1
ms3 = fft(xt3);                                   % Modulated Spectrum at modulation index=1.5
ms1 = fftshift(abs(ms1));
ms2 = fftshift(abs(ms2));
ms3 = fftshift(abs(ms3));
fms1 = (0:length(ms1)-1)*fs/length(ms1);
fms2 = (0:length(ms2)-1)*fs/length(ms2);
fms3 = (0:length(ms3)-1)*fs/length(ms3);
figure();
subplot(3,1,1);
plot(t,xt1);
title("Modulated Message Signal at u=0.5")
xlabel("Time (t)")
ylabel("Signal (t)")
subplot(3,1,2);
plot(t,xt2);
title("Modulated Message Signal at u=1")
xlabel("Time (t)")
ylabel("Signal (t)")
subplot(3,1,3);
plot(t,xt3);
title("Modulated Message Signal at u=1.5")
xlabel("Time (t)")
ylabel("Signal (t)")
figure();
subplot(3,1,1);
plot(fms1,ms1);
title("Modulated Message Spectrum at u=0.5")
xlabel("Frequency (s)")
ylabel("Spectrum (s)")
subplot(3,1,2);
plot(fms2,ms2);
title("Modulated Message Spectrum at u=1")
xlabel("Frequency (s)")
ylabel("Spectrum (s)")
subplot(3,1,3);
plot(fms3,ms3);
title("Modulated Message Spectrum at u=1.5")
xlabel("Frequency (s)")
ylabel("Spectrum (s)")

% Amplitude Demodulation Scheme for waveforms and their spectrums

xr1 = amdemod(xt1,fc,fs);                       % Demodulated Signal at modulation index=0.5
xr2 = amdemod(xt2,fc,fs);                       % Demodulated Signal at modulation index=1
xr3 = amdemod(xt3,fc,fs);                       % Demodulated Signal at modulation index=1.5
figure();
subplot(3,1,1);
plot(t,xr1);
title("De-Modulated Message Signal at u=0.5")
xlabel("Time (t)")
ylabel("Signal (t)")
subplot(3,1,2);
plot(t,xr2);
title("De-Modulated Message Signal at u=1")
xlabel("Time (t)")
ylabel("Signal (t)")
subplot(3,1,3);
plot(t,xr3);
title("De-Modulated Message Signal at u=1.5")
xlabel("Time (t)")
ylabel("Signal (t)")
mr1 = fft(xr1);                                 % Demodulated Spectrum at modulation index=0.5
mr2 = fft(xr2);                                 % Demodulated Spectrum at modulation index=1
mr3 = fft(xr3);                                 % Demodulated Spectrum at modulation index=1.5
mr1 = fftshift(abs(mr1));
mr2 = fftshift(abs(mr2));
mr3 = fftshift(abs(mr3));
fmr1 = (0:length(mr1)-1)*fs/length(mr1);
fmr2 = (0:length(mr2)-1)*fs/length(mr2);
fmr3 = (0:length(mr3)-1)*fs/length(mr3);
figure();
subplot(3,1,1);
plot(fmr1,mr1);
title("Demodulated Message Spectrum at u=0.5")
xlabel("Frequency (s)")
ylabel("Spectrum (s)")
subplot(3,1,2);
plot(fmr2,mr2);
title("Demodulated Message Spectrum at u=1")
xlabel("Frequency (s)")
ylabel("Spectrum (s)")
subplot(3,1,3);
plot(fmr3,mr3);
title("Demodulated Message Spectrum at u=1.5")
xlabel("Frequency (s)")
ylabel("Spectrum (s)")