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
# Command: Rscript data_download.R raw_data.csv

library(readr)
library(tidyverse)
library(docopt)

# Parse command line arguments
doc <- "
Usage:
  data_download.R <raw_data>
"
opts <- docopt(doc)

main <- function(raw_data) {
  # Specify the URL for the data
  data_url <- paste0("https://data.sac-isc.gc.ca/",
                     "geomatics/directories/output/",
                     "DonneesOuvertes_OpenData/CWB/",
                     "CWB_2021.csv")

  # Download and read the data
  raw_data <- read_csv(data_url)

  write.csv(raw_data, "raw_data.csv", row.names = FALSE)
  print(raw_data)
}

# Call the main function with the output path argument
main(opts$raw_data)
