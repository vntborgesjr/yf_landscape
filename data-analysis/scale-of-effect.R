##%#########################################%##
#                                             #
####           Data analysis               ####
####          Scale of effect              ####
####        Vitor Borges-Júnior            ####
####       Created on 28 Nov 2023          ####
#                                             #
##%#########################################%##

# The objective of the script is to define the extent of the landscape that best
# predict the occurrence of epizootic events

# load data and functions -------------------------------------------------

load(here::here("ep_landscape_metrics_transformed.RData"))
# source(here::here("data-analysis/landscape-metrics.R"))
source(here::here("R/scale_effect_adjustment_selection.R"))

# Defining dependent variable ---------------------------------------------

status <- "status"

# Define independent variables --------------------------------------------

edge_density <- c(names(ep_landscape_metrics_transformed)[30:36])
n_patches <- c(names(ep_landscape_metrics_transformed)[37:43])
habitat_amount <- c(names(ep_landscape_metrics_transformed)[44:50])

# Define spatial position --------------------------------------------

coords <- glmmTMB::numFactor(
  sf::st_coordinates(ep_landscape_metrics_transformed$geometry)
)

# names(coords) <- c("x", "y")

ep_landscape_metrics_transformed$coords <- coords

ep_landscape_metrics_transformed$group <- 1

# Defining a group level factor - random effect --------------------------------------

n_rep <- ep_landscape_metrics_transformed |> 
  dplyr::arrange(geometry) |> 
  dplyr::count(geometry)


ep_landscape_metrics_transformed <- ep_landscape_metrics_transformed |> 
  dplyr::arrange(geometry) |> 
  dplyr::mutate(
    random = rep(
      seq_along(levels(coords)), 
      n_rep$n
    )
  ) |> 
  dplyr::relocate(
    random,
    .before = geometry
  )

# Defining random effect ---------------------------------------------

random <- " + (1 | random)"

# Defining alternative models - edge density ------------------------------

models_ed <- habitat_amount |> 
  purrr::map2(
    edge_density,
    \(.x, .y) formula(
      paste0(
        status, 
        "~", 
        .x,
        "+",
        .y, 
        random
      )
    )
  )

# include null model
models_ed <- c(
  formula(
    paste0(
      status, 
      "~ 1",
      random
    )
  ),
  models_ed
)

# Defining alternative models - number of patches ------------------------------

models_np <- habitat_amount |> 
  purrr::map2(
    n_patches,
    \(.x, .y) formula(
      paste0(
        status, 
        "~", 
        .x,
        "+",
        .y, 
        random
      )
    )
  )

# include null model
models_np <- c(
  formula(
    paste0(
      status, 
      "~ 1",
      random
    )
  ),
  models_np
)

# Defining alternative models - habitat amount ------------------------------
# 
# models_ha <- habitat_amount |> 
#   purrr::map(
#     \(.x) formula(
#       paste0(status, "~", .x)
#     )
#   )
# 
# Defining scale of effect - edge density ---------------------------------

scale_of_effect_ed <- scale_effect_adjustment_selection(
  data = ep_landscape_metrics_transformed, 
  models = models_ed,
  family = "binomial"
)

scale_of_effect_ed$model_selection_table
# scale_of_effect_ed$models

# Defining scale of effect - number of patches ---------------------------------

scale_of_effect_np <- scale_effect_adjustment_selection(
  data = ep_landscape_metrics_transformed, 
  models = models_np, 
  family = "binomial"
)

scale_of_effect_np$model_selection_table
# scale_of_effect_np$models

# Defining scale of effect - habitat amount ---------------------------------
# 
# scale_of_effect_ha <- model_adjustment_selection(data = ep_landscape_metrics_transformed, 
#                                           models = models_ha, 
#                                           FUN = glmmTMB::glmmTMB,  
#                                           family = "binomial")
# 
# scale_of_effect_ha$model_selection_table
# scale_of_effect_ha$models

# save.image("~/Documentos/temp/yf_landscape/ep_landscape_metrics_transformed.RData") 

# rm(list = ls())