attach(aulas) ##Anexa a tabela

section_id ##Imprime aénas esta coluna

options(max.print = 40000) ##Seta o output

head(section_id) ##Imprime os primeiros dados

sort(section_id) ##Orddena

aulas[33137, 3] <- 3255 ##Altera um valor

sort(aulas$section_id) ##Busca direto na tabela, sem ser a anexada

unique(aulas$section_id) ##Distinct

length(unique(aulas$section_id)) ##count

table(aulas$section_id) ##group by + count

sort(table(aulas$section_id)) ##group by + count + order by


install.packages("plyr") ##instala
library(plyr) ##import

auxliar <- count(aulas, vars = "course_id")
auxliar

write.csv(auxliar, "popularidade.csv")

