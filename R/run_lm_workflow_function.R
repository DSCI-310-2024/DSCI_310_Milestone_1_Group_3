#' Run a Linear Regression Model & Output the Model Summary
#'
#' Creates a linear regression model workflow that predicts the  
#' community well-being scores for various Canadian communities,
#' and outputs a table of the model's summary.
#'
#' @param train_data A data frame or data frame extension (e.g. a tibble)
#' @param test_data A data frame or data frame extension (e.g. a tibble)
#'
#' @return A data frame or data frame extension (e.g. a tibble). 
#'   The table contains the summary outputs of the model.
#'
#' @export
#' 
#' @examples
#' run_lm_workflow(train_data, test_data)
run_lm_workflow <- function(train_data, test_data) {
  
  # Define linear regression specification
  lm_spec <- tidymodels::linear_reg() %>%
    tidymodels::set_engine("lm") %>%
    tidymodels::set_mode("regression")
  
  # Define recipe
  lm_recipe <- tidymodels::recipe(CWB_2021 ~ Income_2021 + Education_2021 +
                                    Housing_2021 + Labour_Force_Activity_2021,
                                  data = train_data)
  
  # Create workflow
  lm_fit <- tidymodels::workflow() %>%
    tidymodels::add_recipe(lm_recipe) %>%
    tidymodels::add_model(lm_spec) %>%
    tidymodels::fit(data = train_data)
  
  # Generate predictions and compute metrics for test data
  test_summary <- lm_fit %>%
    tidymodels::predict(new_data = test_data) %>%
    dplyr::bind_cols(test_data) %>%
    tidymodels::metrics(truth = CWB_2021, estimate = .pred)
  
  # Return the test summary
  return(test_summary)
}