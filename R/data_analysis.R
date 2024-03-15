# author: Shawn Li
# date: 2024-03-08
# This script performs final analysis
# which train the linear model as well as
# assess the accuracy of prediction.
# and saves it to a specified output path.
#
# Usage: Rscript data_analysis.R <train_data> <test_data> <model> <summary>
# Input: The training data and testing data
# Output: the predicting model and performance (two tables)
#
# Command: Rscript data_analysis.R train_data.csv test_data.csv model.csv summary.csv


library(readr)
library(tidyverse)
library(docopt)
library(parsnip)
library(workflows)
library(recipes)
library(dplyr)
library(yardstick)
library(broom)

# Parse command line arguments
doc <- "
Usage:
  data_analysis.R <train_data> <test_data> <model> <summary>
"
opts <- docopt(doc)

main <- function(train_data, test_data, model, summary) {

  train_data <- read_csv(train_data)
  test_data <- read_csv(test_data)

  lm_spec <- linear_reg() |>
    set_engine("lm") |>
    set_mode("regression")

  lm_recipe <- recipe(CWB_2021 ~ Income_2021 +  Education_2021 +
                        Housing_2021 + Labour_Force_Activity_2021,
                      data = train_data)

  lm_fit <- workflow() |>
    add_recipe(lm_recipe) |>
    add_model(lm_spec) |>
    fit(data = train_data)

  summary <- lm_fit |>
    predict(test_data) |>
    bind_cols(test_data) |>
    metrics(truth = CWB_2021, estimate = .pred) # nolint

  model <- tidy(lm_fit)

  write.csv(model, opts$model, row.names = FALSE)
  write.csv(summary, opts$summary, row.names = FALSE)

}

# Call the main function with the output path argument
main(opts$train_data, opts$test_data, opts$model, opts$summary)
