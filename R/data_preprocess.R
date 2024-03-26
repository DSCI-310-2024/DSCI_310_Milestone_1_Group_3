# author: Shawn Li
# date: 2024-03-08
# This script reads data, performs cleaning/pre-processing
#
# Usage: Rscript data_preprocess.R --input_dir=<input_path> --out_dir=<out_path>
#
# Input: the entire raw data from script 1
# Output: a clean data

library(tidyverse)
library(readr)
library(docopt)

doc <- "
Usage:
  data_preprocess.R --input_dir=<input_dir> --out_dir=<out_dir>

Options:
--input_dir=<input_dir> 
--out_dir=<out_dir>  
"

opts <- docopt(doc)

main <- function(input_dir, out_dir) {

  if (!dir.exists(out_dir)) {
    dir.create(out_dir)
  }
  
  # Read the data from input_path
  data <- read_csv(input_dir)

  # Rename columns
  new_col_names <- c("CSD_Code_2021", "CSD_Name_2021", "Census_Population_2021",
                     "Income_2021", "Education_2021", "Housing_2021",
                     "Labour_Force_Activity_2021", "CWB_2021",
                     "Community_Type_2021")
  names(data) <- new_col_names

  # Delete rows without values
  clean_data <- data |> # nolint
    filter(Census_Population_2021 != "", Income_2021 != "", # nolint
           Education_2021 != "", Housing_2021 != "",  # nolint
           Labour_Force_Activity_2021 != "", CWB_2021 != "") # nolint

  # Write the cleaned data to out_path
  write_csv(clean_data, file.path(out_dir, "clean_data.csv"))
}

# Call the main function with command line arguments
main(opts[["--input_dir"]], opts[["--out_dir"]])