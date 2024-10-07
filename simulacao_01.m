# UNIVERSIDADE FEDERAL DO RIO GRANDE DO NORTE
# DEPARTAMENTO DE COMPUTAÇÃO E AUTOMAÇÃO
# PROCESSAMENTO DIGITAL DE SINAIS
# ALUNO: Lucas Tomaz de Moura
# #1 Simulação computacional: Convolução da soma.

#declaração das variáveis dos caminhos dos arquivos
caminho = 'Church_Schellingwoude.wav'
caminho2 = 'Teste_de_voz.wav'

#criação dos vetores dos dois arquivos de áudios e determinação das frequências de amostragem.
[Y_impulso, Fs_impulso] = audioread(caminho)
[Y_voz, Fs_voz] = audioread(caminho2)

#delimitação apara apenas usar a primeira coluna do vetor do impulso, já que inicialmente ele é estéreo.
Y_impulso = Y_impulso(:,1)

#reprodução dos sons(usado nos testes para validar a transformação em vetores
#sound(Y_impulso, Fs_impulso)
#sound(Y_voz, Fs_voz)

#convolução entre a voz e o impulso.
resultado_convolucao = conv(Y_voz, Y_impulso)

#criação e escrita do arquivo de áudio resultado da convolução.
arquivo = 'convolucao.wav'
audiowrite(arquivo, resultado_convolucao, Fs_voz)
