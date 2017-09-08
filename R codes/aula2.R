install.packages("sqldf")

library(sqldf)

sqldf("select * from avgpm25")


classes <- c("numeric", "character", "factor", "numeric", "numeric")

avgpm25 <- read.csv("/Users/26MAC-FCI/Downloads/avgpm25.csv", colClasses = classes)

head(avgpm25)


str(avgpm25)


fivenum(avgpm25$pm25)


boxplot(avgpm25$pm25, col = "blue")

filter(avgpm25, pm25 > 15)

map("county", "new york")

library(dplyr)
library(maps)



with(filter(avgpm25, pm25 > 15), points(longitude, latitude, col = "red"))

hist(avgpm25$pm25, col = "green", breaks = 100)
rug(avgpm25$pm25)
abline(h = 12)



boxplot(avgpm25$pm25, col = "blue")
abline(h = 12)


table(avgpm25$region) %>% barplot(col = "wheat")

sqldf("select region, count(1) from avgpm25 group by region") %>% barplot(col = "wheat")







par(mfrow = c(1, 1), mar = c(4, 4, 2, 1))
hist(subset(avgpm25, region == "east")$pm25, col = "green")
hist(subset(avgpm25, region == "west")$pm25, col = "red")
hist(subset(avgpm25, region == "east")$pm25, col = "blue")
hist(subset(avgpm25, region == "west")$pm25, col = "yellow")
hist(subset(avgpm25, region == "east")$pm25, col = "PINK")


with(avgpm25, plot(latitude, pm25))
abline(h = 12, lwd = 2, lty = 2)

levels(avgpm25$region)


with(avgpm25, plot(longitude, latitude, col = region))
abline(h = 12, lwd = 2, lty = 2)