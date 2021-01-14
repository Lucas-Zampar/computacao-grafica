n=0;
clc; %limpa o terminal do Octave
clear; %limpa todas as variáveis 
close all; %fecha todas as janelas do Octave

pkg load image; %carrega o pacote image, documentação: https://wiki.octave.org/Image_package. Pacote necessário para a função imhist() 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FUNÇÕES AUXILIARES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function [media] = calcular_media(matriz)
    %A seguinte função visa calcular a média at
    
    altura= size(matriz,1);
    largura= size(matriz,2);
    soma= 0;
    for i=1:altura,
        for j= 1:largura,
            soma+= matriz(i,j);
        endfor
    endfor
    media= soma/(altura*largura);
endfunction


function [vetor_ordenado] = ordenar_vetor(vetor)
   largura = size(vetor,2);
    for i = 1:largura-1,
        for j = 1:largura-1,
            if(vetor(j) > vetor(j+1))
                aux = vetor(j+1);
                vetor(j+1) = vetor(j);
                vetor(j) = aux;
            endif
        endfor
    endfor 
    vetor_ordenado = vetor;
endfunction


function [mediana]= calcular_mediana(matriz)
    altura = size(matriz, 1);
    largura = size(matriz, 2);
    vetor = zeros(1,altura*largura);
    ponto_medio = uint8(altura*largura/2);
    count=1;
    for i=1:altura,
        for j=1:largura,
            vetor(1, count) = matriz(i,j);
            count+=1;
        endfor
    endfor
    vetor_ordenado = ordenar_vetor(vetor);
    mediana = vetor_ordenado(ponto_medio);
endfunction


function [moda] = calcular_moda(matriz)
    altura = size(matriz, 1);
    largura = size(matriz, 2);  
    
    count=1;
    for i=1:altura,
      for j=1:largura,
        vetor(1,count) = matriz(i,j);
        count+=1;
      endfor
    endfor
    
    final = altura*largura;
    matriz_auxiliar = [0 0];
    
    count=1;
    for i=1:final,
      if(vetor(1,i) != -1)
        matriz_auxiliar(count,1) = vetor(1,i);
        matriz_auxiliar(count,2) = 1;
        for j=i+1:final, 
          if(vetor(1,j) == vetor(1,i))
            matriz_auxiliar(count,2)+=1;
            vetor(1,j) = -1;
          endif
        endfor
        vetor(1,i) = -1;
        matriz_auxiliar(count,1);
        matriz_auxiliar(count,1);
        count+=1;
      endif 
    endfor
    
    max=1;
    pos=1; 
    for i=1:size(matriz_auxiliar,1),
      if(matriz_auxiliar(i,2) > max)
        max = matriz_auxiliar(i,2);
        pos = i;
      endif
    endfor
    moda= matriz_auxiliar(pos,1);
endfunction


function [maximo] = calcular_maximo(matriz)
    altura = size(matriz, 1);
    largura = size(matriz, 2);	
    maximo = 0;
    for i=1:altura,
        for j=1:largura,
          if( matriz(i,j) > maximo)
            maximo = matriz(i,j);
          endif
        endfor
    endfor	
endfunction


function [minimo] = calcular_minimo(matriz)
    altura = size(matriz, 1);
    largura = size(matriz, 2);	
    minimo = 255;
    for i=1:altura,
        for j=1:largura,
          if( matriz(i,j) < minimo)
            minimo = matriz(i,j);
          endif
        endfor
    endfor	
endfunction

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FUNÇÕES SUAVIZAÇÃO %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function [imagem_suavizada] = suavizar_media(imagem, ordem_mascara)


  [altura, largura, canal] = size(imagem);
  final_linha = altura-ordem_mascara + 1;
  final_coluna = largura-ordem_mascara + 1; 
  passo_recorte = ordem_mascara-1;
  imagem = double(imagem); 
  
  for i= 1:final_linha, 
    for j= 1:final_coluna,
      for k= 1:canal, 
        matriz_recorte = imagem(i:i+passo_recorte, j:j+passo_recorte, k);
        imagem_suavizada(i,j,k) = calcular_media(matriz_recorte);
      endfor
    endfor
  endfor
  imagem_suavizada = uint8(imagem_suavizada);
endfunction


