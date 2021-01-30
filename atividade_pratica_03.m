n=0;
clear all; 
close all;
clc;

function [imagem_redimensionada] = reduzir_altura(imagem_original)
  #Essa função visa reduzir a altura da imagem 720
  #Para tanto, divide a altura da imagem original em intervalos iguais de amplitude altura/(altura - nova_altura)
  #Para as duas primeiras linhas de cada intervalo, é gerada uma nova linha com a média entre as linhas citadas
  #Essa nova linha será então a primeira linha referente ao respectivo intervalo da imagem redimensionada
  #O intervalo restante é apenas uma cópia do intervalo da imagem original para o intervalo da imagem redimensionada
  #Com isso, a cada média retira-se uma linha da imagem original, a qual é computada
   
  [altura, largura, canal] = size(imagem_original); #armazena as dimensões da imagem original
  nova_altura = 720; #define a nova altura
  amplitude_intervalo = floor(altura/(altura - nova_altura)); #define a amplitude do intervalo
  imagem_redimensionada = zeros(nova_altura, largura, canal); #inicializa-se a imagem redimensionada com valores de pixel nulos 
  contador_linhas_removidas = 0; #conta quantas linhas foram removidas
  indice_linha_inicial_imagem_original = 1;  #indice de linha inicial do intervalo atual da imagem original
   
  while contador_linhas_removidas < altura - nova_altura #enquanto houver linhas para retirar
    for j=1:largura,#itera em cada coluna
      for k=1:canal,#itera em cada canal RGB
        indice_linha_inicial_imagem_redimensionada = indice_linha_inicial_imagem_original - contador_linhas_removidas; #define o índice de linha inicial do intervalo atual da imagem redimensionada
        indice_linha_final_imagem_redimensionada = indice_linha_inicial_imagem_redimensionada + amplitude_intervalo - 2; #define o índice de linha final do intervalo atual da imagem redimensionada
        indice_linha_final_imagem_original = indice_linha_inicial_imagem_original + amplitude_intervalo - 1; #define o índice de linha final do intervalo atual da imagem original
        media = mean([imagem_original(indice_linha_inicial_imagem_original, j, k) imagem_original(indice_linha_inicial_imagem_original+1, j, k)]); #calcula a média entre as duas primeiras linhas do intervalo atual da imagem original
        imagem_redimensionada(indice_linha_inicial_imagem_redimensionada, j, k) = media; #A primeira linha do respectivo intervalo da imagem redimensionada é a média 
        imagem_redimensionada(indice_linha_inicial_imagem_redimensionada+1:indice_linha_final_imagem_redimensionada, j, k) = imagem_original(indice_linha_inicial_imagem_original+2:indice_linha_final_imagem_original, j, k); #Copia o restante dos valores de pixel da imagem original para a imagem redimensionada
      endfor  #fim da iteração de canal RGB
    endfor #fim da iteração de colunas
    contador_linhas_removidas+=1;  #conta uma linha retirada  
    indice_linha_inicial_imagem_original+= amplitude_intervalo; #Segue para o próximo intervalo
  endwhile
  imagem_redimensionada(indice_linha_final_imagem_redimensionada+1:nova_altura, 1:largura, 1:canal) = imagem_original(indice_linha_final_imagem_original+1:altura, 1:largura, 1:canal); #copia os pixels remanescentes
  imagem_redimensionada = uint8(imagem_redimensionada); #representa o bitmap por inteiros 
endfunction

