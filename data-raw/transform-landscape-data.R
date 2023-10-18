##%#########################################%##
#                                             #
####              Tidy data                ####
####       Transform landscape data        ####
####        Vitor Borges-Júnior            ####
####       Created on 12 Oct 2023          ####
#                                             #
##%#########################################%##

# Load data -------------------------------------------
source(here::here("data/landscape-metrics.R"))

# Load packages -------------------------------------------
source(here::here("R/dependencies.R"))

# Create table with epizooties and landscape metrics -------------------------------------------
# cities names
cities_names <- names(ep_cities_data)

# select the first plot id of each list
# create a new column with cities names
lands_metrics_list <- all_cover_metric40 |> 
  map2(
    cities_names,
    \(.x, .y) .x |> 
      dplyr::filter(
        plot_id  == 1,
        class == 1
      ) |> 
      dplyr::select(2, 5:6) |> 
      dplyr::mutate(
        name_muni = .y,
        .before = level
      ) 
  )

# join to original epizooties data
ep_lands_metrics_list <- lands_metrics_list |> 
  map2(
    ep_cities_data,
    \(.x, .y) .x |> 
      left_join(
        y = .y,
        by = join_by("name_muni"),
        relationship = "many-to-many"
      )
  )

# bind all data together -------------------------------------------
ep_lands_metrics <- map(
  ep_lands_metrics_list,
  \(.x) .x
) |> 
  list_rbind()

# Create one data table for each metric -------------------------------------------
# habitat amount
pland <- ep_lands_metrics |> 
  filter(metric == "pland")

# number of paches
np <- ep_lands_metrics |> 
  filter(metric == "np")

# edge density
ed <- ep_lands_metrics |> 
  filter(metric == "ed") |> 
  mutate(
    value = round(vegan::decostand(
      value,
      method = "standardize"
    )[, 1], 1)
  )

# Summarize data for relationship exploration -------------------------------------------

# forest cover -------------------------------------------
ep_count <- pland |> 
  dplyr::select(
    1, 3, 4, 18, 19, -geometry
  )

pland_summarize <- pland |> 
  count(
    name_muni,
    status
  ) |> 
  inner_join(
    ep_count,
    join_by(
      "name_muni",
      "status"
    )
  ) |> 
  distinct() |> 
  mutate(cover_category = case_when(
    value < 15 ~ "0-15",
    value >= 15 & value < 30 ~ "15-30",
    value >= 30 ~ "> 30"
  ),
  cover_category = fct_relevel(
    cover_category,
    "0-15",
    "15-30",
    "> 30"
  ),
  .before = value
)

# number of patches -------------------------------------------
ep_count <- np |> 
  dplyr::select(
    1, 3, 4, 18, 19, -geometry
  )

np_summarize <- np |> 
  count(
    name_muni,
    status
  ) |> 
  inner_join(
    ep_count,
    join_by(
      "name_muni",
      "status"
    )
  ) |> 
  distinct() |> 
  mutate(
    np_category = case_when(
    value < 500 ~ "0-500",
    value >= 500 & value < 1000 ~ "500-1000",
    value >= 1000 ~ "> 1000"
  ),
  np_category = fct_relevel(
    np_category,
    "0-500",
    "500-1000",
    "> 1000"
  ),
  .before = value
  )

# edge density -------------------------------------------
ep_count <- ed |> 
  dplyr::select(
    1, 3, 4, 18, 19, -geometry
  ) 
View(ed_summarize)
ed_summarize <- ed |> 
  count(
    name_muni,
    status
  ) |> 
  inner_join(
    ep_count,
    join_by(
      "name_muni",
      "status"
    )
  ) |> 
  distinct() |> 
  mutate(ed_category = case_when(
    value < -1 ~ "(-2)-(-1)",
    value >= -1 & value < 1 ~ "(-1)-1",
    value >= 1 ~ "> 1"
  ),
  ed_category = fct_relevel(
    ed_category,
    "(-2)-(-1)",
    "(-1)-1",
    "> 1"
  ),
  .before = value
  )

# rm(list = ls())