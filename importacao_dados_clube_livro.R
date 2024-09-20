
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
setwd() # Para especificar seu diretório, onde estão seus arquivos

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

