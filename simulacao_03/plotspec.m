% Fonte: Johnson Jr., C. R. e Sethares, W. A., Telecomunication Breakdown: Concepts of Communication transmitted via Software-Defined Radio, Pearson, 2004
% plotspec(x,Ts) calcula e apresenta o espectro do sinal x
% Ts = tempo (em segundos) entre amostras adjacentes em x

function plotspec(x,Ts)

N=length(x);                               % Comprimento do sinal x
t=Ts*(1:N);                                % vetor de tempo
ssf=(-N/2:N/2-1)/(Ts*N);                   % vetor de frequência
fx=fft(x(1:N));                            % calcula a DFT/FFT
fxs=fftshift(fx);                          % desloca para o centro do espectro
dB = 20*log(abs(fxs));                     % calcula o valor da magnetude em dB
subplot(2,1,1), plot(t,x)                  % apresenta o gráfico da forma de onda
xlabel('segundos'); ylabel('amplitude')    % rotula os eixos
subplot(2,1,2), plot(ssf, dB)              % apresenta o gráfico do espectro de magnitudes
xlabel('frequência (Hz)'); ylabel('magnitude (dB)')  % rotula os eixos
