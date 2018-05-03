library(ROCR)
library(e1071)

cc = read.csv("D:/academic-projects/regressao/qconlondon2016_sample_data.csv")
cc$charge_time=as.numeric(cc$charge_time)

cc$amount = cut(cc$amount,20)
cc$charge_time=cut(as.numeric(cc$charge_time),20)
cc$card_use_24h = cut(cc$card_use_24h,20)

set.seed(1984)
T = sample(1:nrow(cc),round(0.3*nrow(cc)))  

ccteste=cc[T,]
cctreino=cc[-T,]

nb = naiveBayes(fraudulent~.,data=cctreino,laplace=1)

predict_test = predict(nb, newdata=ccteste)

c_matrix=table(ccteste$fraudulent,predict_test)
print(c_matrix)

cat('Accuracy: ', sum(diag(c_matrix))/sum(c_matrix)*100, ' %')

pr=prediction(as.numeric(predict_test),as.numeric(ccteste$fraudulent)) 
prf=performance(pr, measure="tpr", x.measure="fpr")
plot(prf ,colorize=TRUE)

auc=performance(pr, measure="auc")
auc=auc@y.values[[1]]
auc 
