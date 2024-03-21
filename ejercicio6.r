library(stats)

datos <- 1000
desviacion_estandar <- 1  

# Ruido blanco con media cero
set.seed(123)
ruido_blanco <- rnorm(datos, mean=0, sd=desviacion_estandar)

# Proceso MA 
# x_t = ruido_blanco_{t-1} + 2 * ruido_blanco_t + ruido_blanco_{t+1}
# Vectores para ruido_blanco_{t-1} y ruido_blanco_{t+1}
ruido_blanco_retrasado <- c(0, ruido_blanco[-datos])  # ruido_blanco_{t-1}
ruido_blanco_avanzado <- c(ruido_blanco[-1], 0)       # ruido_blanco_{t+1}

serie_temporal <- ruido_blanco_retrasado + 2 * ruido_blanco + ruido_blanco_avanzado

# Graficas
acf(serie_temporal, type="covariance", plot=TRUE, lag.max=20, main="Función de Autocovarianza", xlab="Lag", ylab="Autocovarianza")

acf(serie_temporal, type="correlation", plot=TRUE, lag.max=20, main="Función de Autocorrelación (ACF)", xlab="Lag", ylab="Autocorrelación")