function [imagem_redimensionada] = reduzir_largura(imagem_original)
  #Essa função visa reduzir a largura da imagem para 640
  #Para tanto, divide a largura da imagem original em intervalos iguais de amplitude largura/(largura - nova_largura)
  #Para as duas primeiras colunas de cada intervalo, é gerada uma nova coluna com a média entre as colunas citadas
  #Essa nova coluna será então a primeira coluna referente ao respectivo intervalo da imagem redimensionada
  #O intervalo restante é apenas uma cópia do intervalo da imagem original para o intervalo da imagem redimensionada
  #Com isso, a cada média retira-se uma coluna da imagem original, a qual é computada
   
  [altura, largura, canal] = size(imagem_original); #armazena as dimensões da imagem original
  nova_largura = 640; #define a nova largura
  amplitude_intervalo = floor(largura/(largura - nova_largura)); #define a amplitude do intervalo
  imagem_redimensionada = zeros(altura, nova_largura, canal); #inicializa-se a imagem redimensionada com valores de pixel nulos 
  contador_colunas_removidas = 0; #conta quantas colunas foram removidas
  indice_coluna_inicial_imagem_original = 1;  #indice de coluna inicial do intervalo atual da imagem original
   
  while contador_colunas_removidas < largura - nova_largura #enquanto houver colunas para retirar
    for i=1:altura,#itera em cada linha
      for k=1:canal,#itera em cada canal RGB
        indice_coluna_inicial_imagem_redimensionada = indice_coluna_inicial_imagem_original - contador_colunas_removidas; #define o índice de coluna inicial do intervalo atual da imagem redimensionada
        indice_coluna_final_imagem_redimensionada = indice_coluna_inicial_imagem_redimensionada + amplitude_intervalo - 2; #define o índice de coluna final do intervalo atual da imagem redimensionada
        indice_coluna_final_imagem_original = indice_coluna_inicial_imagem_original + amplitude_intervalo - 1; #define o índice de coluna final do intervalo atual da imagem original
        media = mean([imagem_original(i, indice_coluna_inicial_imagem_original, k) imagem_original(i, indice_coluna_inicial_imagem_original+1, k)]); #calcula a média entre as duas primeiras colunas do intervalo atual da imagem original
        imagem_redimensionada(i, indice_coluna_inicial_imagem_redimensionada, k) = media; #A primeira coluna do respectivo intervalo da imagem redimensionada é a média
        imagem_redimensionada(i, indice_coluna_inicial_imagem_redimensionada+1:indice_coluna_final_imagem_redimensionada, k) = imagem_original(i, indice_coluna_inicial_imagem_original+2:indice_coluna_final_imagem_original, k); #Copia o restante dos valores de pixel da imagem original para a imagem redimensionada
      endfor  #fim da iteração de canal RGB
    endfor #fim da iteração de colunas
    contador_colunas_removidas+=1;  #conta uma coluna retirada  
    indice_coluna_inicial_imagem_original+= amplitude_intervalo; #Segue para o próximo intervalo
  endwhile
  imagem_redimensionada(1:altura, indice_coluna_final_imagem_redimensionada+1:nova_largura, 1:canal) = imagem_original(1:altura, indice_coluna_final_imagem_original+1:largura, 1:canal); #copia os pixels remanescentes
  imagem_redimensionada = uint8(imagem_redimensionada); #representa o bitmap por inteiros
endfunction

function [imagem_redimensionada] = ampliar_altura(imagem_original)
  #Essa função visa ampliar a altura da imagem 720
  #Para tanto leva em consideração a quantidade de linhas a serem adicionadas definida por nova_altura - altura
  #As linhas são adicionadas a cada intervalo cuja amplitude aproximada é definida por altura/(nova_altura - altura)
  #Elas serão adicionadas conforme a iteração ocorre de cima para baixo
  #Os valores de pixel são apenas uma cópia dos mais próximo logo acima
  #Quando não há mais linhas a serem adicionadas, o restante da imagem original é copiada para a imagem redimensionada
  
  [altura, largura, canal] = size(imagem_original); #armazena as dimensões da imagem original
  nova_altura=720;  #define a nova altura
  amplitude_intervalo = floor(altura/(nova_altura - altura)); #amplitude aproximada do intervalo para cada qual é adicionado uma nova linha 
  indice_linha_imagem_redimensionada = 0; #valor do índice de linha na iteração da imagem redimensionada
  indice_linha_imagem_original = 0; #índice de linha da iteração da imagem original
  contador_linhas_inseridas=0; #conta quantas linhas foram adicionadas 
  contador_intervalos=0; #conta quantos intervalos faltam para adicionar uma nova linha
  
  while contador_linhas_inseridas < nova_altura - altura,#enqaunto houver linhas a serem adicionadas
    if contador_intervalos != amplitude_intervalo, #se o não for o momento de adicionar uma nova linha
       indice_linha_imagem_redimensionada +=1; #incrimente o índice de linha da imagem redimensionada
       indice_linha_imagem_original +=1; #incrimente o índice de linha da imagem original
    elseif contador_intervalos == amplitude_intervalo, #se não, se for o momento de adicionar nova linha
       indice_linha_imagem_redimensionada +=1; # incrimente apenas o índice de linha da imagem redimensionada, assim ele copiará o pixel atual da imagme original
       contador_intervalos = -1; #contador de intervalo passa a ser negativo
       contador_linhas_inseridas +=1; #incrementa o contador de linhas 
    endif
    imagem_redimensionada(indice_linha_imagem_redimensionada, 1:largura, 1:canal) = imagem_original(indice_linha_imagem_original, 1:largura, 1:canal); #copia valor de pixel       
    contador_intervalos +=1; # incrementa o contador de intervalos     
  endwhile
  imagem_redimensionada(indice_linha_imagem_redimensionada+1:nova_altura, 1:largura, 1:canal) = imagem_original(indice_linha_imagem_original+1:altura, 1:largura,1:canal); #copia pixels remanescentes
  imagem_redimensionada = uint8(imagem_redimensionada); #representa bitmap por inteiros
