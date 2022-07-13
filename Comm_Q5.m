% Parameters and Inputs for Q-5

fm = input("Enter the Frequency of Message Signal ==> ");
Am = input("Enter the Amplitude of Message Signal ==> ");
bd = input("Enter the Number of bits ==> ");
fs = 1000*fm;
t = 0:1/fs:1;
m = Am*cos(2*pi*fm*t);                              % Message Signal
a = round(min(m));                                  % Lowest Message Value
b = round(max(m));                                  % Largest Message Value
delta = (b-a)/2.^bd;                                % Quant Size
v_max = b - delta/2;                                % Largest Quant Value
v_min = a + delta/2;                                % Lowest Quant Value
N = length(m);

% Signals and Spectrums Plotting

ms = fft(m);                                        % Message Spectrum
ms = fftshift(abs(ms));
fms = (0:length(ms)-1)*fs/length(ms);

figure()
subplot(2,1,1)
plot(t,m,'k-');
title('Message signal');
xlabel("Time(t)");
ylabel("Message(t)");
subplot(2,1,2)
plot(fms,ms,'k-');
title('Message Spectrum');
xlabel("Frequency(s)");
ylabel("Message(s)");

% Quantizer and Encoder
enc = [];

for i= v_min:delta:v_max
    for j=1:N
        if ((i-delta/2) < m(j)) && (m(j) <= (i+delta/2))
            idx = round((m(j) - v_min)/delta);
            e = de2bi(idx,bd,'left-msb');
            enc = [enc e];
            Xq(j) = i;
        end
    end
end

% Quantized Signal and Spectrum Plotting

xs = fft(Xq);                                % Quantized Spectrum
xs = fftshift(abs(xs));

figure();
subplot(2,1,1);
plot(t,Xq, 'm-')
title('Uniform Quantized signal')
xlabel("Time(t)");
ylabel("Message(t)");
subplot(2,1,2);
plot(fms,xs, 'm-')
title('Uniform Quantized Spectrum')
xlabel("Frequency(s)");
ylabel("Message(s)");

% Quantized Error Plot

figure()
plot(m,m-Xq,'r-')
title('Quantization error')
xlabel("Message (V)");
ylabel("Message Error (V)");

% Polar NRZ : 1 --> +1, 0 --> -1

tb = 0:.1:100;
fb = 1./tb;
for m=1:length(enc)
    if enc(m) == 1
        enc_mapped(m) =1;
    else 
        enc_mapped(m) = -1;
    end
end

i=1;
for j=1:length(tb)
    if tb(j) <= i
        p_nrz(j) = enc_mapped(i);
    else
        i = i + 1;
    end
end

% Signal and Spectrum Plotting, after Polar NRZ Scheme

ps = fft(p_nrz);                                % Polarized NRZ Spectrum
ps = fftshift(abs(ps));
fps = (0:length(ps)-1).*fb/length(ps);

figure()
subplot(2,1,1);
plot(tb,p_nrz)
title('Polar No-Return to Zero Scheme Signal plot')
xlabel("Clock Time (t)");
ylabel("Clock Message (V)");
subplot(2,1,2);
plot(fps,ps)
title('Polar No-Return to Zero Scheme Spectrum plot')
xlabel("Clock Frequency (s)");
ylabel("Clock Message (s)");