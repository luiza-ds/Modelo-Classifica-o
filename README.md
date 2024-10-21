Com o banco de dados sobre o diagnóstico de câncer (B para benigno e M para maligno) e suas características.

Váriável Resposta: "diagnosis".

Explicação das outras variáveis:
A variável 'radius_mean' representa a média das distâncias do centro aos pontos no perímetro. 'Texture_mean' refere-se ao desvio padrão dos valores em escala de cinza, enquanto 'perimeter_mean' e 'area_mean indicam', respectivamente, a média do perímetro e da área. A 'smoothness_mean' mede a variação local nos comprimentos dos raios, e a 'compactness_mean' é calculada como (perímetro² / área - 1.0). Já a 'concavity_mean' avalia a severidade das partes côncavas do contorno, e 'concave points_mean' corresponde ao número de partes côncavas do contorno. A 'symmetry_mean' mede a simetria, enquanto a 'fractal dimension_mean' se refere à "aproximação da linha costeira" menos 1, uma medida de complexidade do contorno.

Iremos fazer um modelo de previsão supervisionado com esse banco de dados. Ou seja, obtendo uma variável resposta iremos utilizar de funções como "KNN", "Árvore de Decisão" e "RandomForest" para que com baseado nas características ele me devolva se o paciente possui um tumor benigno ou maligno. 

Começamos baixando nossos pacotes:

![image](https://github.com/user-attachments/assets/8688e866-4447-4cf0-a82e-84b641ca7136)

Logo em seguida, lemos nosso banco de dados e tratamos como fator nossa variável resposta. 

Para começar a análise, iremos sortear 80% desse banco de dados para ser o nosso grupo de treinamento(dados conhecidos) e os outros 20% será nosso grupo teste (dados desconhecidos para testarmos o modelo). 

(Melhor explicação para a razão de haver um grupo de treino e outro de teste: 
Grupo de Treinamento:
Esse é o grupo de dados que o modelo usa para aprender. Aqui, ele vai entender como os exemplos funcionam, como se estivesse estudando para uma prova.
Grupo de Teste:
Esse é o grupo de dados que o modelo nunca viu antes. Depois que ele aprendeu com o grupo de treinamento, testamos ele com esses dados para ver se realmente entendeu bem e consegue acertar em situações novas, como se estivesse fazendo a prova.
Evitando que o modelo apenas decore os padrões.)

Em seguida faremos uma validação cruzada que me ajudará a obter um modelo de previsão mais acurado possível. 

Como o modelo KNN é um modelo que utiliza a distância entre os vizinhos mais próximos para calcular as característica em comum, criamos uma varável de 1 a 20 para irmos testando qual numero de vizinhos é o melhor para a acuracia do nosso modelo.

Usaremos essa função seguinte para nos ajudar a identificar a melhor quantidade de vizinhos:

![image](https://github.com/user-attachments/assets/8248881f-7c3f-47cc-8e05-c46e49e8b67e)

Plotando essa função...

![vizinhos](https://github.com/user-attachments/assets/742c67c2-367f-4da0-b130-671212813282)

Conforme nosso gráfico, testaremos com o número 16 de vizinhos, então...
![image](https://github.com/user-attachments/assets/cad41759-fe48-4d9b-b904-ca14bbdb1b3c)

E logo em seguida faremos a acurácia das previsões do meu modelo treinado com a do meu grupo teste (sem saber a resposta e nunca treinado) e assim poderemos analisar se o nosso modelo está sabendo prever adequadamente ou não.

Com uma acurácia de 0.9747899 ou aproximadamente 97% estamos acertando baseado nas minhas variáveis (características do tumor) se o tumos é benigno ou maligno.

**IMPORTANTE: A função scale() é uma ferramenta valiosa para normalizar dados antes de aplicar algoritmos de aprendizado de máquina. Ela garante que todas as variáveis contribuam de maneira equitativa e pode melhorar o desempenho e a eficiência dos modelos.


