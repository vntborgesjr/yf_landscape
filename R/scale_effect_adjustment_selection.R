scale_effect_adjustment_selection <- function(
    data,
    models,
    FUN,
    family,
    rank = NULL,
    beta = "none",
    dispformula = ~ 0,
    REML = FALSE
  ) {
  
  # create the object to receive the models
  models_results <- list()
  
  # fit the set of models
  models_results <- models |> 
    purrr::map(
      \(.x) glmmTMB::glmmTMB(
        formula = .x,
        data = data,
        family = family,
        dispformula = dispformula, 
        REML = REML
      )
    )
    
  # run model selection
  m_selection <- MuMIn::model.sel(models_results,
                           beta = beta) 
  
  # extradct model names for the first column of model selection table
  
  model_names <- list() # create the object to store the name of models
  
  for (i in seq_along(models)) {
    model_names[[i]] <- formula(models[[i]])
  } # extract and store model names
  
  
  # generate model selection table
  
  m_sel_tab <- tibble::tibble(Modelo = as.character(model_names[as.double(row.names(m_selection))]),
                      gl = m_selection$df,
                      logLik = round(m_selection$logLik, 2),
                      AICc = round(m_selection$AICc, 2),
                      deltaAICc = round(m_selection$delta, 2),
                      wi = round(m_selection$weight, 3)) 
  
  return(list(models = models_results,
              model_selection = m_selection, 
              model_selection_table = m_sel_tab))
}