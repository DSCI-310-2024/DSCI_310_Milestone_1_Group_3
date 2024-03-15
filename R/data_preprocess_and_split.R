# author: Shawn Li
# date: 2024-03-08
# This script reads data, performs cleaning/pre-processing,
# splits the data into training and testing sets.
#
# Usage: Rscript data_preprocess_and_split.R
#  <input_path> <output_train_path> <output_test_path>
#
# Input: the entire clean data from script 1
# Output: a training dataset and a testing dataset (in csv file)
#
# Command: Rscript data_preprocess_and_split.R CWB_2021.csv train_data.csv test_data.csv


library(tidyverse)
library(readr)
library(docopt)
library(rsample) # for initial_split, training, and testing

# Parse command line arguments
doc <- "
Usage:
  data_preprocess_and_split.R <input_data> <train_data> <test_data>
"
opts <- docopt(doc)

main <- function(input_data, train_data, test_data) {
  # Read the data from input_path
  database <- read_csv(input_data)

  # Include your data cleaning/pre-processing steps here
  # Placeholder for actual data cleaning/preprocessing

  # Data splitting with a seed for reproducibility
  set.seed(1234)
  database_split <- initial_split(database, prop = 0.75)

  database_train <- training(database_split)
  database_test <- testing(database_split)

  # Save the processed training and testing data to specified output paths
  write.csv(database_train, train_data, row.names = FALSE)
  write.csv(database_test, test_data, row.names = FALSE)

  cat("Processed training data saved to", train_data, "\n")
  cat("Processed testing data saved to", test_data, "\n")
}

# Call the main function with command line arguments
main(opts$input_data, opts$train_data, opts$test_data)
