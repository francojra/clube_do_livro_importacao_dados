
# R-Ladies São Paulo -----------------------------------------------------------------------------------------------------------------------
# Clube do Livro R for Data Science (2ed) --------------------------------------------------------------------------------------------------
# Encontro 9: Importação de dados (pacotes tidyverse/readr) --------------------------------------------------------------------------------
# Data: 19/09/24 ---------------------------------------------------------------------------------------------------------------------------
# Palestrante: Cecília Rocha ---------------------------------------------------------------------------------------------------------------

# Baixar pacote ----------------------------------------------------------------------------------------------------------------------------

library(tidyverse)

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
view(cardio)
