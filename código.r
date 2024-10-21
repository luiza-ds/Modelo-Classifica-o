library(class)
library(caret)
library(rpart)
library(rpart.plot)
library(randomForest)

cancer <- read.csv("cancer.csv", header = T, sep = ",")

cancer$diagnosis <- as.factor(cancer$diagnosis)

#selecionando 80% do conjunto de dados
n <- round(0.8*nrow(cancer))

# Sorteando 80% dos dados para treino
indices_treino <- sample(1:nrow(cancer), size = 450, replace = FALSE)

#atribuindo para cada grupo
treino <- cancer[indices_treino,]
teste <- cancer[- indices_treino,]

validacao_cruzada <- trainControl(method = "cv", number = 10) #cross validation

valores_k <- data.frame(k = 1:20)

modelo <- train(x = treino[,-1], y = treino$diagnosis, method = "knn", preProcess = c("center", "scale"), 
                trControl = validacao_cruzada, tuneGrid = valores_k)
modelo
plot(modelo) ##lugares em que o numero k (vizinhos) podem ser melhores de testar

###fazendo o modelo knn com a quantidade de vizinhos desejadas e depois calculando a acuracia

modelo_knn <- knn(train = scale(treino[,-1]),test = scale(teste[,-1]), cl = treino$diagnosis,k = 16)
mean(modelo_knn == teste$diagnosis) #tirando a primeira coluna tanto do grupo de treino e teste já que é a variavel resposta

resultados <- data.frame(modelo = "knn", acuracia = mean(modelo_knn == teste$diagnosis))

### modelo arvore de decisao
modelo_arvore <- rpart(formula = diagnosis ~.,data = treino, method = "class")
rpart.plot(modelo_arvore, extra = 101)

#usando a função predict
previsao_arvore <- predict(modelo_arvore, newdata = teste, type = "class")
acuracia_arvore <- mean(previsao_arvore ==teste$diagnosis)
resultados <- rbind(resultados, c(modelo = "arvore", acuracia = mean(previsao_arvore ==teste$diagnosis)))

###
modelo_floresta <-randomForest(formula = diagnosis ~.,data = treino)

previsa_floresta <- predict(modelo_floresta, newdata = teste, type = "class")
acuracia_floresta <- mean(previsa_floresta == teste$diagnosis)
resultados<- rbind(resultados, c(modelo = "floresta", acuracia = acuracia_floresta))


resultados$acuracia <-round(as.numeric(resultados$acuracia), digits = 4)
colnames(resultados) <- c("Modelo", "Acurácia")
