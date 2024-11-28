# UNIVERSIDADE FEDERAL DO RIO GRANDE DO NORTE
# DEPARTAMENTO DE COMPUTAÇÃO E AUTOMAÇÃO
# PROCESSAMENTO DIGITAL DE SINAIS
# ALUNO: Lucas Tomaz de Moura
# #3 Simulação computacional: Filtragem de uma amostra de voz com o filtro FIR desenvolvido na parte 1 e 2.
#Parâmetros Escolhidos: N° 7.
  #freq_ruido_1 = 5700 #5.7 KHz
  #freq_ruido_2 = 6000 #6 KHz

#variaveis de controle:
a_1 = 0.1
a_2 = 0.1

sinal = [];
h_valores = [];

caminho = 'Teste_de_voz.wav'
[Y_voz, Fs_voz] = audioread(caminho)

Ts = 1/Fs_voz
Y_voz = Y_voz(:,1)

N = length(Y_voz);

freq_ruido_1 = 5700 #5.7 KHz
freq_ruido_2 = 6000 #6 KHz

for n = 0:(N-1)
    if n == 18
        h = 1 + 0.205 - 0.315;
    else
        freq_1 = (sin(41 / 200 * pi * (n - 18))) / (pi * (n - 18));
        freq_2 = (sin(63 / 200 * pi * (n - 18))) / (pi * (n - 18));
        h = freq_1 - freq_2;
        ruido = a_1*cos(2* pi*freq_ruido_1*n*Ts) + a_2*cos(2* pi*freq_ruido_2*n*Ts);
        disp(ruido)
        disp(h)
    end
        h_valores = [h_valores, h];
        sinal = [sinal, ruido];
 end

sinal_total = Y_voz + sinal'

sinal_filtrado = filter(h_valores',1,sinal_total)

arquivo = 'voz_filtrada.wav'
audiowrite(arquivo, sinal_filtrado, Fs_voz)
sound(sinal_filtrado, Fs_voz)

#plotspec(sinal_filtrado, Ts)
