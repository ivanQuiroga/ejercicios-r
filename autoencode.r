# Instalar y cargar el paquete reticulate
install.packages("reticulate")
library(reticulate)

# Usar una versión específica de Python
use_python("C://Software//Python//python-3.8.0-embed-amd64", required = TRUE)

# Instalar TensorFlow
install.packages("tensorflow")
library(tensorflow)
## En caso que no detecte correctamente la instalacion
#py_install("tensorflow", envname = "r-reticulate")

# Instalar Keras
install.packages("reticulate")
library(reticulate)
## En caso que no detecte correctamente la instalacion
#py_install("keras", envname = "r-reticulate")

# Instalar y cargar el paquete keras
install.packages("keras")
library(keras)
## En caso que no detecte correctamente la instalacion
#py_install("keras")
install_tensorflow()

# Probar keras
keras::k_constant(1)


# Procesar y Normalizar los datos a vector de 784 elementos
mnist <- dataset_mnist()
x_train <- mnist$train$x
x_test <- mnist$test$x
x_train <- array_reshape(x_train, c(nrow(x_train), 784))
x_test <- array_reshape(x_test, c(nrow(x_test), 784))
x_train <- x_train / 255
x_test <- x_test / 255
input_size <- 784
hidden_size <- 128
output_size <- 784

# Construccion del AE
## Encoder
inputs <- layer_input(shape = c(input_size))
encoded <- inputs %>%
  layer_dense(units = hidden_size, activation = 'relu',
              activity_regularizer = regularizer_l1(1e-7))
## Decoder
decoded <- encoded %>%
  layer_dense(units = output_size, activation = 'sigmoid')
## AE
autoencoder <- keras_model(inputs = inputs, outputs = decoded)


# Compilar el AE
autoencoder %>% compile(
  optimizer = 'adam',
  loss = 'binary_crossentropy'
)

# Entrenamiento del AE
history <- autoencoder %>% fit(
  x_train, x_train,
  epochs = 50,
  batch_size = 256,
  shuffle = TRUE,
  validation_data = list(x_test, x_test)
)

## Verificacion de la reconstruccion
encoded_imgs <- predict(autoencoder, x_test)
# Graficar los resultados del entrenamiento
plot(history)
# Evaluar el modelo en los datos de prueba
evaluation <- autoencoder %>% evaluate(x_test, x_test)
# Imprimir los resultados de la evaluación
print(evaluation)