#' Calculate Mean Values of Specified Columns and Export to CSV
#'
#' Calculate mean values for specified columns in a dataframe and exports
#' these mean values to a CSV file. It is specifically designed to process
#' columns related to socioeconomic indicators, from 'Income_2021' to 'CWB_2021'
#' The function is designed to assist in the preprocessing steps of a data 
#' analysis workflow.
#'
#' @param data A dataframe or a tibble containing the relevant columns.
#' @param out_dir A string specifying the directory path where the output CSV 
#' file will be saved.
#' @param file_name A string specifying the name of the output CSV file.
#'        Default is "table_mean.csv".
#'
#' @details The function operates on a range of columns, calculating the mean 
#'          for each column and exporting the results to a CSV file named 
#'          "table_mean.csv" by default. It's part of a larger analysis workflow
#'          process that aims to learn about the health 
#'          and happiness of communities.
#'
#' @return Writes a CSV file to the specified directory containing the mean 
#'         values for the specified range of columns. The function itself 
#'         invisibly returns NULL.
#'
#' @examples
#' df <- tibble(
#'   Income_2021 = c(50000, 60000, 70000),
#'   Education_2021 = c(12, 14, 16),
#'   Housing_2021 = c(200, 250, 300),
#'   Labour_Force_Activity_2021 = c(1, 2, 1),
#'   CWB_2021 = c(70, 75, 80)
#' )
#' calculate_and_export_means(df, getwd(), "community_means.csv")
#'
#' @export
calculate_and_export_means <- function(data, out_dir, file_name = "table_mean.csv") {
  # Load necessary libraries
  if (!requireNamespace("dplyr", quietly = TRUE)) stop("dplyr is required but not installed.")
  if (!requireNamespace("readr", quietly = TRUE)) stop("readr is required but not installed.")
  
  if (ncol(data) == 0 || nrow(data) == 0) {
    empty_table <- tibble(
      Income_2021 = numeric(),
      Education_2021 = numeric(),
      Housing_2021 = numeric(),
      Labour_Force_Activity_2021 = numeric(),
      CWB_2021 = numeric()
    )
    output_path <- file.path(out_dir, file_name)
    readr::write_csv(empty_table, output_path)
    message("Empty dataframe or dataframe with no columns. Output CSV file created with column headers only.")
    return(invisible(NULL))
  }
  
  # Calculate the mean values for the specified range of columns
  table_mean <- data |>
    dplyr::summarize(across(Income_2021:CWB_2021, ~mean(.x, na.rm = TRUE)))
  
  # Define the output file path
  output_path <- file.path(out_dir, file_name)
  
  # Write to CSV
  readr::write_csv(table_mean, output_path)
  
  message("Mean values have been successfully exported to: ", output_path)
  
  # The function primarily has a side effect (writing a file) and returns NULL
  invisible(NULL)
}