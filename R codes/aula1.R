--2
library(sqldf)

--3
sqldf(`select * from iris`)

library(dplyr)
library(readr)

--1
install.packages("sqldf")



sqldf("select * from iris limit 5")

sqldf("select count(*) from DM_IES")

sqldf("select avg(d.co_escolaridade_docente) 
      from DM_DOCENTE d, DM_IES i 
      where d.co_ies = i.co_ies
      and   no_regiao_ies = 'Sudeste'")


sqldf("select avg(d.co_escolaridade_docente) 
      from DM_DOCENTE d, DM_IES i 
      where d.co_ies = i.co_ies
      and   no_regiao_ies = 'Nordeste'")


--Exercicios:
sqldf("select d.co_escolaridade_docente, count(d.co_escolaridade_docente) 
      from DM_DOCENTE d, DM_IES i 
      where d.co_ies = i.co_ies
      and   no_regiao_ies = 'Nordeste'
      group by d.co_escolaridade_docente")


sqldf("select d.co_escolaridade_docente, count(d.co_escolaridade_docente) 
      from DM_DOCENTE d, DM_IES i 
      where d.co_ies = i.co_ies
      and   no_regiao_ies = 'Sudeste'
      group by d.co_escolaridade_docente")

sqldf("select no_regiao_ies, count(no_regiao_ies) from DM_IES group by no_regiao_ies")


sqldf("select * from DM_IES where co_ies = 1")


data()


DM_IES <- read_delim("~/Downloads/microdados_censo_superior_2015/DADOS/DM_IES.CSV", "|", escape_double = FALSE, trim_ws = TRUE)

DM_DOCENTE <- read_delim("~/Downloads/microdados_censo_superior_2015/DADOS/DM_DOCENTE.CSV", "|", escape_double = FALSE, trim_ws = TRUE)

DM_ALUNO <- read_delim("~/Downloads/microdados_censo_superior_2015/DADOS/DM_ALUNO.CSV", "|", escape_double = FALSE, trim_ws = TRUE)