function [imagem_suavizada] = suavizar_mediana(imagem, ordem_mascara) 
  [altura, largura, canal] = size(imagem);
  imagem_suavizada = zeros(altura, largura, canal);
  
  final_linha = altura-ordem_mascara+1;
  final_coluna = largura-ordem_mascara+1; 
  passo_recorte  = ordem_mascara-1;
  
  for i= 1: final_linha, 
    for j= 1: final_coluna,
      for k= 1:canal, 
        matriz_recorte = imagem(i:i+passo_recorte, j:j+passo_recorte, k); 
        imagem_suavizada(i,j,k) = calcular_mediana(matriz_recorte);
      endfor
    endfor
  endfor
  imagem_suavizada = uint8(imagem_suavizada);
endfunction


function [imagem_suavizada] = suavizar_moda(imagem, ordem_mascara)
  [altura, largura, canal] = size(imagem);
  final_linha = altura-ordem_mascara + 1;
  final_coluna = largura-ordem_mascara + 1; 
  passo_recorte = ordem_mascara-1;
   
  for i= 1:final_linha, 
    for j= 1:final_coluna,
      for k= 1:canal, 
        matriz_recorte = imagem(i:i+passo_recorte, j:j+passo_recorte, k);
        imagem_suavizada(i,j,k) = calcular_moda(matriz_recorte);
      endfor
    endfor
  endfor
  imagem_suavizada = uint8(imagem_suavizada);
endfunction


function [imagem_suavizada] = suavizar_maximo(imagem, ordem_mascara)
  [altura, largura, canal] = size(imagem);
  final_linha = altura-ordem_mascara + 1;
  final_coluna = largura-ordem_mascara + 1; 
  passo_recorte = ordem_mascara-1;

  for i= 1:final_linha, 
    for j= 1:final_coluna,
      for k= 1:canal, 
        matriz_recorte = imagem(i:i+passo_recorte, j:j+passo_recorte, k);
        imagem_suavizada(i,j,k) = calcular_maximo(matriz_recorte);
      endfor
    endfor
  endfor
  imagem_suavizada = uint8(imagem_suavizada);
endfunction


function [imagem_suavizada] = suavizar_minimo(imagem, ordem_mascara)
  [altura, largura, canal] = size(imagem);
  final_linha = altura-ordem_mascara + 1;
  final_coluna = largura-ordem_mascara + 1; 
  passo_recorte = ordem_mascara-1;

  for i= 1:final_linha, 
    for j= 1:final_coluna,
      for k= 1:canal, 
        matriz_recorte = imagem(i:i+passo_recorte, j:j+passo_recorte, k);
        imagem_suavizada(i,j,k) = calcular_minimo(matriz_recorte);
      endfor
    endfor
  endfor
  imagem_suavizada = uint8(imagem_suavizada);
endfunction


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FUNÇÕES IMPRESSÃO %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function imprimir_imagens(imagem_inicial, imagem_final, numero_figura, metodo_estatistico, ordem_mascara)
    %A seguinte função visa gerar uma figura que exibe o comparativo entre a imagem inicial e a imagem final após a aplicação do controle de limiar
    %Para tanto, a função deve receber a imagem inicial (imagem_inicial), a imagem final (imagem_final), o número que se deseja atribuir a figura (numero_figura) e a letra da questão em si (letra_questao)
    %
    
    titulo_imagem_inicial = 'IMAGEM ORIGINAL'; %string relativa ao título da imagem inicial
    titulo_imagem_final = 'SUAVIZAÇÃO POR '; %string relativa ao título da imagem final
    
    figure(numero_figura) % gera uma figura
    subplot(121) %plot da imagem na grid da figura na primeira linha e na primeira coluna
    imshow(imagem_inicial) %imprimie imagem inicial
    title(titulo_imagem_inicial) %adiciona título a imagem inicial ao concatenar a string do título com a letra da questão
    subplot(122) %plot da imagem na grid da figura na primeira linha e na segunda coluna
    imshow(imagem_final) %imprimie imagem final
    title(cstrcat(titulo_imagem_final, metodo_estatistico,' - MÁSCARA ', ordem_mascara,' X ',ordem_mascara)) %adiciona título a imagem inicial ao concatenar a string do título com a letra da questão
    
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


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% APLICAÇÃ0 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

caminho = './Imagens/baboon_ruido_01.png';
imagem_ruido = imread(caminho);
imagem_suavizada = suavizar_media(imagem_ruido,3); 
imprimir_imagens(imagem_ruido, imagem_suavizada, 1, 'MÉDIA', '3');
imprimir_histogramas(imagem_ruido, imagem_suavizada, 2);

































