# UNIVERSIDADE FEDERAL DO RIO GRANDE DO NORTE
# DEPARTAMENTO DE COMPUTAÇÃO E AUTOMAÇÃO
# PROCESSAMENTO DIGITAL DE SINAIS
# ALUNO: Lucas Tomaz de Moura
# #2 Simulação computacional: Resposta ao impulso e da resposta em frequência do filtro FIR desenvolvido na parte 1.
#Parâmetros Escolhidos: N° 7.
  #freq_ruido_1 = 5700 #5.7 KHz
  #freq_ruido_2 = 6000 #6 KHz

h_valores = [];  % Inicialização da lista h_valores

sinal_valores = [];
#variaveis de controle:
a_1 = 0.5
a_2 = 0.5

#freq_ruido_1 = 5700 #5.7 KHz
#freq_ruido_2 = 6000 #6 KHz
Ts = 1/44100 #período de amostragem

for n = 0:36
    if n == 18
        h = 1 + 0.205 - 0.315;
    else
        freq_1 = (sin(41 / 200 * pi * (n - 18))) / (pi * (n - 18));
        freq_2 = (sin(63 / 200 * pi * (n - 18))) / (pi * (n - 18));
        h = freq_1 - freq_2;
    end

    h_valores = [h_valores, h];  % Adiciona o valor de h na lista h_valores

  end

plotspec(h_valores, Ts)
