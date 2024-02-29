##%#####################################################################%##
#                                                                         #
####                            Data analysis                          ####
####                          Landscape metrics                        ####
####                         Vitor Borges-Júnior                       ####
####                        Created on 11 Oct 2023                     ####
#                                                                         #
##%#####################################################################%##

# Objective -------------------------------------------
# The objectives of the script are to calculate three landscape metrics ─ 
# edge density, number of patches and habitat amount ─ inside local 
# landscapes represented by seven concentric, circular buffer areas of 
# increase radii (100, 200, 400, 800, 1000, 2000, and 5000 m) around each 
# epizootic event and to create a wide data frame containing all epizootic 
# events and metrics

# Load data -------------------------------------------
source(here::here("data/landscape-spatial-data.R"))
# cities_cover <- raster::raster(here::here("data/cities-cover.tif"))

# Landscape metrics -------------------------------------------
# View(list_lsm("class"))
# edge density - "lsm_c_ed"
# number of patches - "lsm_c_np"
# habitat amount - "lsm_c_pland"
# check_landscape(cover_reclass3$ATIBAIA)
# need projection adjustment to SIRGAS2000 23z UTM

# Obtain all landscape metrics at once -------------------------------------------
# habitat cover, number of patches, and edge density
metrics <- c(
  "lsm_c_pland",
  "lsm_c_np",
  "lsm_c_ed"
)

# buffer of 100m -------------------------------------------
landscape_metrics100 <- buffer100 |> 
  purrr::map(
    \(.x) landscapemetrics::calculate_lsm(
      landscape = .x,
      what = metrics
    )
  ) |> 
  purrr::list_rbind(
    names_to = "id"
  )

# Buffer of 200m
landscape_metrics200 <- buffer200 |> 
  purrr::map(
    \(.x) landscapemetrics::calculate_lsm(
      landscape = .x,
      what = metrics
    )
  ) |> 
  purrr::list_rbind(
    names_to = "id"
  )

# Buffer of 400m
landscape_metrics400 <- buffer400 |> 
  purrr::map(
    \(.x) landscapemetrics::calculate_lsm(
      landscape = .x,
      what = metrics
    )
  ) |> 
  purrr::list_rbind(
    names_to = "id"
  )

# Buffer of 800m
landscape_metrics800 <- buffer800 |> 
  purrr::map(
    \(.x) landscapemetrics::calculate_lsm(
      landscape = .x,
      what = metrics
    )
  ) |> 
  purrr::list_rbind(
    names_to = "id"
  )

# Buffer of 1000m
landscape_metrics1000 <- buffer1000 |> 
  purrr::map(
    \(.x) landscapemetrics::calculate_lsm(
      landscape = .x,
      what = metrics
    )
  ) |> 
  purrr::list_rbind(
    names_to = "id"
  )

# Buffer of 2000m
landscape_metrics2000 <- buffer2000 |> 
  purrr::map(
    \(.x) landscapemetrics::calculate_lsm(
      landscape = .x,
      what = metrics, 
    )
  ) |> 
  purrr::list_rbind(
    names_to = "id"
  )

# Buffer of 5000m
landscape_metrics5000 <- buffer5000 |> 
  purrr::map(
    \(.x) landscapemetrics::calculate_lsm(
      landscape = .x,
      what = metrics
    )
  ) |> 
  purrr::list_rbind(
    names_to = "id"
  )

# create a long ep landscape data frame  -------------------------------------------
# create a list with with all landscape metrics
landscape_metrics_list <- list(
  "100" = landscape_metrics100,
  "200" = landscape_metrics200,
  "400" = landscape_metrics400,
  "800" = landscape_metrics800,
  "1000" = landscape_metrics1000,
  "2000" = landscape_metrics2000,
  "5000" = landscape_metrics5000
)

# bind lists by raw
landscape_metrics <- landscape_metrics_list |> 
  purrr::list_rbind(
    names_to = "buffer"
  ) |> 
  dplyr::filter(class == 1) |> 
  dplyr::mutate(
    id = as.double(id)
  ) |> 
  dplyr::right_join(
    point_ep,
    dplyr::join_by(
      id
    )
  ) |>
  dplyr::select(1, 5:14)

# create ep events and landscape metrics wide data frame -------------------------------------------
# join ep events and landscape metrics
ep_landscape_metrics <- landscape_metrics |> 
  tidyr::pivot_wider(
    names_from = c(metric, buffer),
    values_from = value,
    values_fill = 0,
    names_sep = ""
  ) |> 
  dplyr::select(1:29)

# data transformation - standardize (z-transformation) --------------------

ep_landscape_metrics_transformed <- ep_landscape_metrics |> 
  dplyr::mutate(
    status = dplyr::if_else(
      status == "Negative",
      true = 0,
      false = 1
    ),
    ed100_ztransformed = vegan::decostand(
      x = ed100,
      method = "standardize"
    ),
    ed200_ztransformed = vegan::decostand(
      x = ed200,
      method = "standardize"
    ),
    ed400_ztransformed = vegan::decostand(
      x = ed400,
      method = "standardize"
    ),
    ed800_ztransformed = vegan::decostand(
      x = ed800,
      method = "standardize"
    ),
    ed1000_ztransformed = vegan::decostand(
      x = ed1000,
      method = "standardize"
    ),
    ed2000_ztransformed = vegan::decostand(
      x = ed2000,
      method = "standardize"
    ),
    ed5000_ztransformed = vegan::decostand(
      x = ed5000,
      method = "standardize"
    ),
    np100_ztransformed = vegan::decostand(
      x = np100,
      method = "standardize"
    ),
    np200_ztransformed = vegan::decostand(
      x = np200,
      method = "standardize"
    ),
    np400_ztransformed = vegan::decostand(
      x = np400,
      method = "standardize"
    ),
    np800_ztransformed = vegan::decostand(
      x = np800,
      method = "standardize"
    ),
    np1000_ztransformed = vegan::decostand(
      x = np1000,
      method = "standardize"
    ),
    np2000_ztransformed = vegan::decostand(
      x = np2000,
      method = "standardize"
    ),
    np5000_ztransformed = vegan::decostand(
      x = np5000,
      method = "standardize"
    ),
    pland100_ztransformed = vegan::decostand(
      x = pland100,
      method = "standardize"
    ),
    pland200_ztransformed = vegan::decostand(
      x = pland200,
      method = "standardize"
    ),
    pland400_ztransformed = vegan::decostand(
      x = pland400,
      method = "standardize"
    ),
    pland800_ztransformed = vegan::decostand(
      x = pland800,
      method = "standardize"
    ),
    pland1000_ztransformed = vegan::decostand(
      x = pland1000,
      method = "standardize"
    ),
    pland2000_ztransformed = vegan::decostand(
      x = pland2000,
      method = "standardize"
    ),
    pland5000_ztransformed = vegan::decostand(
      x = pland5000,
      method = "standardize"
    )
  )

# write data for analysis on disk as xlsx file
# writexl::write_xlsx(
#   x = ep_landscape_metrics_transformed,
#   path = here::here("data/ep_landscape_metrics_transformed.xlsx")
# )

# write data for analysis on disk as Rdata file
# save(
#   list = "ep_landscape_metrics_transformed",
#   file = "ep_landscape_metrics_transformed.RData"
# )

# rm(list = ls())