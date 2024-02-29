##%#####################################################################%##
#                                                                         #
####                           Data analysis                           ####
####                      Spatial autocorrelation                      ####
####                        Vitor Borges-Júnior                        ####
####                       Created on 28 Nov 2023                      ####
#                                                                         #
##%#####################################################################%##

# The objective of the script is to define the best autocorrelation 
# function, if any, that explains the epizootic events and the landscape 
# metrics measured at a radius of 100 m
# y = dependent variable
# x = independent variable
# FC = forest cover
# FM = fragmentation metric

# load data and functions -------------------------------------------------

# load(here::here("ep_landscape_metrics_transformed.RData"))
# load(here::here("yf-data-analysis-2024-02-26.RData"))
source(here::here("data-analysis/scale-of-effect.R"))
source(here::here("R/autocorrelation_function_adjustment_selection.R"))

# Defining dependent variable ---------------------------------------------

# y1
status <- "status"

# y2
edge_density_200 <- edge_density[2]

# y3
n_patches_200 <- n_patches[2]

# Define independent variables --------------------------------------------

# x1 = FC
habitat_amount_200 <- habitat_amount[2]

# x2 = FM = edge_density
# x3 = FM = n_patches

# Define group with single level -------------------------------------

group <- 1

# define spatial data tables
# y1 = status
# x1 = FC = habitat amount
# x2 = FM = edge density
spatial_data1 <- tibble(
  status = ep_landscape_metrics_transformed$status,
  pland200_ztransformed = ep_landscape_metrics_transformed$pland200_ztransformed,
  ed200_ztransformed = ep_landscape_metrics_transformed$ed200_ztransformed,
  coords,
  random = ep_landscape_metrics_transformed$random,
  group
)

# y1 = status
# x1 = FC = habitat amount
# x2 = FM = number of patches
spatial_data2 <- tibble(
  status = ep_landscape_metrics_transformed$status,
  pland200_ztransformed = ep_landscape_metrics_transformed$pland200_ztransformed,
  np200_ztransformed = ep_landscape_metrics_transformed$np200_ztransformed,
  coords,
  random = ep_landscape_metrics_transformed$random,
  group
)

# y2 = FM = edge density
# x1 = FC = habitat amount
spatial_data3 <- tibble(
  ed200_ztransformed = ep_landscape_metrics_transformed$ed200_ztransformed,
  pland200_ztransformed = ep_landscape_metrics_transformed$pland200_ztransformed,
  coords,
  random = ep_landscape_metrics_transformed$random,
  group
)

# y3 = FM = number of patches
# x1 = FC = habitat amount
spatial_data4 <- tibble(
  np200_ztransformed = ep_landscape_metrics_transformed$np200_ztransformed,
  pland200_ztransformed = ep_landscape_metrics_transformed$pland200_ztransformed,
  coords,
  random = ep_landscape_metrics_transformed$random,
  group
)

# Define spatial autocorrelation functions -------------

# Matern
matern <- " + mat(coords + 0 | group)"

# Gaussian
gaussian <- " + gau(coords + 0 | group)"

# Exponential
exponential <- "+ exp(coords + 0 | group)"

# spatial autocorrelation functions
spatial_autocorrelation_functions <- c(
  matern = matern,
  gaussian = gaussian,
  exponential = exponential
)

# Defining alternative models - y1 = status ------------------------------

# fragmentation measure = edge density
models_status_autocorrelation1 <- spatial_autocorrelation_functions |> 
  purrr::map(
    \(.x) formula(
      paste0(
        status,
        "~", 
        habitat_amount_200, 
        "+", 
        edge_density_200, 
        random,
        .x
      )
    )
  )

# include null model
models_status_autocorrelation1 <- c(
  null = formula(
    paste0(
      status,
      "~", 
      habitat_amount_200, 
      "+", 
      edge_density_200, 
      random
    )
  ),
  models_status_autocorrelation1
)

# fragmentation measure = number of patches
models_status_autocorrelation2 <- spatial_autocorrelation_functions |> 
  purrr::map(
    \(.x) formula(
      paste0(
        status,
        "~", 
        habitat_amount_200, 
        "+", 
        n_patches_200, 
        random,
        .x
      )
    )
  )

