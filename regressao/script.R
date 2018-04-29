library(ROCR)
library(sqldf)

set.seed(1984)

#Importa valores e faz tratamento para binario
cc = read.csv("D:/academic-projects/regressao/qconlondon2016_sample_data.csv")
cc <- sqldf("select case when fraudulent = 'True' then
            1 else 0 end fraudulent, 
            charge_time, amount, card_country, card_use_24h
            from cc")

#Cria valores de teste e treino
teste = sample(1:nrow(cc),round(0.3*nrow(cc)))  

ccteste = cc[teste,]
cctrain = cc[-teste,]

str(cctrain)

#Altera vaiaveis para tipo numerico
ccteste$charge_time = as.numeric(ccteste$charge_time)
cctrain$charge_time = as.numeric(cctrain$charge_time)
cctrain$fraudulent = as.numeric(cctrain$fraudulent)

modelo = glm(fraudulent~., data=cctrain, family=binomial(link="logit"))

summary(modelo)

predict_teste = predict(modelo, newdata=ccteste, type="response")>0.5

str(cctrain)

c_matrix=table(ccteste$fraudulent,predict_teste)

print(c_matrix)

cat('Accuracy: ', sum(diag(c_matrix))/sum(c_matrix)*100, ' %')
