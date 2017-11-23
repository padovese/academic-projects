library("forecast")
set.seed(123456)
opar <- par(no.readonly = TRUE)
par(mfrow = c(2, 2))
ylim <- c(min(Nile), max(Nile))
plot(Nile, main = "Raw time series")
plot(ma(Nile, 3), main = "Simple Moving Averages (k=3)", ylim = ylim)
plot(ma(Nile, 7), main = "Simple Moving Averages (k=7)", ylim = ylim)
plot(ma(Nile, 15), main = "Simple Moving Averages (k=15)", ylim = ylim)
par(opar)

fit <- ets(log(AirPassengers), model = "AAA")
fit
ets(y = log(AirPassengers), model = "AAA")



(previsao <- forecast(fit, 1))
accuracy(fit)
plot(previsao, xlab = "Year", ylab = expression(paste("Temperature (",
                                                        degree * F, ")")), main = "New Haven Annual Mean Temperature")


ets(AirPassengers, model = "MAM") 
ets(AirPassengers, seasonal="multiplicative")
