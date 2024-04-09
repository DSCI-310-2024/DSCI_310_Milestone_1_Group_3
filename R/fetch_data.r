#' Reads data from a given URl string literal and outputs that data
#'
#' This function takes a URl to a csv file online, whether the csv file has an header
#' and the separation type as an input  
#' and returns that data.
#' 
#' @param data_url A URl String to the .csv file online
#' @param tfHeader Boolean TRUE or FALSE for if the csv file has a header row
#' @param sepType String for how the values in the csv file has been separated
#'
#' @return A data frame or data frame extension (e.g. a tibble).
#'
#' @export
#' 
#' @examples
#' data_url <- "https://data.sac-isc.gc.ca/geomatics/directories/output/DonneesOuvertes_OpenData/CWB/CWB_2021.csv"
#' fetch_data(data_url, TRUE, ",")
#' # Specify the URL for the data
fetch_data <- function(data_url, tfHeader, sepType) {
  if (!is.character(data_url)) {
    stop("Data URL must be a string", call. = FALSE)
  }
  if (!is.logical(tfHeader) || length(tfHeader) != 1) {
    stop("tfHeader must be a Boolean", call. = FALSE)
  }
  if (!is.character(sepType)) {
    stop("SepType must be a string", call. = FALSE)
  }
  
  raw_data <- tryCatch({
    utils::read.csv(data_url, header = tfHeader, sep = sepType)
  }, error = function(e) {
    stop("Failed to load data. Please check the URL and format.", call. = FALSE)
  })
  
  return(raw_data)
}
