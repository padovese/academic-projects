stat500 <- data.frame(scale(montgomery_11_4))
str(stat500)
sapply(stat500, mean)
sapply(stat500, sd)

plot(Venda ~ Taxas, stat500)
abline(0, 1)

--linear model
lm(Venda ~ Taxas, stat500) 

ntg.lm <- lm(Venda ~ Taxas, data = stat500) 

--Chama metade apos o $
ntg.lm$coefficients
ntg.lm$coefficients[1]
ntg.lm$coefficients[2]

ntg.lm$residuals