endfunction

function [imagem_redimensionada] = ampliar_largura(imagem_original)
  #Essa função visa ampliar a largura da imagem para 640
  #Para tanto leva em consideração a quantidade de colunas a serem adicionadas definida por nova_largura - largura
  #As colunas são adicionadas a cada intervalo cuja amplitude aproximada é definida por largura/(nova_largura - largura)
  #Elas serão adicionadas conforme a iteração ocorre da esquerda para a direita
  #Os valores de pixel são apenas uma cópia dos mais próximo logo a esquerda
  #Quando não há mais colunas a serem adicionadas, o restante da imagem original é copiada para a imagem redimensionada
  
  [altura, largura, canal] = size(imagem_original); #armazena as dimensões da imagem original
  nova_largura=640;  #define a nova largura
  amplitude_intervalo = floor(largura/(nova_largura - largura)); #amplitude aproximada do intervalo para cada qual é adicionado uma nova coluna 
  indice_coluna_imagem_redimensionada = 0; #índice de coluna na iteração da imagem redimensionada
  indice_coluna_imagem_original = 0; #índice de coluna da iteração da imagem original
  contador_colunas_inseridas=0; #conta quantas linhas foram adicionadas 
  contador_intervalos=0; #conta quantos intervalos faltam para adicionar uma nova linha
  
  while contador_colunas_inseridas < nova_largura - largura,#enqaunto houver colunas a serem adicionadas
    if contador_intervalos!= amplitude_intervalo, #se não for o momento de adicionar uma nova coluna
       indice_coluna_imagem_redimensionada +=1; #incrimente o índice de coluna da imagem redimensionada
       indice_coluna_imagem_original +=1; #incrimente o índice de coluna da imagem original
    elseif contador_intervalos == amplitude_intervalo, #se não, se for o momento de adicionar nova coluna
       indice_coluna_imagem_redimensionada +=1; # incrimente apenas o índice de coluna da imagem redimensionada, assim ele copiará o pixel atual da imagme original
       contador_intervalos = -1; #contador de intervalo passa a ser negativo
       contador_colunas_inseridas+=1; #incrementa o contador de colunas inseridas 
    endif
    imagem_redimensionada(1:altura, indice_coluna_imagem_redimensionada, 1:canal) = imagem_original(1:altura, indice_coluna_imagem_original, 1:canal); #copia valor de pixel       
    contador_intervalos +=1; # incrementa o contador de intervalos     
  endwhile
  
  imagem_redimensionada(1:altura, indice_coluna_imagem_redimensionada+1:nova_largura, 1:canal) = imagem_original(1:altura, indice_coluna_imagem_original+1:largura, 1:canal); #copia pixels remanescentes
  imagem_redimensionada = uint8(imagem_redimensionada); #representa bitmap por inteiros 
endfunction


