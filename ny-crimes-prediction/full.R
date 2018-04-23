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

# mapa de NYC
install.packages("ggmap")
library(ggmap)
mymap <- get_map(location = "New York", maptype = "roadmap")
ggmap(mymap)

# consultas em SQL
install.packages("sqldf")
library(sqldf)

furto <- sqldf('select CMPLNT_NUM, latitude, longitude, lat_lon from crime where descricao = upper("petit larceny")')
assalto <- sqldf('select CMPLNT_NUM, latitude, longitude, lat_lon from crime where descricao like upper("%assault%")')
fraud <- sqldf('select CMPLNT_NUM, latitude, longitude, lat_lon from crime where descricao like upper("%fraud%")')
qtde <- sqldf('select descricao, count(*) qtde from crime group by descricao order by 2 desc')

# crimes mapeados
ggmap(mymap)+
  geom_point(aes(x = Longitude, y = Latitude), data = crime, 
             alpha = .5, color="darkred", size = 1)

# furtos mapeados
ggmap(mymap)+
  geom_point(aes(x = Longitude, y = Latitude), data = furto, 
             alpha = .5, color="darkred", size = 1)

# assalto mapeados
ggmap(mymap)+
  geom_point(aes(x = Longitude, y = Latitude), data = assalto, 
             alpha = .5, color="darkred", size = 1)

# fraldes mapeados
ggmap(mymap)+
  geom_point(aes(x = Longitude, y = Latitude), data = fraud, 
             alpha = .5, color="darkred", size = 1)



