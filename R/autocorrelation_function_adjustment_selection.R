autocorrelation_function_adjustment_selection <- function(
    data,
    models,
    family,
    beta = "none"
) {
  
  # create the object to receive the models
  models_results <- list()
  
  # fit the set of models with dispformula = ~ 1
  models_results <- models[-3] |> 
    purrr::map(
      \(.x) glmmTMB::glmmTMB(
        formula = .x,
        data = data,
        family = family,
        dispformula = ~ 1,
        REML = TRUE
      )
    )
  
  # fit the model with gaussian spatial structure
  model_gau <- models[3] |> 
    purrr::map(
      \(.x) glmmTMB::glmmTMB(
        formula = .x,
        data = data,
        family = family,
        dispformula = ~ 0,
        REML = TRUE
      )
    )
  
  # bind all model results in the same list
  models_results <- c(models_results, model_gau)
  
  # run model selection
  m_selection <- MuMIn::model.sel(models_results,
                                  beta = beta) 
  
  # extradct model names for the first column of model selection table
  
  model_names <- list() # create the object to store the name of models
  
  for (i in seq_along(models)) {
    model_names[[i]] <- formula(models[[i]])
  } # extract and store model names
  
  
  # generate model selection table
  
  m_sel_tab <- tibble::tibble(Modelo = row.names(m_selection),
                              gl = m_selection$df,
                              logLik = round(m_selection$logLik, 2),
                              AICc = round(m_selection$AICc, 2),
                              deltaAICc = round(m_selection$delta, 2),
                              wi = round(m_selection$weight, 3)) 
  
  return(list(models = models_results,
              model_selection = m_selection, 
              model_selection_table = m_sel_tab))
}