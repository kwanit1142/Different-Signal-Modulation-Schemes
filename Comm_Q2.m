% Parameters for Q-2

t = (0:0.005:1);
f=1./t;
wc = 10^6;                                     % Carrier Frequency in w
fc = wc/(2*pi);                                % Carrier Frequency in Hz
kp  = 1;                                       % Phase Sensitivity Constant

% Message, Carrier and Modulated Signals with their Spectrums

m = 2*cos(100*t) + 18*cos(2000*pi*t);          % Message Signal       
c = 10*cos(wc*t);                              % Carrier Signal
ms = fft(m);                                   % Message Spectrum
ms = fftshift(abs(ms));
fms = (0:length(ms)-1).*f/length(ms);
cs = fft(c);                                   % Carrier Spectrum
cs = fftshift(abs(cs));
fcs = (0:length(cs)-1).*fc/length(cs);
modulated = 10*cos(wc*t + kp*m);               % Modulated Signal
wmod = (wc*t + kp*m);
fmod = wmod/(2*pi);
mods = fft(modulated);                         % Modulated Spectrum
mods = fftshift(abs(mods));
fmods = (0:length(mods)-1).*fmod/length(mods);
figure();
subplot(3,1,1);
plot(t,m);
title("Message Signal")
xlabel("Time (t)")
ylabel("Message (t)")
subplot(3,1,2);
plot(t,c);
title("Carrier Signal")
xlabel("Time (t)")
ylabel("Carrier (t)")
subplot(3,1,3);
plot(t,modulated);
title("Modulated Message Signal at kp=1")
xlabel("Time (t)")
ylabel("Signal (t)")
figure();
subplot(3,1,1);
plot(fms,ms);
title("Message Spectrum")
xlabel("Frequency (s)")
ylabel("Message (s)")
subplot(3,1,2);
plot(fcs,cs);
title("Carrier Spectrum")
xlabel("Frequency (s)")
ylabel("Carrier (s)")
subplot(3,1,3);
plot(fmods,mods);
title("Modulated Message Spectrum at kp=1")
xlabel("Frequency (s)")
ylabel("Signal (s)")