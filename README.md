![header](https://user-images.githubusercontent.com/34286550/147572443-d5e26142-c9d3-421d-a6ca-6cd72848c7a0.png)

Os códigos são um trabalho da faculdade sobre regressões lineares, foram usadas OLS Regression (Ordinary Least Squares), Ridge regression e PLS(Partial Least Squares). 

## Tecnologias
+ R: Análise Exploratória e Geomapa
+ Python: Análise Exploratória e modelos preditivos

## Resultados
O desmatamento por pessoa que aconteceu em 2010:

![mapaprevisto](https://user-images.githubusercontent.com/34286550/147576228-de33a856-08d9-4d22-bd24-139ea2f1fb50.png)


O resultado das regressões:

![desmatamentoprevisto](https://user-images.githubusercontent.com/34286550/147576031-fb6e6097-4478-4fad-b937-aae1ea3dbff8.png)

A previsão dos modelos apesar de errarem o tanto de desmatamento, acertou quase todos os países que perdem ou ganham florestas.

# Análise exploratória

Os dados do desmatamento são retirados do site "Our World in Data", dos seus artigos sobre florestas e desmatamento. Esses textos foram importantes à análise exploratória, com perguntas chaves ao entendimento das informações e à busca do problema. Depois da exploração dos dados, foi feito um tratamento neles para aplicar modelos de regressão linear e fazer uma análise preditiva sobre o desmatamento.
São 6 datasets, cada um tratando de aspectos diferentes do desmatamento, como: comportamento, causas e consquências. Os seis são;
+ Forest;
+ Forest Area;
+ Brazil Loss;
+ Vegetable Oil;
+ Soybean Use;
+ Population;

### Tratamento dos Dados
Modelos de regressão são muito sensíveis a outliers, portanto, é necessário ver como esse dados se comportam. Logo, boxplot é uma ótima ferramenta para detectar esses pontos fora da curva.

![boxplot](https://user-images.githubusercontent.com/34286550/147579599-880a3fe2-c6e4-4214-83da-94343070255e.png)

Percebe-se que os dados não são muito comportados, mas não é tão simples remover os outliers do dataset. Isso porque, caso ocorra essa remoção de maneira qualquer, essas informações não representariam a verdade sobre o desmatamento. Os únicos valores que poderão ser removidos são os "Not a Number"(NaN).

### Quais os países com maior área de floresta?

O gráfico em área, mostra a porcentagem global de floresta dos países. Poucas entidades contém certa de 67\% das florestas do mundo.

![área](https://user-images.githubusercontent.com/34286550/147583630-05dac3af-9d95-47fb-a88d-e2e3e2e0d2e4.png)

### Quanto desmatamento acontece?

![Desmatamento](https://user-images.githubusercontent.com/34286550/147583871-72bd9dc7-3282-48f8-99a4-096a7fa9db3d.png)

O desmatamento do mundo acontece na casa de milhões de hectares por ano e o país que mais desmata é o **Brasil**.

### Porque o Brasil? Como? 

O Brasil é o foco do desmatamento no mundo, porque é segundo país no rank com mais área de floresta, tem um clima ameno e tem leis menos punitivas ao desmatamento que em outras nações.

![brazil_loss](https://user-images.githubusercontent.com/34286550/147583977-ac6de553-e47f-44d4-b5dd-d35b8ce77ef1.png)

O principal causador da destrução das florestas brasileiras são os pastos.

### Produção de soja de vários países.


![soja](https://user-images.githubusercontent.com/34286550/147584049-589c4821-2367-4480-a916-b94747b1e8bc.png)

Na produção de soja, China e Estados Unidos são os que mais produzem e não perdem floresta. Além disso, os países que mais desmatam não tem produção de soja, apenas o Brasil, cujas plantações são o que menos causam desmatamento. Então, a produção de soja não é um fator relevante ao desflorestamento mundial. 

### Produção de óleos vegetais

![óleos](https://user-images.githubusercontent.com/34286550/147584353-691c51dc-74aa-4123-9ee1-9c090b479c26.png)

A produção de óleos é bem mais relevante ao desmatamento, considerando que vários dos países que mais desmatam tem uma alta produção de óleos vegetais.

### Definindo os preditores
Juntando os dados mais relevantes ao desmatamento global, é formado o dataset com: Conversão líquida de floresta, área, população e produção de óleo.
<table>
  <tr>
    <td>Entidade</td>
    <td>Código</td>
    <td>Ano</td>
    <td>Conversão líquida de floresta</td>
    <td>Área %</td>
    <td>População</td>
    <td>Produção de óleo(toneladas)</td>
  </tr>
  <tr>
    <td>Russia</td>
    <td>RUS</td>
    <td>2010</td>
    <td>-41030</td>
    <td>19.85</td>
    <td>142849468</td>
    <td>3007851</td>
  </tr>
  <tr>
    <td>...</td>
    <td>...</td>
    <td>...</td>
    <td>...</td>
    <td>...</td>
    <td>...</td>
    <td>...</td>
  </tr>
  <tr>
    <td>Maldives</td>
    <td>MDV</td>
    <td>1990</td>
    <td>0</td>
    <td>0</td>
    <td>223159</td>
    <td>1224</td>
  </tr>
</table>

O dataset tem 260 linhas e os preditores para prever a Conversão líquida de floresta são: área, população e produção de óleo.

## Removendo os outliers
Devido a pouca quantidade de dados, além dos outliers não poderem ser removidos de maneira qualquer, será necessário uma normalização pela população de cada país. Isso é um procedimento padrão quando se trata de nações, o modelo irá prever o desmatamento por pessoa. Com essa normalização, os dados são bem mais comportados, como mostra o boxplot abaixo, então os outliers poderão ser removidos. 

![boxplot2](https://user-images.githubusercontent.com/34286550/147586789-d5c9d755-7fb9-4ed9-96ff-7e0074d5e473.png)

Apesar de serem mais comportados em questão de outliers, os dados continuam bem difíceis para modelos de regressão e sobraram 234 linhas na matriz.

![scatter](https://user-images.githubusercontent.com/34286550/147586817-5d4091cd-9fe7-45f0-aab1-ce39d12985bb.png)

### Análise mono e bi-variada

Depois de definir os preditores e remover os outliers, é necessário fazer uma análise estatística para ver como os dados se comportam e o tipo de tratamento necessário para eles.

![Captura de tela de 2021-12-28 15-35-13](https://user-images.githubusercontent.com/34286550/147598407-8d9c1dc0-b2a3-4e85-a0fe-074e214982dc.png)

Os valores de distorção mostrados na tabela são bem altos, então uma transformação nesses dados se torna necessária. Nos dados com valores positivos, é aplicada uma transformação logarítmica para corrigir a distorção. Já na conversão líquida de floresta, como os valores são negativos, uma transformação Yeo-Johnson deve ser aplicada.

A figura é um plot de pares das colunas do dataset principal. A diagonal mostra o histograma dos dados que sofreram uma transformação logarítmica. Os outros plots são apenas um scatterplot de como uma informação se relaciona a outra.

![análise png](https://user-images.githubusercontent.com/34286550/147599572-90bfed42-65c7-4bf9-a718-7e5009614e91.png)

### Matriz de correlação

A matriz de correlação diz quanto uma coluna da matriz está correlacionada com outra. Isso é importante porque caso existam colunas altamente correlacionadas, não será possível fazer a regressão linear. X é a matriz de preditores e y é matriz de saída.

![CodeCogsEqn (7)](https://user-images.githubusercontent.com/34286550/147603935-e9075d58-e495-45be-a6ed-37252f31ace6.png)

A equação acima é a regressão linear em notação matricial. Essa fórmula mostra porque não é possível fazer a regressão quando as colunas são altamente correlacionadas, pois o produto abaixo não é invertível.

![CodeCogsEqn (8)](https://user-images.githubusercontent.com/34286550/147603983-b1002974-9637-46ff-8765-d19be64ba940.png)

A matriz de correlação dos preditores do desmatamento:

![Captura de tela de 2021-12-28 16-38-19](https://user-images.githubusercontent.com/34286550/147601247-19b88c85-16dc-46bd-a935-b2f64a6f60ca.png)

## PCA (Principal Component Analysis)

É importante ressaltar que cada coluna de uma matriz é uma dimensão dessa matriz, assim é impossivel visualizar os dados da matriz quando existem mais de 3 colunas. Então, a PCA (Principal Component Analysis) é um método para resolver esse problema de visualização. Isso porque, a PCA analísa as colunas e mantém as duas com maior variância, porque preserva as informações originais dos dados e cria uma visualização fidedigna da matriz original.


![newplot](https://user-images.githubusercontent.com/34286550/147601659-b29b5147-91c3-41b8-9598-b718d46d2c2c.png)

O eixo 0 é a Área de floresta e o eixo 1 é a produção de óleo.

A PCA escolheu como componentes principais a área de floresta e a produção de óleo. Portanto, esses preditores irão à regressão linear.

#### Variancia

![variancia](https://user-images.githubusercontent.com/34286550/147602299-507213c3-530e-4565-aa01-1213fbf016d5.png)

Somente com duas componentes os dados tem quase 100% de variância. 

# Resultados

Após todo o pré-processamento de dados e a aplicação da PCA, é possível aplicar modelos de regressão linear. Serão aplicados os modelos OLS(Ordinary Least Squares) regression, Ridge regression e PLS(Partial Least Squares) regression.
Como os dados são uma série temporal do desmatamento, os dados de teste e de treino foram separados pelo tempo. Foram separados os dados de 1990 e 2000 para prever o desmatamento por pessoa de 2010.

Devido aos dados não serem adequados às regressões, os modelos não foram capazes de se adequar devidamente e todos tiveram os mesmos resultados:

![CodeCogsEqn (9)](https://user-images.githubusercontent.com/34286550/147604064-bf03cab4-2198-46f3-9e62-46776992353d.png)

![CodeCogsEqn (10)](https://user-images.githubusercontent.com/34286550/147604148-6e73dd9e-852c-457b-809a-6a387fd05b65.png)

![CodeCogsEqn (11)](https://user-images.githubusercontent.com/34286550/147604127-60537ae6-bc71-400b-9fd8-e8a8e3c19a5b.png)


### Plot da regressão

![regressao](https://user-images.githubusercontent.com/34286550/147603213-a31b7946-212a-49c6-b0ab-a38501aacf90.png)

### Mapas 

O desmatamento por pessoa que aconteceu em 2010:

![mapaprevisto](https://user-images.githubusercontent.com/34286550/147576228-de33a856-08d9-4d22-bd24-139ea2f1fb50.png)


O resultado das regressões:

![desmatamentoprevisto](https://user-images.githubusercontent.com/34286550/147576031-fb6e6097-4478-4fad-b937-aae1ea3dbff8.png)

# Conclusão

Os dados foram bem desafiadores para o modelo de regressão devido sua quantidade de outliers e a pouca quantidade de linhas na matriz. Os modelos tiveram perfomances iguais apesar de usarem métodos diferentes e talvez para esse dataset um modelo robusto contra outliers possa ter um resultado bem melhor. Por fim, a regressão foi capaz de acertar a maior parte dos locais que ocorrem desmatamento.