# include null model
models_status_autocorrelation2 <- c(
  null = formula(
    paste0(
      status,
      "~", 
      habitat_amount_200, 
      "+", 
      n_patches_200, 
      random
    )
  ),
  models_status_autocorrelation2
)

# Defining alternative models - y2 = edge density ------------------------------
models_ed_autocorrelation <- spatial_autocorrelation_functions |> 
  purrr::map(
    \(.x) formula(
      paste0(
        edge_density_200, 
        "~", 
        habitat_amount_200, 
        random,
        .x
      )
    )
  )

# include null model
models_ed_autocorrelation <- c(
  null = formula(
    paste0(
      edge_density_200, 
      "~", 
      habitat_amount_200, 
      random
    )
  ),
  models_ed_autocorrelation
)

# Defining alternative models - y3 = number of patches ------------------------------
models_np_autocorrelation <- spatial_autocorrelation_functions |> 
  purrr::map(
    \(.x) formula(
      paste0(
        n_patches_200, 
        "~", 
        habitat_amount_200, 
        random,
        .x
      )
    )
  )

# include null model
models_np_autocorrelation <- c(
  null = formula(
    paste0(
      n_patches_200, 
      "~", 
      habitat_amount_200, 
      random
    )
  ),
  models_np_autocorrelation
)

# Defining spatial autocorrelation - y1 = status ---------------------------------

# x1 = FC = habitat amount
# x2 = FM = edge effects
spatial_autocorrelation_status_ed <- autocorrelation_function_adjustment_selection(
  data = spatial_data1,
  models = models_status_autocorrelation1,
  family = "binomial"
)

spatial_autocorrelation_status_ed$model_selection_table
# spatial_autocorrelation_status_ed$models

# x1 = FC = habitat amount
# x2 = FM = number of patches
spatial_autocorrelation_status_np <- autocorrelation_function_adjustment_selection(
  data = spatial_data2, 
  models = models_status_autocorrelation2, 
  family = "binomial"
)

spatial_autocorrelation_status_np$model_selection_table
# spatial_autocorrelation_status_ed$models

# Defining spatial autocorrelation - y2 = edge density ---------------------------------

# x1 = FC = habitat amount
# spatial_autocorrelation_ed <- autocorrelation_function_adjustment_selection(
#   data = spatial_data3,
#   models = models_ed_autocorrelation,
#   family = "gaussian"
# )
# 
# spatial_autocorrelation_ed$model_selection_table
# spatial_autocorrelation_status_ed$models

# models did not converge - alternative solution
# null model - ok
null_ed <- glmmTMB::glmmTMB(
  formula = models_ed_autocorrelation$null,
  data = spatial_data3,
  family = "gaussian",
  REML = TRUE,
  control = glmmTMBControl(
    optimizer = optim, 
    optArgs = list(method = "BFGS")
  )
)

# marten model - not ok
marten_ed <- glmmTMB::glmmTMB(
  formula = models_ed_autocorrelation$matern,
  data = spatial_data3,
  family = "gaussian",
  dispformula = ~ 0,
  REML = TRUE,
  control = glmmTMBControl(
    optimizer = optim,
    optArgs = list(
      method = "CG"
    )
  )
)

# Warning message:
#   In finalizeTMB(TMBStruc, obj, fit, h, data.tmb.old) :
#   Model convergence problem; . See vignette('troubleshooting'), help('diagnose')

# gaussian model - ok
gaussian_ed <- glmmTMB::glmmTMB(
  formula = models_ed_autocorrelation$gaussian,
  data = spatial_data3,
  family = "gaussian",
  dispformula = ~ 0,
  REML = TRUE,
  control = glmmTMBControl(
    optimizer = optim, 
    optArgs = list(method = "BFGS")
  )
)

# exponential model - ok
exponential_ed <- glmmTMB::glmmTMB(
  formula = models_ed_autocorrelation$exponential,
  data = spatial_data3,
  family = "gaussian",
  dispformula = ~ 1,
  REML = TRUE,
  control = glmmTMBControl(
    optimizer = optim, 
    optArgs = list(method = "BFGS")
  )
)

