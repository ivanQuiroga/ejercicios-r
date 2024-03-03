install.packages("forecast")
library(forecast)

set.seed(123) 
tiempo <- 1:200
signal <- ifelse(tiempo <= 100, 0, 10 * exp(-(tiempo-100)/20) * cos(2 * pi * tiempo / 4))
ruido <- rnorm(200, mean = 0, sd = 1) 
serie_temporal <- signal + ruido

media <- mean(serie_temporal)
covarianza <- Acf(serie_temporal, plot=FALSE)

# Grafica serie temporal
plot(tiempo, serie_temporal, type="l", main="Serie Temporal (a) con Media", xlab="Tiempo", ylab="Serie Temporal")
abline(h = media, col="red", lty=2)
legend("topright", legend=c("Serie (a)", "Media"), col=c("black", "red"), lty=1:2)

# Grafica autocovarianza
plot(covarianza, main="Funcion de Autocovarianza para la Serie (a)")