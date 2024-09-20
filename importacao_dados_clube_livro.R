
# R-Ladies São Paulo -----------------------------------------------------------------------------------------------------------------------
# Clube do Livro R for Data Science (2ed) --------------------------------------------------------------------------------------------------
# Encontro 9: Importação de dados (pacotes tidyverse/readr) --------------------------------------------------------------------------------
# Data: 19/09/24 ---------------------------------------------------------------------------------------------------------------------------
# Palestrante: Cecília Rocha ---------------------------------------------------------------------------------------------------------------

# Baixar pacote ----------------------------------------------------------------------------------------------------------------------------

library(tidyverse)
library(janitor)

# Lendo dados de um arquivo ----------------------------------------------------------------------------------------------------------------

## csv = comma-separated values -- Colunas separadas por vírgula
## e valores separados por ponto.
## No Brasil, usamos o csv2, onde as colunas são separadas por ponto
## e vírgula e os valores separados por vírgula.

## Funções do pacote readr

read_csv()
read_csv2()

## IMPORTANTE: a primeira etapa é verificar onde está o seu diretório
## de trabalho

getwd() # Para verificar o diretório
setwd() # Para especificar seu diretório, onde estão seus arquivos,
## O endereço deve ser colocado entre aspas com barras invertidas

cardio <- read.csv2("cardio_train.csv")
tibble(cardio)
view(cardio)

estudantes <- read.csv("estudantes.csv", na = c("N/A", "", "NA"))
tibble(estudantes)
view(estudantes)

estudantes <- estudantes |>
  janitor::clean_names() # Coloca todos os nomes de colunas separadas por "_"
view(estudantes)

## Importante sempre verificar os tipos de variáveis: numéricas dbl,
## categóricas (factor), numéricas inteiras, etc. para que os gráficos
## sejam adequados para cada variável.

## Na tabela estudante, a variável idade apresenta números e também
## um caracter "cinco" em vez de 5.

estudantes <- estudantes |>
  mutate(plano_alimentar =  as.factor(plano_alimentar),
         comida_favorita = as.factor(comida_favorita),
         idade = parse_number(if_else(idade == "cinco", 
                                      "5", idade)))
glimpse(estudantes)

## A função parse_number pega apenas os números de uma variável
## e transforma essa variável em numérica, no caso da tabela,
## uma das linhas apresentava apenas um caracter, então foi
## necessário usar o if_else antes de usar o parse_number.

# Criando tabelas e explorando argumentos --------------------------------------------------------------------------------------------------

read_csv(
  "x, y, z
  1, 2, 3
  4, 5, 6"
)

read_csv(
  "x, y, z
  1, 2, 3
  4, 5, 6",
  show_col_types = FALSE # Para omitir mensagens
)

read_csv(
  "Primeira linha de metadados
  Segunda linha metadados
  x, y, z
  1, 2, 3
  4, 5, 6",
  skip = 2 # Retira as duas primeiras linhas
)

read_csv(
  "# Aqui é um comentário
  x, y, z
  1, 2, 3
  4, 5, 6",
  comment = "#" # Indica que tudo que tem o "#" é comentário
)

read_csv(
  "1, 2, 3
  4, 5, 6",
  col_names = FALSE # Fala que os dados não tem cabeçalho, 
  # então novas variáveis são criadas nas colunas
)

read_csv(
  "1, 2, 3
  4, 5, 6",
  col_names = c("C1", "C2", "C3") # Você cria os nomes das colunas
)

# Adivinhando tipos ------------------------------------------------------------------------------------------------------------------------

## O pacote readr usa uma heurística para descobrir os tipos de coluna. 
## Para cada coluna, ele pega os valores de 1.0003 linhas espaçadas 
## uniformemente da primeira à última, ignorando os valores ausentes. 
## Ele então trabalha através das seguintes perguntas:

## Contém apenas F, T, FALSE ou TRUE (ignorando a caixa alta)? Se sim, é um lógico.
## Contém apenas números (por exemplo, 1, -4.5, 5e6, Inf)? Se sim, é um número.
## Corresponde ao padrão ISO8601? Se sim, é uma data ou data-hora. (Voltaremos às data-horas em mais detalhes em Seção 17.2).
## Caso contrário, deve ser uma string.

read_csv("
  logico,numerico,data,string
  TRUE,1,2021-01-15,abc
  false,4.5,2021-02-15,def
  T,Inf,2021-02-16,ghi
")

simple_csv <- "
  x
  10
  .
  20
  30"

read_csv(simple_csv) # Se nos dados tem uma palavra ou ponto/símbolo
# o read_csv interpretará como uma coluna de caracteres.

df <- read_csv(
  simple_csv, 
  col_types = list(x = col_double()) # Pede para que a coluna x seja numérica dbl
)

df

problems(df) # Relata o problema de uma das linhas ser caracter e não numérico.
# O read_csv converte o caracter em um NA