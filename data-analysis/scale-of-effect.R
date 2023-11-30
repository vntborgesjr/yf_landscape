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

source(here::here("data-analysis/landscape-metrics.R"))
source(here::here("R/model_adjustment_selection.R"))

# Defining dependent variable ---------------------------------------------

status <- "status"

# Define independent variables --------------------------------------------

edge_density <- c("1", names(ep_landscape_metrics_transformed)[31:36])
n_patches <- c("1", names(ep_landscape_metrics_transformed)[38:43])
habitat_amount <- c("1", names(ep_landscape_metrics_transformed)[45:50])

# Defining alternative models - edge density ------------------------------

models_ed <- edge_density |> 
  purrr::map(
    \(.x) formula(
      paste0(status, "~", .x)
    )
  )

# Defining alternative models - edge density ------------------------------

models_np <- n_patches |> 
  purrr::map(
    \(.x) formula(
      paste0(status, "~", .x)
    )
  )

# Defining alternative models - edge density ------------------------------

models_ha <- habitat_amount |> 
  purrr::map(
    \(.x) formula(
      paste0(status, "~", .x)
    )
  )

# Defining scale of effect - edge density ---------------------------------

scale_of_effect_ed <- model_adjustment_selection(data = ep_landscape_metrics_transformed, 
                                            models = models_ed, 
                                            FUN = glmmTMB::glmmTMB,  
                                            family = "binomial")

scale_of_effect_ed$model_selection_table
# scale_of_effect_ed$models

# Defining scale of effect - number of patches ---------------------------------

scale_of_effect_np <- model_adjustment_selection(data = ep_landscape_metrics_transformed, 
                                          models = models_np, 
                                          FUN = glmmTMB::glmmTMB,  
                                          family = "binomial")

scale_of_effect_np$model_selection_table
# scale_of_effect_np$models

# Defining scale of effect - habitat amount ---------------------------------

scale_of_effect_ha <- model_adjustment_selection(data = ep_landscape_metrics_transformed, 
                                          models = models_ha, 
                                          FUN = glmmTMB::glmmTMB,  
                                          family = "binomial")

scale_of_effect_ha$model_selection_table
# scale_of_effect_ha$models
  
# rm(list = ls())