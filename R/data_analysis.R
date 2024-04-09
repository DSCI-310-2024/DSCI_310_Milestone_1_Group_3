# author: Shawn Li
# date: 2024-03-08
# This script performs final analysis
# which train the linear model as well as
# assess the accuracy of prediction.
# and saves it to a specified output path.
# Input: The clean data
# Output: the predicting model and performance (two tables)


library(readr)
library(tidyverse)
library(docopt)
library(parsnip)
library(workflows)
library(recipes)
library(dplyr)
library(yardstick)
library(broom)
library(rsample)
library(G3package)


# Parse command line arguments
doc <- "
Usage:
  data_analysis.R --input_dir=<input_dir> --out_dir=<out_dir>

Options:
  --input_dir=<input_dir>  
  --out_dir=<out_dir>
"


opts <- docopt(doc)

main <- function(input_dir, out_dir) {

  input_data <- read_csv(input_dir)
  database_split <- initial_split(input_data, prop = 0.75)

  train_data <- training(database_split)
  test_data <- testing(database_split)

  # Save the processed training and testing data to specified output paths
  write_csv(train_data, file.path(out_dir, "train_data.csv"))
  write_csv(test_data, file.path(out_dir, "test_data.csv"))

  results <- run_lm_workflow(train_data, test_data)
  summary <- results$test_summary
  model  <- tidy(results$lm_fit)

  write_csv(model, file.path(out_dir, "model.csv"))
  write_csv(summary, file.path(out_dir, "summary.csv"))

}

# Call the main function with the output path argument
main(opts[["--input_dir"]], opts[["--out_dir"]])