exponential_smoothing <- function(series, alpha) {
  n <- length(series)
  if(n == 0) return(NULL)  # Verifica se a série está vazia
  S <- numeric(n)  # Cria um vetor numérico do mesmo comprimento que a série
  S[1] <- series[1]  # Primeiro valor suavizado é igual ao primeiro valor da série
  
  for (t in 2:n) {
    S[t] <- alpha * series[t] + (1 - alpha) * S[t - 1]
  }
  
  return(S)
}
