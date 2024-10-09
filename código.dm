dados <- read.csv(file = "Heart.csv", header = TRUE, sep = ",")
 
summary(dados)
str(dados)
 
#para saber se é uma variavel categorica = unique(dados$thal)
 
#tratando um pouco
dados$AHD <- as.factor(dados$AHD)
dados$Thal <- as.factor(dados$Thal)
dados$ChestPain <- as.factor(dados$ChestPain)
dados$Fbs <- as.factor(dados$Fbs)
dados$RestECG <- as.factor(dados$RestECG)
dados$Slope <- as.factor(dados$Slope)
dados$Ca <- as.factor(dados$Ca)
dados$ExAng <- as.factor(dados$ExAng)
 
dados <- subset(dados,select= -X)
#outra forma de tirar uma coluna
#dados <- dados[,-1]
 
dados <- na.omit(dados)
 
#analise estatistica
library(ggplot2)
 
ggplot(dados, aes(x=AHD, y=Chol))+
  geom_boxplot()
 
ggplot(dados, aes(x=AHD, y=MaxHR))+
  geom_boxplot()
 
 
#em alguns casos sentir dor no peito era um sintome assintomatica ao ahd
table(dados$ChestPain,dados$AHD)
ggplot(dados, aes(x=dados$ChestPain, fill = AHD))+
  geom_bar()
 
 
#separar para o grupo de treinamento e teste
n <- round(0.8*nrow(dados))
n
 
ind_treinamento <- sample(1:nrow(dados), size = n, replace = FALSE)
 
treinamento <- dados[ind_treinamento,]
teste <- dados[-ind_treinamento,]
 
 
#plotando a arvore de decisao
 
arvore <- rpart(formula = AHD ~., data = treinamento, method = "class")
rpart.plot(arvore, extra = 101)  
 
previsao <- predict(arvore, newdata = teste, type = "class")
mean(previsao == teste$AHD)
 
table(teste$AHD, previsao)  
#classificamos 30 pessoas com a doença de coração, dessas 30 de fato tinham 21.
 
7/30
#23% de erro, esta alta
 
 
#floresta agora ####olhar pq esta errando
library(randomForest)
 
floresta <- randomForest(formula = AHD~., data = treinamento)
floresta
 
previsaoFloresta <- predict(floresta, newdata = teste, type = "class")
 
mean(previsaoFloresta,teste$AHD)
 
importance(floresta)
 
#tirando a variavel que so me atrapalha, a q tem menos importancia (no importance) para a analise
 
floresta2 <- randomForest(formula = AHD~. -Fbs, data = treinamento)
previsaoFloresta2 <- predict(floresta, newdata = teste, type = "class")
mean(previsao.floresta2,teste$AHD)
 
#transformando a importancia em um data frame
 
importancia <- as.data.frame(importance(floresta))
importancia$MeanDecreaseGini
 
#row.names(importancia)!!!! como colocou os nomes, de onde tirou
 
importancia$variaveis <- row.names(importancia)
importancia
 
ggplot(importancia,aes(y = variaveis, x = MeanDecreaseGini))+
  geom_col()
 
##colocando em ordem agora
 
library(dplyr)
 
importancia |>
  mutate(variaveis = reorder(variaveis. -MeanDecreaseGini))|>
  ggplot(aes(y=variaveis, x=MeanDecreaseGini))+
  geom_col(fill = "darkred")+
  theme_minimal()
 
