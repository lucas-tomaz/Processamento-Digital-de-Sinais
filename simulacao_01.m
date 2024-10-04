caminho = 'Church_Schellingwoude.wav'
[Y, Fs] = audioread(caminho)
Y = Y(:,1)
%sound(Y, Fs) reprodução do audio
t = (0:length(Y)-1) / Fs;
figure;
plot(t, Y);
xlabel('Tempo (s)');
ylabel('Amplitude');
title('Forma de Onda do Áudio');
