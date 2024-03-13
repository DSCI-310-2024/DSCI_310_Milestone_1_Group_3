# author: Shawn Li
# date: 2024-03-08
# This script downloads data online,
# Rename every column such that it's machine readable,
# as well as remove rows with missing data,
# and saves it to a specified output path.
#
# Usage: Rscript data_download.R <output_path>
# Input: Nothing
# Output: clean entire dataset
#
# Command: Rscript data_download.R CWB_2021.csv

library(readr)
library(tidyverse)
library(docopt)

# Parse command line arguments
doc <- "
Usage:
  data_download.R <output_data>
"
opts <- docopt(doc)

main <- function(output_data) {
  # Specify the URL for the data
  data_url <- paste0("https://data.sac-isc.gc.ca/",
                     "geomatics/directories/output/",
                     "DonneesOuvertes_OpenData/CWB/",
                     "CWB_2021.csv")

  # Download and read the data
  raw_data <- read_csv(data_url)

  # Rename columns
  new_col_names <- c("CSD_Code_2021", "CSD_Name_2021", "Census_Population_2021",
                     "Income_2021", "Education_2021", "Housing_2021",
                     "Labour_Force_Activity_2021", "CWB_2021",
                     "Community_Type_2021")
  names(raw_data) <- new_col_names

  # Delete rows without values
  database <- raw_data |>
    filter(Census_Population_2021 != "") |> # nolint
    filter(Income_2021 != "") |> # nolint
    filter(Education_2021 != "") |> # nolint
    filter(Housing_2021 != "") |> # nolint
    filter(Labour_Force_Activity_2021 != "") |> # nolint
    filter(CWB_2021 != "") # nolint

  # Save the processed data to the specified output path
  write.csv(database, output_data, row.names = FALSE)
  print(database)
}

# Call the main function with the output path argument
main(opts$output_data)
