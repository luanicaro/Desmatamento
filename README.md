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
Devido a pouca quantidade de dados, além dos outliers não poderem ser removidos de maneira qualquer, será necessário uma normalização pela população de cada país. Isso é um procedimento padrão quando se trata de nações, o modelo irá prever o desmatamento por pessoa. Com essa normalização, os dados são bem mais comportados, como mostra o boxplot abaixo. 

![boxplot2](https://user-images.githubusercontent.com/34286550/147586789-d5c9d755-7fb9-4ed9-96ff-7e0074d5e473.png)

Apesar de serem mais comportados em questão de outliers, os dados continuam bem difíceis para modelos de regressão e sobraram 234 linhas na matriz.

![scatter](https://user-images.githubusercontent.com/34286550/147586817-5d4091cd-9fe7-45f0-aab1-ce39d12985bb.png)

### Análise mono e bi-variada
