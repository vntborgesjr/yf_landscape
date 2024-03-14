# what's (co)variance? -------------------------------------------------

# variance of epizootic
(y1 <- var(ep_landscape_metrics_transformed$status))

# variance of forest cover
(x1 <- var(ep_landscape_metrics_transformed$pland200))

# variance of fragmentation measure
# edge density
(x2 <- var(ep_landscape_metrics_transformed$ed200))

# number of patches
(x3 <- var(ep_landscape_metrics_transformed$np200))

# covariance
# forest cover
(cov1 <- cov(
  ep_landscape_metrics_transformed$status, 
  ep_landscape_metrics_transformed$pland200
))

# edge density
(cov2 <- cov(
  ep_landscape_metrics_transformed$status, 
  ep_landscape_metrics_transformed$ed200
))

# n of patches
(cov3 <- cov(
  ep_landscape_metrics_transformed$status, 
  ep_landscape_metrics_transformed$np200
))

# edge density
(cov4 <- cov(
  ep_landscape_metrics_transformed$pland200, 
  ep_landscape_metrics_transformed$ed200
))

# n of patches
(cov5 <- cov(
  ep_landscape_metrics_transformed$pland200, 
  ep_landscape_metrics_transformed$np200
))

# Z-transformation
# variance of forest cover
(x1 <- var(ep_landscape_metrics_transformed$pland200_ztransformed))

# variance of fragmentation measure
# edge density
(x2 <- var(ep_landscape_metrics_transformed$ed200_ztransformed))

# number of patches
(x3 <- var(ep_landscape_metrics_transformed$np200_ztransformed))

# covariance
# forest cover
(cov1 <- cov(
  scale(ep_landscape_metrics_transformed$status), 
  ep_landscape_metrics_transformed$pland200_ztransformed
))

# edge density
(cov2 <- cov(
  scale(ep_landscape_metrics_transformed$status), 
  ep_landscape_metrics_transformed$ed200_ztransformed
))

# n of patches
(cov3 <- cov(
  scale(ep_landscape_metrics_transformed$status), 
  ep_landscape_metrics_transformed$np200_ztransformed
))

# edge density
(cov4 <- cov(
  ep_landscape_metrics_transformed$pland200_ztransformed, 
  ep_landscape_metrics_transformed$ed200_ztransformed
))

# n of patches
(cov5 <- cov(
  ep_landscape_metrics_transformed$pland200_ztransformed, 
  ep_landscape_metrics_transformed$np200_ztransformed
))

# the covariance of ztransformed variables equals to the pearson product
# moment correlation of untransformed variables
round(cov(
  ep_landscape_metrics_transformed$pland200_ztransformed, 
  ep_landscape_metrics_transformed$np200_ztransformed
), 7) == round(cor(
  ep_landscape_metrics_transformed$pland200, 
  ep_landscape_metrics_transformed$np200
), 7)

# dividing the covariance of x and y by the product of their standard 
# deviations, omits the need for the prior Z-transformation step 
# and achieves the same outcome
round((cov(
  ep_landscape_metrics_transformed$pland200, 
  ep_landscape_metrics_transformed$np200
)/(sd(ep_landscape_metrics_transformed$pland200) *
  sd(ep_landscape_metrics_transformed$np200))), 7) == round(cor(
    ep_landscape_metrics_transformed$pland200, 
    ep_landscape_metrics_transformed$np200
  ), 7)

# regression coefifcients --------------------------------------------

# In mathematical terms, the unstandardized coefficients are scaled by the 
# variance of the predictor, while the standardized variance by the ratio of
# the standard deviations of both x and y.

unstd.model <- lm(
  formula = status ~ pland200, 
  data = ep_landscape_metrics_transformed
)

# get unstandardized coefficient
summary(unstd.model)$coefficients[2, 1]

# now using covariance
(
  cov(
    ep_landscape_metrics_transformed$status, 
    ep_landscape_metrics_transformed$pland200
  ) / var(ep_landscape_metrics_transformed$pland200)
)

# repeat with scaled data
std.model <- lm(
  formula = status ~ pland200_ztransformed, 
  data = ep_landscape_metrics_transformed
)

# get standardized coefficient
summary(std.model)$coefficients[2, 1]

# now using correlation
cor(
  ep_landscape_metrics_transformed$status,
  ep_landscape_metrics_transformed$pland200_ztransformed
)

# global variance-covariance matrix
data_ed <- data.frame(
  y2 = ep_landscape_metrics_transformed$status,
  y1 = ep_landscape_metrics_transformed$ed200_ztransformed,
  x1 = ep_landscape_metrics_transformed$pland200_ztransformed
)

data_np <- data.frame(
  y2 = ep_landscape_metrics_transformed$status,
  y1 = ep_landscape_metrics_transformed$np200_ztransformed,
  x1 = ep_landscape_metrics_transformed$pland200_ztransformed
)

cov(data_ed)
cov(data_np)

# goodness of fit
# a significant P-value indicates poor fit

library(lavaan)
library(piecewiseSEM)

data(keeley)
str(keeley)

# Instale e carregue o pacote 'lavaan'
install.packages("lavaan")
library(lavaan)

# Criando dados de exemplo
dados <- data.frame(x = 1:10, y = c(2, 5, 6, 9, 10, 9, 10, 7, 8, 11))

# Definindo o modelo de equação estrutural com uma função quadrática
modelo <- '
# Definindo as relações entre as variáveis
y ~ b1*x + b2*I(x^2)

# Definindo a variância e covariância entre as variáveis
y ~~ y

# Definindo os parâmetros do modelo
b1 := 1
b2 := 1
'

# Ajustando o modelo aos dados
resultado <- sem(modelo, data = dados)

# Visualizando o resumo do modelo
summary(resultado)
