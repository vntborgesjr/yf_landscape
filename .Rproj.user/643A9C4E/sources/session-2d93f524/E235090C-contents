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

# buffer of 40m -------------------------------------------
all_cover_metric40 <- purrr::map2(
  cover_reclass3,
  ep_cities_data,
  \(.x, .y) 
  # plot_id <- names(.y),
  sample_lsm(
    landscape = .x,
    y = .y,
    shape = "circle",
    size = 40, 
    # plot_id = .y$plot_id$ID,
    level = "class",
    metric = c(
      "pland",
      "np",
      "ed"
    ),
    name = c(
      "percentage of landscape",
      "number of patches",
      "edge density"
    ),
    type = c(
      "area and edge metric",
      "aggregation metric",
      "area and edge metric"
    ), 
    what = c(
      "lsm_c_pland",
      "lsm_c_np",
      "lsm_c_ed"
    ),
    classes_max = 2, 
    verbose = FALSE
  )
)

# Buffer of 100m
all_cover_metric100 <- purrr::map2(
  cover_reclass3,
  ep_cities_data,
  \(.x, .y) 
  # plot_id <- names(.y),
  sample_lsm(
    landscape = .x,
    y = .y,
    shape = "circle",
    size = 100, 
    # plot_id = .y$plot_id$ID,
    level = "class",
    metric = c(
      "pland",
      "np",
      "ed"
    ),
    name = c(
      "percentage of landscape",
      "number of patches",
      "edge density"
    ),
    type = c(
      "area and edge metric",
      "aggregation metric",
      "area and edge metric"
    ), 
    what = c(
      "lsm_c_pland",
      "lsm_c_np",
      "lsm_c_ed"
    ),
    classes_max = 2, 
    verbose = FALSE
  )
)

# Buffer of 200m
all_cover_metric200 <- purrr::map2(
  cover_reclass3,
  ep_cities_data,
  \(.x, .y) 
  # plot_id <- names(.y),
  sample_lsm(
    landscape = .x,
    y = .y,
    shape = "circle",
    size = 200, 
    # plot_id = .y$plot_id$ID,
    level = "class",
    metric = c(
      "pland",
      "np",
      "ed"
    ),
    name = c(
      "percentage of landscape",
      "number of patches",
      "edge density"
    ),
    type = c(
      "area and edge metric",
      "aggregation metric",
      "area and edge metric"
    ), 
    what = c(
      "lsm_c_pland",
      "lsm_c_np",
      "lsm_c_ed"
    ),
    classes_max = 2, 
    verbose = FALSE
  )
)

# Buffer of 400m
all_cover_metric400 <- purrr::map2(
  cover_reclass3,
  ep_cities_data,
  \(.x, .y) 
  # plot_id <- names(.y),
  sample_lsm(
    landscape = .x,
    y = .y,
    shape = "circle",
    size = 400, 
    # plot_id = .y$plot_id$ID,
    level = "class",
    metric = c(
      "pland",
      "np",
      "ed"
    ),
    name = c(
      "percentage of landscape",
      "number of patches",
      "edge density"
    ),
    type = c(
      "area and edge metric",
      "aggregation metric",
      "area and edge metric"
    ), 
    what = c(
      "lsm_c_pland",
      "lsm_c_np",
      "lsm_c_ed"
    ),
    classes_max = 2, 
    verbose = FALSE
  )
)

# Buffer of 1000m
all_cover_metric1000 <- purrr::map2(
  cover_reclass3,
  ep_cities_data,
  \(.x, .y) 
  # plot_id <- names(.y),
  sample_lsm(
    landscape = .x,
    y = .y,
    shape = "circle",
    size = 1000, 
    # plot_id = .y$plot_id$ID,
    level = "class",
    metric = c(
      "pland",
      "np",
      "ed"
    ),
    name = c(
      "percentage of landscape",
      "number of patches",
      "edge density"
    ),
    type = c(
      "area and edge metric",
      "aggregation metric",
      "area and edge metric"
    ), 
    what = c(
      "lsm_c_pland",
      "lsm_c_np",
      "lsm_c_ed"
    ),
    classes_max = 2, 
    verbose = FALSE
  )
)

# Buffer of 2000m
all_cover_metric2000 <- purrr::map2(
  cover_reclass3,
  ep_cities_data,
  \(.x, .y) 
  # plot_id <- names(.y),
  sample_lsm(
    landscape = .x,
    y = .y,
    shape = "circle",
    size = 2000, 
    # plot_id = .y$plot_id$ID,
    level = "class",
    metric = c(
      "pland",
      "np",
      "ed"
    ),
    name = c(
      "percentage of landscape",
      "number of patches",
      "edge density"
    ),
    type = c(
      "area and edge metric",
      "aggregation metric",
      "area and edge metric"
    ), 
    what = c(
      "lsm_c_pland",
      "lsm_c_np",
      "lsm_c_ed"
    ),
    classes_max = 2, 
    verbose = FALSE
  )
)

# View(all_cover_metric$ATIBAIA)

# summarize data frames -------------------------------------------


