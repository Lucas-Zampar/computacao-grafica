n=0; 
clc; %limpa o terminal do Octave
clear; %limpa todas as variáveis 
close all; %fecha todas as janelas do Octave

pkg load image; %carrega o pacote image, documentação: https://wiki.octave.org/Image_package. Pacote necessário para a função imhist() 

function imprimir_imagens(imagem_inicial, imagem_final, numero_figura, letra_questao)
    %A seguinte função visa gerar uma figura que exibe o comparativo entre a imagem inicial e a imagem final após a aplicação do controle de limiar
    %Para tanto, a função deve receber a imagem inicial (imagem_inicial), a imagem final (imagem_final), o número que se deseja atribuir a figura (numero_figura) e a letra da questão em si (letra_questao)
    %
    
    titulo_imagem_inicial = 'IMAGEM INICIAL - QUESTÃO '; %string relativa ao título da imagem inicial
    titulo_imagem_final = 'IMAGEM FINAL - QUESTÃO '; %string relativa ao título da imagem final
    
    figure(numero_figura) % gera uma figura
    subplot(121) %plot da imagem na grid da figura na primeira linha e na primeira coluna
    imshow(imagem_inicial) %imprimie imagem inicial
    title(cstrcat(titulo_imagem_inicial, letra_questao)) %adiciona título a imagem inicial ao concatenar a string do título com a letra da questão
    subplot(122) %plot da imagem na grid da figura na primeira linha e na segunda coluna
    imshow(imagem_final) %imprimie imagem final
    title(cstrcat(titulo_imagem_final, letra_questao)) %adiciona título a imagem inicial ao concatenar a string do título com a letra da questão
    
endfunction

function imprimir_histogramas(imagem_inicial, imagem_final, numero_inicial_figura)
    %A seguinte função visa gerar três figuras relativas a cada canal RGB, em que cada figura exibe os histogramas em gráficos de barra da imagem inicial e final após a aplicação do controle de limiar
    %Para tanto, recolheu-se os dados retornados pela função imhist(), presente no pacote image, documentação: https://octave.sourceforge.io/image/function/imhist.html
    %Com base nesses dados, faz-se o plot dos gráficos utilizando a função bar(), define-se o mapa de cores de cada gráfico por colormap() e adiciona-se a legenda com legend()
    %Para tanto, a função deve receber a imagem inicial (imagem_inicial), a imagem final (imagem_final), o número inicial que se deseja atribuir as figura (numero_figura)
    %  
    
    HIST_RED_INICIAL(:,1) = imhist(imagem_inicial(:,:,1),256); %recebe o intervalo de valores do histograma do canal red da imagem inicial para 256 barras
    HIST_RED_FINAL(:,1) = imhist(imagem_final(:,:,1),256); %recebe o intervalo de valores do histograma do canal red da imagem final para 256 barras
    
    HIST_GREEN_INICIAL(:,1) = imhist(imagem_inicial(:,:,2),256); %recebe o intervalo de valores do histograma do canal green da imagem inicial para 256 barras
    HIST_GREEN_FINAL(:,1) = imhist(imagem_final(:,:,2),256); %recebe o intervalo de valores do histograma do canal green da imagem final para 256 barras
    
    HIST_BLUE_INICIAL(:,1) = imhist(imagem_inicial(:,:,3),256); %recebe o intervalo de valores do histograma do canal blue da imagem inicial para 256 barras
    HIST_BLUE_FINAL(:,1) = imhist(imagem_final(:,:,3),256); %recebe o intervalo de valores do histograma do canal blue da imagem final para 256 barras
    
    figure(numero_inicial_figura); %gera uma figura 
    subplot(121); %inicia o plot do gráfico na grid da figura na primeira linha e na primeira coluna
    bar(HIST_RED_INICIAL); %gera o gráfico de barras com base nos dados do histograma para o canal red da imagem inicial
    colormap([1 0 0]); %define as cores do gráfico para vermelho (255,0,0) 
    legend('CANAL RED'); %adiciona a legenda dentro do gráfico 
    title('IMAGEM INICIAL (R)'); %adiciona um título ao gráfico
    subplot(122); %inicia o plot do gráfico na grid da figura na primeira linha e na segunda coluna
    bar(HIST_RED_FINAL); %gera o gráfico de barras com base nos dados do histograma para o canal red da imagem final
    colormap([1 0 0]); %define as cores do gráfico para vermelho (255,0,0) 
    legend('CANAL RED'); %adiciona a legenda dentro do gráfico 
    title('IMAGEM FINAL (R)'); %adiciona um título ao gráfico
    
    figure(numero_inicial_figura+1); %gera uma nova figura
    subplot(121); %inicia o plot do gráfico na grid da figura na primeira linha e na primeira coluna
    bar(HIST_GREEN_INICIAL); %gera o gráfico de barras com base nos dados do histograma para o canal green da imagem inicial
    colormap([0 1 0]); %define as cores do gráfico para verde (0,255,0)
    legend('CANAL GREEN'); %adiciona a legenda dentro do gráfico 
    title('IMAGEM INICIAL (G)');  %adiciona um título ao gráfico
    subplot(122); %inicia o plot do gráfico na grid da figura na primeira linha e na segunda coluna
    bar(HIST_GREEN_FINAL); %gera o gráfico de barras com base nos dados do histograma para o canal green da imagem final
    colormap([0 1 0]); %define as cores do gráfico para green (0,0,255)
    legend('CANAL GREEN'); %adiciona a legenda dentro do gráfico 
    title('IMAGEM FINAL (G)'); %adiciona um título ao gráfico
    
    figure(numero_inicial_figura+2); %gera uma nova figura
    subplot(121); %inicia o plot do gráfico na grid da figura na primeira linha e na primeira coluna
    bar(HIST_BLUE_INICIAL); %gera o gráfico de barras com base nos dados do histograma para o canal blue da imagem inicial
    colormap([0 0 1]); %define as cores do gráfico para azul (0,0,255)
    legend('CANAL BLUE'); %adiciona a legenda dentro do gráfico 
    title('IMAGEM INICIAL (B)'); %adiciona um título ao gráfico
    subplot(122); %inicia o plot do gráfico na grid da figura na primeira linha e na segunda coluna
    bar(HIST_BLUE_FINAL); %gera o gráfico de barras com base nos dados do histograma para o canal blue da imagem final
    colormap([0 0 1]); %define as cores do gráfico para azul (0,0,255)
    legend('CANAL BLUE'); %adiciona a legenda dentro do gráfico 
    title('IMAGEM FINAL (B)'); %adiciona um título ao gráfico
   
