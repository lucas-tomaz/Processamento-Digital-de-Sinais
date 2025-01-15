# UNIVERSIDADE FEDERAL DO RIO GRANDE DO NORTE
# DEPARTAMENTO DE COMPUTAÇÃO E AUTOMAÇÃO
# PROCESSAMENTO DIGITAL DE SINAIS
# ALUNO: Lucas Tomaz de Moura
# 5° Simulação computacional: Implementação de DFT e FFT.

% Parâmetros do problema
N = 1024;  % Número de pontos para a FFT
M = 150;   % Tamanho do filtro FIR
L = N - M + 1;  % Tamanho do bloco útil

% Comprimento do sinal de entrada (aproximadamente 15.3 * L)
x_length = round(15.3 * L);
x = randn(1, x_length);  % Sinal de entrada com comprimento correto

% Garantir que o comprimento de x não seja múltiplo de L
if mod(length(x), L) == 0
    x = [x, randn(1)];  % Adicionar uma amostra extra
end

h = randn(1, M);  % Filtro FIR aleatório

% Preenchimento inicial com M-1 zeros
x = [zeros(1, M-1), x];

% Número de blocos
num_blocks = ceil((length(x) - (M-1)) / L);

% Inicialização do vetor de saída
y = zeros(1, length(x) + M - 1);

% FFT do filtro
H = fft(h, N);

% Processar os blocos
for i = 1:num_blocks
    % Índices do bloco atual
    start_idx = (i-1) * L + 1;
    end_idx = min(start_idx + N - 1, length(x));

    % Extrair e zero-padding do bloco
    x_block = x(start_idx:end_idx);
    x_block = [x_block, zeros(1, N - length(x_block))];

    % FFT do bloco
    X_block = fft(x_block, N);

    % Convolução no domínio da frequência
    Y_block = X_block .* H;

    % IFFT para obter saída no domínio do tempo
    y_block = ifft(Y_block, N);

    % Parte útil do bloco (remover os M-1 pontos iniciais)
    useful_part = y_block(M:M+L-1);

    % Índices do vetor de saída
    start_y = (i-1) * L + 1;
    end_y = start_y + length(useful_part) - 1;

    % Verificar os índices de gravação
    disp(['Bloco ', num2str(i), ': start_y = ', num2str(start_y), ', end_y = ', num2str(end_y)]);

    % Armazenar no vetor de saída
    y(start_y:end_y) = useful_part;
end

% Remover o preenchimento inicial do vetor de saída
y = y(M:end);

% Convolução direta no tempo
y_direct = conv(x(M:end), h);

% Ajuste de comprimento para comparação
y_adjusted = y(1:length(y_direct));

% Comparar os resultados
error = norm(y_adjusted - y_direct);
disp(['Erro entre a implementação de FFT e a convolução direta: ', num2str(error)]);

% Diagnóstico: exibir diferença máxima entre os sinais
max_diff = max(abs(y_adjusted - y_direct));
disp(['Diferença máxima: ', num2str(max_diff)]);

% Plotar gráficos para análise
figure;
subplot(2, 1, 1);
plot(y_direct);
title('Resultado da convolução direta');

subplot(2, 1, 2);
plot(y_adjusted);
title('Resultado da convolução usando overlap-save');
