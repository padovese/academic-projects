rm(list=ls()) ##Remove tudo feito anteriormente

install.packages("plyr") ##instala
library(plyr) ##import

duracao <- rename(duracao, replace = c("user_id"="aluno", "course_id"="curso", "timeToFinish"="dias")) ##renomeia

plot(duracao$dias) ##Cria grafico, porem R escolhe o tipo do grafico

jpeg("histograma.jpg")

hist(duracao$dias, breaks = 20, main="Histograma do Tempo", ylab="Quantidade", xlab="Dias", ylim=c(0, 2000), col="blue") ##Cria grafico especifico do tipo tabela coluna, customizando-o

dev.off()

mean(duracao$dias, na.rm=TRUE)

median(duracao$dias,  na.rm=TRUE)

summary(duracao$dias)

dim(duracao)[1] ##numero de registros, count(1) 

length(unique(duracao$curso)) ##conta cursos

length(unique(duracao$aluno))

sumario_estatistico <- aggregate(duracao$dias, list(duracao$curso), mean, na.rm=TRUE)
