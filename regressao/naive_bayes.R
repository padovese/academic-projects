install.packages("ROCR")
library(ROCR)

install.packages("e1071")
library(e1071)

cc = read.csv("D:/academic-projects/regressao/qconlondon2016_sample_data.csv")
cc$charge_time=as.numeric(cc$charge_time)

# Treino e teste
set.seed(1984)

T = sample(1:nrow(cc),round(0.3*nrow(cc)))  

ccteste = cc[T,]
cctreino = cc[-T,]

nb = naiveBayes(fraudulent~.,data=cctreino,laplace=1)

nb$apriori
nb$tables

#predição
predict_test = predict(nb, newdata=ccteste)
head(predict_test)

#probabilidade por classe
predict_test = predict(nb, newdata=ccteste, type="raw")
head(predict_test)

#matriz de confusão e acuricidade
c_matrix=table(ccteste$fraudulent, predict_test)
print(c_matrix)
cat('Accuracy: ', sum(diag(c_matrix))/sum(c_matrix)*100, ' %')

#Curva ROC
pr=prediction(as.numeric(predict_test),as.numeric(ccteste$fraudulent)) 
prf=performance(pr, measure="tpr", x.measure="fpr")
plot(prf ,colorize=TRUE)

auc=performance(pr, measure="auc")
auc=auc@y.values[[1]]
auc 