# bind all model results in the same list
models_results_ed <- list(
  null = null_ed,
  marten = marten_ed,
  gaussian = gaussian_ed,
  exponential = exponential_ed
)

# run model selection
m_selection_ed <- MuMIn::model.sel(
  object = models_results_ed
) 

# generate model selection table
m_sel_tab_ed <- tibble::tibble(Modelo = row.names(m_selection_ed),
                            gl = m_selection_ed$df,
                            logLik = round(m_selection_ed$logLik, 2),
                            AICc = round(m_selection_ed$AICc, 2),
                            deltaAICc = round(m_selection_ed$delta, 2),
                            wi = round(m_selection_ed$weight, 3)) 

# Defining spatial autocorrelation - y3 = number of patches ---------------------------------

# x1 = FC = habitat amount
spatial_autocorrelation_np <- autocorrelation_function_adjustment_selection(
  data = spatial_data4,
  models = models_np_autocorrelation,
  family = "gaussian"
)

spatial_autocorrelation_np$model_selection_table
# spatial_autocorrelation_status_ed$models

# models did not converge - alternative solution
# null model - ok
# null_np <- glmmTMB::glmmTMB(
#   formula = models_np_autocorrelation$null,
#   data = spatial_data4,
#   family = "gaussian",
#   REML = TRUE,
#   control = glmmTMBControl(
#     optimizer = optim, 
#     optArgs = list(
#       method = "Nelder-Mead"
#     )
#   )
# )
# 
# marten model
# marten_np <- glmmTMB::glmmTMB(
#   formula = models_np_autocorrelation$matern,
#   data = spatial_data4,
#   family = "gaussian",
#   dispformula = ~ 0,
#   REML = TRUE,
#   control = glmmTMBControl(
#     optArgs = list(
#       method = "CG"
#     ),
#     optimizer = optim
#   )
# )
# 
# Warning message:
#   In finalizeTMB(TMBStruc, obj, fit, h, data.tmb.old) :
#   Model convergence problem; . See vignette('troubleshooting'), help('diagnose')

# gaussian model
# gaussian_np <- glmmTMB::glmmTMB(
#   formula = models_np_autocorrelation$gaussian,
#   data = spatial_data4,
#   family = "gaussian",
#   dispformula = ~ 0,
#   REML = TRUE,
#   control = glmmTMBControl(
#     optimizer = optim, 
#     optArgs = list(
#       method = "L-BFGS-B"
#     )
#   )
# )
# 
# Warning messages:
#   1: In finalizeTMB(TMBStruc, obj, fit, h, data.tmb.old) :
#   Model convergence problem; non-positive-definite Hessian matrix. See vignette('troubleshooting')

# exponential model - ok
# exponential_np <- glmmTMB::glmmTMB(
#   formula = models_np_autocorrelation$exponential,
#   data = spatial_data4,
#   family = "gaussian",
#   dispformula = ~ 1,
#   REML = TRUE,
#   control = glmmTMBControl(
#     optArgs = list(
#       method = "BFGS"
#     ),
#     optimizer = optim
#   )
# )
# 
# Warning message:
#   In finalizeTMB(TMBStruc, obj, fit, h, data.tmb.old) :
#   Model convergence problem; . See vignette('troubleshooting'), help('diagnose')

# bind all model results in the same list
# models_results_np <- list(
#   null = null_np,
#   marten = marten_np,
#   gaussian = gaussian_np,
#   exponential = exponential_np
# )
# 
# run model selection
# m_selection_np <- MuMIn::model.sel(
#   object = models_results_np
# ) 
# 
# generate model selection table
# m_sel_tab_np <- tibble::tibble(Modelo = row.names(m_selection_np),
#                                gl = m_selection_np$df,
#                                logLik = round(m_selection_np$logLik, 2),
#                                AICc = round(m_selection_np$AICc, 2),
#                                deltaAICc = round(m_selection_np$delta, 2),
#                                wi = round(m_selection_np$weight, 3)) 
# 
# rm(list = ls())