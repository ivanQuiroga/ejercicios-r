library(stats)

# Definir los parámetros del proceso MA
cantidad_datos <- 1000  
desviacion_estandar <- 1

# Ruido blanco con media cero y varianza desviacion_estandar^2
set.seed(123)
ruido_blanco <- rnorm(cantidad_datos, mean=0, sd=desviacion_estandar)

# Serie temporal
# serie_temporal = ruido_en_t_menos_1 + 2 * ruido_en_t + ruido_en_t_mas_1
ruido_con_ceros <- c(0, ruido_blanco, 0)
serie_temporal <- ruido_con_ceros[1:(cantidad_datos)] + 2 * ruido_blanco + ruido_con_ceros[3:(cantidad_datos+2)]

# Grafica
acf_serie_temporal <- acf(serie_temporal, type="covariance", plot=TRUE, lag.max=20)
acf(serie_temporal, type="correlation", plot=TRUE, lag.max=20)