# UNIVERSIDADE FEDERAL DO RIO GRANDE DO NORTE
# DEPARTAMENTO DE COMPUTAÇÃO E AUTOMAÇÃO
# PROCESSAMENTO DIGITAL DE SINAIS
# ALUNO: Lucas Tomaz de Moura
# 4° Simulação computacional: Filtragem de uma amostra de voz com o filtro IIR.
#Parâmetros Escolhidos: N° 7.

#variaveis de controle:
a_1 = 0.1
a_2 = 0.1

freq_ruido_1 = 5700 #5.7 KHz
freq_ruido_2 = 6000 #6 KHz

sinal = [];

caminho = 'Teste_de_voz.wav'
[Y_voz, Fs_voz] = audioread(caminho)

N = length(Y_voz);
Ts = 1/Fs_voz
Y_voz = Y_voz(:,1)

for n = 0:(N-1)
        ruido = a_1*cos(2* pi*freq_ruido_1*n*Ts) + a_2*cos(2* pi*freq_ruido_2*n*Ts);
        disp(ruido)
        sinal = [sinal, ruido];
 end

 sinal_total = Y_voz + sinal'

Wp = 2*2300*Ts
Ws = 2*3000*Ts
Gp = 0.1
Gs = 30

[N, w0] = buttord(Wp, Ws, Gp, Gs)

[B,A] = butter(N, 1, 's')

[b,a] = lp2lp_oc(B,A,w0*pi/Ts)

[bt, at] = bilinear(b,a,Ts)

xbutter = filter(bt, at, sinal_total)

arquivo = 'voz_filtrada.wav'
audiowrite(arquivo, xbutter, Fs_voz)

#comandos opcionais para visualização dos expectros e saída de áudio.
#plotspec(xbutter, Ts)
#sound(xbutter, Fs_voz)