endfunction

function [imagem_final] = limiar(imagem_inicial, letra_questao)
  %A seguinte função itera sobre todos os pixels da imagem de entrada a fim de comparar se os valores do respectivo pixel enquadram-se no limiar definido pela questão
  %Caso o valor não se enquadre, este é alterado para zero conforme estabelecido pela questão
  %Para tanto, a função deve receber a imagem inicial (imagem_inicial), a imagem final (imagem_final), bem como a questão ao qual o limiar se refere por meio de letra_questao
  %Por fim, há o retorno da imagem final após a aplicação das operações de controle de limiar
  %
   
  altura = size(imagem_inicial, 1); %define a altura da imagem inicial
  largura = size(imagem_inicial,2); %define a largura da imagem inicial 
  canal = size(imagem_inicial, 3);  %define a quantidade de canais da imagem (3 no caso RGB)
  
  imagem_intermediaria = imagem_inicial; %realiza a cópia da imagem inicial
  
  for i=1:altura %itera sobre cada linha da matriz de pixels (bitmap)
    for j=1:largura %itera sobre cada coluna da matriz de pixels (bitmap)
      for k=1:canal %itera sobre cada canal da imagem inicial
        pixel = imagem_inicial(i,j,k); %armazena o valor do pixel nas posições i,j da grade de pixel e no canal k
        if(letra_questao == 'A' && pixel < 150) %se for a questão A e se o valor de pixel estiver fora do limiar definido (<150)
          imagem_intermediaria(i,j,k) = 0; %altera-se o valor de pixel da posição atual para zero
        elseif(letra_questao == 'B' && pixel > 150) %se for a questão B e se o valor de pixel estiver fora do limiar definido (>150)
          imagem_intermediaria(i,j,k) = 0; %altera-se o valor de pixel da posição atual para zero
        elseif(letra_questao == 'C' && (pixel<50 || pixel>150)) %se for a questão C e se o valor de pixel estiver fora do limiar definido (50<pixel<150)
          imagem_intermediaria(i,j,k) = 0; %altera-se o valor de pixel da posição atual para zero
        endif 
      endfor    
    endfor
  endfor  
  imagem_final = imagem_intermediaria; %retorna a imagem final obtida a partir das operações de limiar sobre a imagem inicial
endfunction

caminho = './Imagens/serrano.png'; %path absoluto Unix para a imagem serrano.png presente no diretório ./Imagens 
imagem_inicial = imread(caminho);  %carrega a imagem definida em caminho
imagem_final = limiar(imagem_inicial, 'A'); %armazena a imagem final retornada pela função limiar()
imprimir_imagens(imagem_inicial, imagem_final, 1, 'A'); %imprime  o comparativo de imagens 
imprimir_histogramas(imagem_inicial, imagem_final, 2); %imprime os histogramas



