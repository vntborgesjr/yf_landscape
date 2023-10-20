##%#########################################%##
#                                             #
####           Data analysis               ####
####         Landscape metrics             ####
####        Vitor Borges-Júnior            ####
####       Created on 11 Oct 2023          ####
#                                             #
##%#########################################%##

# Load data -------------------------------------------
source(here::here("data/landscape-spatial-data.R"))
# cities_cover <- raster::raster(here::here("data/cities-cover.tif"))

# Load packages -------------------------------------------
source(here::here("R/dependencies.R"))

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

# buffer of 40m -------------------------------------------
landscape_metrics40 <- buffer40 |> 
  purrr::map(
    \(.x) calculate_lsm(
      landscape = .x,
      what = metrics
    )
  ) |> 
  purrr::list_rbind(
    names_to = "id"
  )

# Buffer of 100m
landscape_metrics100 <- buffer100 |> 
  purrr::map(
    \(.x) calculate_lsm(
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
    \(.x) calculate_lsm(
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
    \(.x) calculate_lsm(
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
    \(.x) calculate_lsm(
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
    \(.x) calculate_lsm(
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
    \(.x) calculate_lsm(
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
  "40" = landscape_metrics40,
  "100" = landscape_metrics100,
  "200" = landscape_metrics200,
  "400" = landscape_metrics400,
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
  dplyr::right_join(
    point_ep,
    dplyr::join_by(
      id
    )
  ) |> 
  dplyr::select(1, 5:14)

# create ep events and landscape metrics wide data frame -------------------------------------------
# join ep events and landscape metrics
ep_landscape_metrics <- landscape_metrics_list |> 
  purrr::list_rbind(
    names_to = "buffer"
  ) |> 
  dplyr::filter(class == 1) |> 
  dplyr::right_join(
    point_ep,
    dplyr::join_by(
      id
    )
  ) |> 
  tidyr::pivot_wider(
    names_from = c(metric, buffer),
    values_from = value,
    names_sep = ""
  ) |> 
  dplyr::select(4:32)

