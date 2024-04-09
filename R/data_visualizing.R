# author: Shawn Li
# date: 2024-03-08
# This script creates visualization for data,
# performs plots for further analysis
# Input: the entire clean dataset
# Output: 1 plot of overall variables (line plot),
#         3 plots showing difference between communities (line plot),
#         1 plot of relationship between variables (ggpair),
#         1 table of mean value of variables (csv)

library(readr)
library(docopt)
library(ggplot2)
library(dplyr)
library(GGally)
library(devtools)
library(G3package)
doc <- "
Usage:
data_visualizing.R --input_dir=<input_dir> --out_dir=<out_dir>

Options:
  --input_dir=<input_dir>
  --out_dir=<out_dir>
"


opts <- docopt(doc)


main <- function(input_dir, out_dir) {

  data <- read_csv(input_dir)
  cols <- c("Income_2021", "Education_2021",
            "Labour_Force_Activity_2021",
            "Housing_2021",
            "CWB_2021")

  all_plot <- lineplot(data, cols)
  ggsave("all_plot.jpg", all_plot, device = "jpg", path = out_dir,
         width = 12, height = 8)

  # count the average value of variables
  # "Table 1: Mean values across Income, Education,
  # Housing, Labour Force and CWB Index"


  calculate_and_export_means(data, out_dir, "table_mean.csv")

  # split the database with different community type
  non_indigenous <- data[data$Community_Type_2021
                         == "Non-Indigenous Community", ]
  first_nations <- data[data$Community_Type_2021
                        == "First Nations Community", ]

  inuit <- data[data$Community_Type_2021
                == "Inuit Community", ]


  plot_non_ind <- lineplot(non_indigenous, cols)
  ggsave("plot_non_ind.jpg", plot_non_ind, device = "jpg", path = out_dir,
         width = 12, height = 8)


  plot_first_na <- lineplot(first_nations, cols)
  ggsave("plot_first_na.jpg", plot_first_na, device = "jpg", path = out_dir,
         width = 12, height = 8)


  plot_inuit <- lineplot(inuit, cols)
  ggsave("plot_inuit.jpg", plot_inuit, device = "jpg", path = out_dir,
         width = 12, height = 8)


  # plot the relationship between all variables
  compared_data <- data |>
    select(Income_2021:Labour_Force_Activity_2021) # nolint

  # Use ggpair to draw plots of relationship between variables
  compair_plot <- compared_data |>
    ggpairs(mapping = aes(alpha = 0.4)) +
    labs(caption = "Figure 1: Relationship between Variables") +
    theme(text = element_text(size = 20))

  print(compair_plot)
  dev.off()

  ggsave("compair_plot.jpg", device = "jpg", path = out_dir,
         width = 12, height = 8)

}

# Call the main function with the input and output path argument
main(opts[["--input_dir"]], opts[["--out_dir"]])