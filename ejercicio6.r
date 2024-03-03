varianza <- 1  

# Funcion autocovarianza
autovarianza <- function(h, varianza) {
  if (h == 0) {
    return(varianza * (1 + 4 + 1))  # w_t^2 + 2(w_t * w_t) + w_{t+1}^2
  } else if (abs(h) == 1) {
    return(varianza * (1 + 2))      # w_t * w_{t+1} + w_t * w_{t-1}
  } else if (abs(h) == 2) {
    return(varianza * 1)            # w_{t-1} * w_{t+1}
  } else {
    return(0)
  }
}

# Funcion autocorrelacion
autocorrelacion <- function(h, varianza) {
  gamma_0 <- autovarianza(0, varianza)
  return(autovarianza(h, varianza) / gamma_0)
}

# Valores Autocovarianza y Aautocorrelacion 
desfases <- -2:2
autocovarianzas <- sapply(desfases, autovarianza, varianza=varianza)
autocorrelaciones <- sapply(desfases, autocorrelacion, varianza=varianza)


# Grafica (ACF)
print(data.frame(desfases, autocovarianzas, autocorrelaciones))
plot(desfases, autocorrelaciones, type="h", lwd=2, col="blue",
     main="Función de Autocorrelacion (ACF) del Proceso de Promedio Movil",
     xlab="Desfase (h)", ylab="Autocorrelacion",
     ylim=c(min(autocorrelaciones), 1)) 
abline(h=0, col="red", lty=2)
