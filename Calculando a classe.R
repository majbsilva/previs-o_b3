# Definição da classe como 0 quando cai e 1 quando sobe
 source('Funcao calc_class.R')

# Aplicar a função para os períodos de 30, 60 e 90 dias

class_30 <- calc_class(dados_BBDC4$BBDC4.SA.Close, 30)
class_60 <- calc_class(dados_BBDC4$BBDC4.SA.Close, 60)
class_90 <- calc_class(dados_BBDC4$BBDC4.SA.Close, 90)
class_120 <- calc_class(dados_BBDC4$BBDC4.SA.Close, 120)
class_150 <- calc_class(dados_BBDC4$BBDC4.SA.Close, 150)

# Criar dataframes para armazenar os resultados
df_30 <- data.frame(Periodo = 30, Classe_1 = sum(class_30 == 1), Classe_0 = sum(class_30 == 0))
df_60 <- data.frame(Periodo = 60, Classe_1 = sum(class_60 == 1), Classe_0 = sum(class_60 == 0))
df_90 <- data.frame(Periodo = 90, Classe_1 = sum(class_90 == 1), Classe_0 = sum(class_90 == 0))
df_120 = data.frame(Periodo = 120, Classe_1 = sum(class_120 == 1), Classe_0 = sum(class_120 == 0))
df_150 = data.frame(Periodo = 150, Classe_1 = sum(class_150 == 1), Classe_0 = sum(class_150 == 0))

# Combinar as tabelas em um único dataframe
classes_BBDC4 <- rbind(df_30, df_60, df_90, df_120, df_150)

# Visualizar o resultado
print(classes_BBDC4)
