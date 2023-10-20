##%#########################################%##
#                                             #
####              Tidy data                ####
####       Transform landscape data        ####
####        Vitor Borges-Júnior            ####
####       Created on 18 Oct 2023          ####
#                                             #
##%#########################################%##

# Load data -------------------------------------------
source(here::here("data/landscape-metrics.R"))

# Load packages -------------------------------------------
source(here::here("R/dependencies.R"))

# prepere landscape data -------------------------------------------
landscape_metrics <- landscape_metrics |> 
  dplyr::mutate(
    unit = "m",
    cover_category = dplyr::case_when(
      value < 25 ~ "0-25%",
      value >= 25 & value < 50 ~ "25-50%",
      value >= 50 & value < 75 ~ "50-75%",
      value >= 75 ~ "75-100%"
    ),
    np_category = dplyr::case_when(
      value < 50 ~ "0-50",
      value >= 50 & value < 100 ~ "50-100",
      value >= 100 & value < 150 ~ "100-150",
      value >= 150 & value < 200 ~ "150-200",
      value >= 200 & value < 250 ~ "200-250"
    ),
    .before = value
  ) |> 
  tidyr::unite(
    buffer1,
    buffer,
    unit,
    sep = ""
  ) |> 
  dplyr::rename(
    buffer = buffer1
  ) |> 
  dplyr::mutate(
    buffer = forcats::fct_relevel(
      as.factor(buffer),
      "40m",
      "100m",
      "200m",
      "400m",
      "1000m",
      "2000m",
      "5000m"
    )
  ) 

# forest cover -------------------------------------------
# data distribution
pland <- landscape_metrics |> 
  dplyr::filter(metric == "pland")

# ep x forest cover
ep_pland <- pland |> 
  dplyr::count(
    buffer,
    cover_category,
    status
  ) |> 
  dplyr::right_join(
    pland,
    dplyr::join_by(
      buffer,
      cover_category,
      status
    )
  )

# number of patches -------------------------------------------
# data distribution
np <- landscape_metrics |> 
  dplyr::filter(metric == "np") 

# ep x np
ep_np <- np |> 
  dplyr::count(
    buffer,
    np_category,
    status
  ) |> 
  dplyr::right_join(
    np,
    dplyr::join_by(
      buffer,
      np_category,
      status
    )
  )

# edge density -------------------------------------------
# data distribution
ed <- landscape_metrics |> 
  dplyr::filter(metric == "ed") |> 
  dplyr::mutate(
    value = vegan::decostand(
      x = value,
      method = "standardize"
    )
  ) |> 
  dplyr::mutate(
    ed_category = dplyr::case_when(
      value < -0.5 ~ "-1.5--0.5",
      value >= -0.5 & value < 0.5 ~ "-0.5-0.5",
      value >= 0.5 & value < 1.5 ~ "0.5-1.5",
      value >= 1.5 & value < 2.5 ~ "1.5-2.5",
      value >= 2.5 & value < 3.5 ~ "2.5-3.5",
      value >= 3.5 & value < 4.5 ~ "2.5-3.5",
      value >= 4.5 & value < 5.5 ~ "4.5-5.5",
      value < 5.5 ~ "5.5-6.5"
    ),
    .before = value
  )

# ep x ed
ep_ed <- ed |> 
  dplyr::count(
    buffer,
    ed_category,
    status
  ) |> 
  dplyr::right_join(
    ed,
    dplyr::join_by(
      buffer,
      ed_category,
      status
    )
  )

# PNH genus -------------------------------------------
# ep x np
ep_genus_metrics <- landscape_metrics |> 
  dplyr::count(
    buffer,
    metric,
    genero
  ) |> 
  dplyr::right_join(
    landscape_metrics,
    dplyr::join_by(
      buffer,
      metric,
      genero
    )
  )

# rm(list = ls())