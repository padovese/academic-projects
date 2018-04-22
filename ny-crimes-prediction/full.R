# leitura dos dados
library(readr)
NYPD <- read_csv("D:/academic-projects/ny-crimes-prediction/data/NYPD_Complaint_Data_Historic.csv")

# gera e imprime amostra
install.packages("xlsx")
library(xlsx)
amostra = NYPD[sample(nrow(NYPD), 10),]
write.xlsx(amostra, "D:/academic-projects/ny-crimes-prediction/output/amostra.xlsx") 

# renomear campos que serao utilizados
install.packages("plyr")
library(plyr)
crime <- rename(NYPD, replace = c("CMPLNT_FR_DT"="data", "CMPLNT_FR_TM"="hora", "OFNS_DESC"="descricao", "CRM_ATPT_CPTD_CD"="status", "LAW_CAT_CD"="tipo", "BORO_NM"="bairro"))
crime = crime[sample(nrow(crime), 10000),] #amostra de 10k de registros

# demonstracao grafica de incidentes
plot(crime$hora, ylim=c(0, 85000)) 
barplot(sort(table(crime$descricao), decreasing=T), ylim=c(0, 2000))
barplot(sort(table(crime$bairro), decreasing=T), ylim=c(0, 3000),  col=c("yellow", "green", "red", "orange", "purple"))
barplot(sort(table(crime$status), decreasing=T), ylim=c(0, 10000))