function [imagem_redimensionada] = redimensionar_imagem(imagem_original)
  #A seguinte função visa redimensionar a imagem para a resolução 720x640
  #Para tanto, analisa a necessidade de redução ou ampliação da altura e da largura
  #Após isso, invoca as respectivas funções necessárias a fim de redimensionar a imagem
  
  imagem_redimensionada = imagem_original; #copia a imagem original
  altura = size(imagem_original, 1); #armazena altura da imagem original
  largura = size(imagem_original, 2); #armazena largura da imagem original
  nova_altura = 720; #define nova altura
  nova_largura = 640; #define nova largura
 
  if(largura > nova_largura) #caso seja necessário reduzir a largura
    imagem_redimensionada = reduzir_largura(imagem_redimensionada); #invoca a função de redução da largura
  elseif(largura < nova_largura) #caso seja necessário ampliar a largura
    imagem_redimensionada = ampliar_largura(imagem_redimensionada); #invoca a função de ampliação da largura
  endif #fim da análise da largura
  
  if(altura > nova_altura) #caso seja necessário reduzir a altura
    imagem_redimensionada = reduzir_altura(imagem_redimensionada); #invoca a função de redução da altura
  elseif(altura < nova_altura) # caso seja necessário ampliar a altura
    imagem_redimensionada = ampliar_altura(imagem_redimensionada); # invoca a função de ampliação da altura
  endif #fim ada análise da altura
  #Após aplicar as funções de redimensionamento, a função é encerrada
endfunction


function exibir_comparativo_redimensionamento(imagem_original, imagem_redimensionada, numero_figura)
  #Essa função visa exibir o comparativo dos resultados obtidos do redimensionamento

  altura_original = size( imagem_original, 1); #armazena altura da imagem original
  largura_original = size(imagem_original, 2); #armazena largura da imagem original
  altura_redimensionada = size(imagem_redimensionada, 1); #armazena altura da imagem redimensionada
  largura_redimensionada = size(imagem_redimensionada, 2); #armazena largura da imagem redimensionada
  
  figure(numero_figura); #gera uma figura cujo número será determinado pelo parâmetro numero_figura
  subplot(121); #reserva posição 1 da gridd da figura
  imshow(imagem_original); #imprime imagem original na posição reservada
  title(cstrcat('Imagem original (', int2str(altura_original),'x',int2str(largura_original),')')); #define título
  subplot(122); #reserva posição 2 da grid da figura
  imshow(imagem_redimensionada); #imprime imagem alterada na posição reservada
  title(cstrcat('Imagem redimensionada (', int2str(altura_redimensionada),'x',int2str(largura_redimensionada),')')); #define título
  
endfunction

caminho_tulip = './Imagens/tulip.png'; #caminho absoluto da imagem tulip.png
caminho_serrano = './Imagens/serrano.png'; #caminho relativo da imagem serrano.png
caminho_mountain = './Imagens/mountain.png'; #caminho relativo da imagem mountain.png

imagem_tulip = imread(caminho_tulip); #carrega imagem tulip.png
imagem_serrano = imread(caminho_serrano); #carrega imagem serrano.png
imagem_mountain = imread(caminho_mountain); #carrega imagem mountain.png

imagem_redimensionada = redimensionar_imagem(imagem_mountain); #redimensiona imagem mountain.png
exibir_comparativo_redimensionamento(imagem_mountain, imagem_redimensionada, 1); #imprime comprativo entre imagens
imwrite(imagem_redimensionada,'./mountain_redimensionada.png'); #salva imagem redimensionada com nome mountain_redimensionada.png
imagem_redimensionada = redimensionar_imagem(imagem_tulip); #redimensiona imagem tulip.png
exibir_comparativo_redimensionamento(imagem_tulip, imagem_redimensionada, 2); #imprime comprativo entre imagens
imwrite(imagem_redimensionada,'./tulip_redimensionada.png'); #salva imagem redimensionada com nome tulip_redimensionada.png
imagem_redimensionada = redimensionar_imagem(imagem_serrano); #redimensiona a imagem serrano.png
exibir_comparativo_redimensionamento(imagem_serrano, imagem_redimensionada, 3); #imprime comprativo entre imagens
imwrite(imagem_redimensionada,'./serrano_redimensionada.png'); #salva a imagem redimensionada para serrano_redimensionada.png





















