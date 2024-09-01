calc_class <- function(prices, d) {
  n <- length(prices)  # Número total de dias na série
  class <- rep(NA, n - d)  # Vetor para armazenar as classes
  
  for (i in 1:(n - d)) {  # Iterar através dos dias, de 1 até n-d
    # Calcular a diferença entre o preço no dia N+d e o preço no dia N
    # Se a diferença for positiva, a classe é 1; se negativa, a classe é 0
    class[i] <- ifelse(prices[i + d] > prices[i], 1, 0)
  }
  
  return(class)
}
