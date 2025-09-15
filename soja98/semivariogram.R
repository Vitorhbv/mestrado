# Instalar e carregar o pacote geoR (se ainda não estiver instalado)
require(geoR)
require(tcltk)
library(geoR)

# Carregar o conjunto de dados
data(soja98)
# Selecionar as colunas 1, 2 (coordenadas) e 6 (dados)
dados_soja <- soja98[, c(1, 2, 6)]
names(dados_soja) <- c("coordX", "coordY", "materia_organica")
dados_soja

#a)
# Criar o objeto geodata
geodata_soja <- as.geodata(dados_soja, coords.col = 1:2, data.col = 3)
geodata_soja

#histograma e sumario
hist(
    geodata_soja$data,
    10,
    xlab = "Matéria Orgânica",
    ylab = "densidade",
    main = "",
    freq = F,
    cex.lab = 1.1,
    cex.axis = 1.1
)
summary(geodata_soja$data)

# Disposicao espacial (materia organica)
plot(
    geodata_soja$coords,
    pch = 20,
    cex = 1.5,
    col = "blue",
    xlab = "Coord X",
    ylab = "Coord Y",
    main = "Disposição Espacial da Matéria Orgânica"
)

#b)
# Calcular e plotar os semivariogramas direcionais
# O objeto geodata_soja foi criado no item (a)

sevariograma_all <- variog4(geodata_soja)
plot(sevariograma_all, lwd = 3)


#c)
# Calculando semiovariograma empirico (processo sem tendencia)
svariograma_empirico <- variog(
    geodata_soja,
    estimator.type = "classical",
    direction = "omnidirectional",
    trend = "cte",
    uvec = seq(0, 100, l = 50)
)
plot(
    svariograma_empirico,
    pch = 19,
    cex.lab = 1.3,
    cex.axis = 1.3,
    main = "Dados de Matéria Orgânica - Semivariograma Empírico",
    xlab = "Distância (h)",
    ylab = "Semivariância"
)


#d)
#Ajustando modelos teóricos ao semivariograma empírico no olho
library(tcltk)
v.eye = eyefit(svariograma_empirico)
v.eye

#1 eyefit: cov.model = exponential   phi=47.67 sigma2=54.05  tau2=6.81  kappa1=<NA>   kappa2=<NA>
#praticalRange=161.919329382638

phi = 54.05
tau2 = 6.81
sig2 = 47.67
# Ajuste de semiovariograma exponencial com leastsquares
v.exp = variofit(
    svariograma_empirico,
    cov.model = "exponential",
    ini = c(sig2, phi),
    nugget = tau2
)
v.exp
#plot
plot(
    svariograma_empirico,
    pch = 19,
    cex.lab = 1.3,
    cex.axis = 1.3,
    main = "Dados de Matéria Orgânica - Semivariograma Empírico",
    xlab = "Distância (h)",
    ylab = "Semivariância"
)
lines(v.exp, col = "blue", lwd = 2)


#e) calculando o semivariograma com tendência
#mu(s) = beta0 + beta1*x + beta2*y
svariograma_empirico_trend <- variog(
    geodata_soja,
    estimator.type = "classical",
    direction = "omnidirectional",
    trend = "1st",
    uvec = seq(0, 100, l = 50)
)
plot(
    svariograma_empirico_trend,
    pch = 19,
    cex.lab = 1.3,
    cex.axis = 1.3,
    main = "Dados de Matéria Orgânica com Tendência - Semivariograma Empírico",
    xlab = "Distância (h)",
    ylab = "Semivariância"
)
#considerando o semiovariograma com tendencia mostra um comportamento de um processo estacionário.
