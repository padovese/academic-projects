rm(list=ls()) ##Remove tudo feito anteriormente

duracao <- rename(duracao, replace = c("user_id"="aluno", "course_id"="curso", "timeToFinish"="dias")) ##renomeia

plot(duracao$dias) ##Cria grafico, porem R escolhe o tipo do grafico

hist(duracao$dias) ##Cria grafico especifico do tipo tabela coluna

