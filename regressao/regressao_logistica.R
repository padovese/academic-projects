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

summary(modelo)

#Altera vaiaveis para tipo numerico e aplica função de regressão logística
ccteste$charge_time = as.numeric(ccteste$charge_time)
cctrain$charge_time = as.numeric(cctrain$charge_time)
cctrain$fraudulent = as.numeric(cctrain$fraudulent)

modelo = glm(fraudulent~., data=cctrain, family=binomial(link="logit"))

summary(modelo)

predict_teste = predict(modelo, newdata=ccteste, type="response")>0.5

str(cctrain)

#MAtriz de confusao

c_matrix=table(ccteste$fraudulent,predict_teste)

print(c_matrix)

cat('Accuracy: ', sum(diag(c_matrix))/sum(c_matrix)*100, ' %')


#Explorando o modelo
exp(coef(modelo))

summary(modelo)

#Curva ROC
# ROC curve
pr=prediction(as.numeric(predict_teste),as.numeric(ccteste$fraudulent)) 
prf=performance(pr, measure="tpr", x.measure="fpr")
plot(prf ,colorize=TRUE)
auc=performance(pr, measure="auc")
auc=auc@y.values[[1]]
auc 
