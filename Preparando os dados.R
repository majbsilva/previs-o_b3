# Obtendo dados_VALE3 para estudo de ML

# Pacotes necessários
library(TTR)
library(quantmod)
library(ggplot2)
library(plotly)

# Obter dados_VALE3 da ação
getSymbols('VALE3.SA', from = '2020-01-01', to = Sys.Date(), src = 'yahoo')
dados_VALE3 = VALE3.SA

# Calculando os indicadores técnicos

## RSI
dados_VALE3$RSI = RSI(Cl(dados_VALE3), n = 14)

## Oscilador Estocástico
dados_VALE3$StochK = stoch(HLC(dados_VALE3), nFastK = 14, nFAstD = 3, nSlowD = 3)$fastK

## William %R
dados_VALE3$WPR = WPR(HLC(dados_VALE3), n = 14)

## MACD
macd = MACD(Cl(dados_VALE3), nFast = 12, nSlow = 26, nSig = 9)
dados_VALE3$MACD = macd$macd
dados_VALE3$MACDSignal = macd$signal

# Price rata of Change (PROC)
dados_VALE3$PROC = ROC(Cl(dados_VALE3), n = 12)*100

# On Balance Volume
dados_VALE3$OBV = OBV(Cl(dados_VALE3), Vo(dados_VALE3))

# Suavização de dados_VALE3 exponencial

source('funcao_exponetial_smoothing.R')

smoothed_close = exponential_smoothing(dados_VALE3$VALE3.SA.Close, 0.5)

## Adicionar a série suavizada ao objeto 'dados_VALE3'
if(length(smoothed_close) == nrow(dados_VALE3)) {
  dados_VALE3$SmoothedClose <- smoothed_close
} else {
  warning("O comprimento da série suavizada não corresponde ao número de linhas em `dados_VALE3`.")
}

## Verificar os dados_VALE3
head(dados_VALE3)

# Gráficos dos preços de fechamento com suavização

df = data.frame (index(dados_VALE3),
                 Cl(dados_VALE3),
                 dados_VALE3$SmoothedClose)

p <- ggplot(df, aes(x = index.dados_VALE3.)) +
  geom_line(aes(y = VALE3.SA.Close, color = 'Close')) +
  geom_line(aes(y = SmoothedClose, color = 'Smoothed Close')) +
  labs(title = "Preço de Fechamento com Suavização Exponencial", 
       y = "Preço", 
       x = "Data") +
  scale_color_manual("", 
                     breaks = c("Close", "Smoothed Close"),
                     values = c("Close" = "blue", "Smoothed Close" = "red")) +
  scale_x_date(date_breaks = "1 month", date_labels = "%b %Y") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

## Exigindo gráfico
p

## Criando um gráfico interativo
pp = ggplotly(p)

## Personalizar o layout para melhorar a aparência
pp <- pp %>% 
  layout(hovermode = "x unified",
         legend = list(orientation = "h", y = -0.2),
         margin = list(l = 50, r = 50, b = 100, t = 50),
         xaxis = list(tickangle = 45))

# Exibir o gráfico interativo
pp

# Converter para data.frame e salvar CSV
dados_VALE3 = data.frame(Date = index(dados_VALE3), coredata(dados_VALE3))
write.csv(dados_VALE3,'VALE3 dados_VALE3 técnicos.csv', row.names = FALSE)




