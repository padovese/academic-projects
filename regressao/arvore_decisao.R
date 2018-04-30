library(sqldf)
library(party)

# Uma amostra de 1000 registros foi utilizada para este modelo
cc = sqldf("SELECT * FROM cc ORDER BY RANDOM() LIMIT 1000")
write.csv(cc, file = "D:/academic-projects/regressao/cc-1000.csv")

cc = read.csv("D:/academic-projects/regressao/cc-1000.csv")

#2/3 usado para treino e 1/3 de teste
L <- sample(1:nrow(cc),round(nrow(cc)/3))

train <- cc[-L,]
test <- cc[L,]

fit <- ctree(fraudulent ~., train)

predict_test = predict(fit, newdata=test)

# Matriz de confusão e resultados
c_matrix=table(test$fraudulent,predict_test)
print(c_matrix)

cat('Accuracy: ', sum(diag(c_matrix))/sum(c_matrix)*100, ' %')

plot(fit)
