# author: Shawn Li
# date: 2024-03-08
# This script creates visualization for data,
# performs plots for further analysis
#
# Usage: Rscript data_visualizing.R <input_data> <all_plot> <table_mean>
#                                   <plot_non_ind> <plot_first_na>
#                                   <plot_inuit> <compair_plot>
#
# Input: the entire clean dataset
# Output: 1 plot of overall variables (line plot),
#         3 plots showing difference between communities (line plot),
#         1 plot of relationship between variables (ggpair),
#         1 table of mean value of variables (csv)
#
# Command: Rscript data_visualizing.R CWB_2021.csv all_plot.jpg table_mean.csv plot_non_ind.jpg plot_first_na.jpg plot_inuit.jpg compair_plot.jpg


library(readr)
library(docopt)
library(ggplot2)
library(dplyr)
library(GGally)

doc <- paste(
  "Usage:",
  "  data_visualizing.R <input_data> <all_plot> <table_mean>",
  "                     <plot_non_ind> <plot_first_na>",
  "                     <plot_inuit> <compair_plot>",
  collapse = "\n"
)


opts <- docopt(doc)


main <- function(input_data, all_plot, table_mean, plot_non_ind,
                 plot_first_na, plot_inuit, compair_plot) {

  data <- read_csv(input_data)

  # count different income levels
  count_income <- data |>
    group_by(Income_2021) |> # nolint
    summarize(count = n())

  # count different education levels
  count_edu <- data |>
    group_by(Education_2021) |> # nolint
    summarize(count = n())


  # count different labour force levels
  count_labour <- data |>
    group_by(Labour_Force_Activity_2021) |> # nolint
    summarize(count = n())


  # count different house levels
  count_house <- data |>
    group_by(Housing_2021) |> # nolint
    summarize(count = n())

  count_cwb <- data |>
    group_by(CWB_2021) |> # nolint
    summarize(count = n())

  count_income$variable <- "Income"
  count_edu$variable <- "Education"
  count_labour$variable <- "Labour Force"
  count_house$variable <- "Housing"
  count_cwb$variable <- "CWB Index"

  # Combine all datasets into one dataframe for plotting
  # Note that we need to rename the variables
  count_income <- count_income |> rename(Index = Income_2021) # nolint
  count_edu <- count_edu |> rename(Index = Education_2021) # nolint
  count_labour <- count_labour |> rename(Index = Labour_Force_Activity_2021) # nolint
  count_house <- count_house |> rename(Index = Housing_2021) # nolint
  count_cwb <- count_cwb |> rename(Index = CWB_2021) # nolint

  # Combine the data
  all_data <- bind_rows(count_income, count_edu,
                        count_labour, count_house, count_cwb)

  # Plot with a single ggplot call, which will create a legend automatically
  all_plot <- ggplot(all_data, aes(x = Index, y = count, color = variable)) + # nolint
    geom_line() +  # The line color will be set by the 'variable' column
    xlab("Index") +
    ylab("Counts") +
    ggtitle("Index of Different Variables") +
    scale_color_manual(values = c("Income" = "blue", "Education" = "red",
                                  "Labour Force" = "yellow",
                                  "Housing" = "green",
                                  "CWB Index" = "black")) +
    theme_minimal()

  # count the average value of variables
  # "Table 1: Mean values across Income, Education,
  # Housing, Labour Force and CWB Index"
  table_mean <- data |>
    summarize(across(Income_2021:CWB_2021, mean)) # nolint


  # split the database with different community type
  non_indigenous <- data[data$Community_Type_2021
                         == "Non-Indigenous Community", ]
  first_nations <- data[data$Community_Type_2021
                        == "First Nations Community", ]

  inuit <- data[data$Community_Type_2021
                == "Inuit Community", ]

  # count the average value of variables
  non_indigenous_inc <- non_indigenous |>
    group_by(Income_2021) |> # nolint
    summarize(count = n())

  non_indigenous_edu <- non_indigenous |>
    group_by(Education_2021) |> # nolint
    summarize(count = n())

  # count different labour force levels
  non_indigenous_labour <- non_indigenous |>
    group_by(Labour_Force_Activity_2021) |> # nolint
    summarize(count = n())

  # count different house levels
  non_indigenous_house <- non_indigenous |>
    group_by(Housing_2021) |> # nolint
    summarize(count = n())

  non_indigenous_inc$variable <- "Income"
  non_indigenous_edu$variable <- "Education"
  non_indigenous_labour$variable <- "Labour Force"
  non_indigenous_house$variable <- "Housing"

  # Combine all datasets into one dataframe for plotting
  # Note that we need to rename variable names
  non_indigenous_inc <- non_indigenous_inc |> rename(Index = Income_2021) # nolint
  non_indigenous_edu <- non_indigenous_edu |> rename(Index = Education_2021) # nolint # nolint
  non_indigenous_labour <- non_indigenous_labour |>
    rename(Index = Labour_Force_Activity_2021) # nolint
  non_indigenous_house <- non_indigenous_house |> rename(Index = Housing_2021) # nolint

  # Combine the data
  all_data_1 <- bind_rows(non_indigenous_inc, non_indigenous_edu,
                          non_indigenous_labour, non_indigenous_house)

  # Plot with a single ggplot call, which will create a legend automatically
  plot_non_ind <- ggplot(all_data_1, aes(x = Index, # nolint
                                         y = count, color = variable)) + # nolint
    geom_line() +  # The line color will be set by the 'variable' column
    xlab("Index") +
    ylab("Counts") +
    ggtitle("Index of Different Variables of Non Indigenous Community") +
    scale_color_manual(values = c("Income" = "blue", "Education" = "red",
                                  "Labour Force" = "yellow",
                                  "Housing" = "green")) +
    theme_minimal()


  #count the average value of variables
  first_nations_inc <- first_nations |>
    group_by(Income_2021) |> # nolint
    summarize(count = n())

  first_nations_edu <- first_nations |>
    group_by(Education_2021) |> # nolint
    summarize(count = n())

  # count different labour force levels
  first_nations_labour <- first_nations |>
    group_by(Labour_Force_Activity_2021) |> # nolint
    summarize(count = n())

  # count different house levels
  first_nations_house <- first_nations |>
    group_by(Housing_2021) |> # nolint
    summarize(count = n())

  first_nations_inc$variable <- "Income"
  first_nations_edu$variable <- "Education"
  first_nations_labour$variable <- "Labour Force"
  first_nations_house$variable <- "Housing"

  first_nations_inc <- first_nations_inc |> rename(Index = Income_2021) # nolint
  first_nations_edu <- first_nations_edu |> rename(Index = Education_2021) # nolint
  first_nations_labour <- first_nations_labour |>
    rename(Index = Labour_Force_Activity_2021) # nolint
  first_nations_house <- first_nations_house |> rename(Index = Housing_2021) # nolint

  all_data_2 <- bind_rows(first_nations_inc, first_nations_edu,
                          first_nations_labour, first_nations_house)

  # Plot with a single ggplot call, which will create a legend automatically
  plot_first_na <- ggplot(all_data_2, aes(x = Index, # nolint
                                          y = count, color = variable)) + # nolint
    geom_line() +  # The line color will be set by the 'variable' column
    xlab("Index") +
    ylab("Counts") +
    ggtitle("Index of Different Variables of First Nations Community") +
    scale_color_manual(values = c("Income" = "blue", "Education" = "red",
                                  "Labour Force" = "yellow",
                                  "Housing" = "green")) +
    theme_minimal()


  #count the average value of variables
  inuit_inc <- inuit |>
    group_by(Income_2021) |> # nolint
    summarize(count = n())

  inuit_edu <- inuit |>
    group_by(Education_2021) |> # nolint
    summarize(count = n())

  # count different labour force levels
  inuit_labour <- inuit |>
    group_by(Labour_Force_Activity_2021) |> # nolint
    summarize(count = n())

  # count different house levels
  inuit_house <- inuit |>
    group_by(Housing_2021) |> # nolint
    summarize(count = n())


  inuit_inc$variable <- "Income"
  inuit_edu$variable <- "Education"
  inuit_labour$variable <- "Labour Force"
  inuit_house$variable <- "Housing"

  inuit_inc <- inuit_inc |> rename(Index = Income_2021) # nolint
  inuit_edu <- inuit_edu |> rename(Index = Education_2021) # nolint
  inuit_labour <- inuit_labour |> rename(Index = Labour_Force_Activity_2021) # nolint
  inuit_house <- inuit_house |> rename(Index = Housing_2021) # nolint

  all_data_3 <- bind_rows(inuit_inc, inuit_edu, inuit_labour, inuit_house)

  # Plot with a single ggplot call, which will create a legend automatically
  plot_inuit <- ggplot(all_data_3, aes(x = Index, # nolint
                                       y = count, color = variable)) + # nolint
    geom_line() +  # The line color will be set by the 'variable' column
    xlab("Index") +
    ylab("Counts") +
    ggtitle("Index of Different Variables of Inuit Community") +
    scale_color_manual(values = c("Income" = "blue", "Education" = "red",
                                  "Labour Force" = "yellow",
                                  "Housing" = "green")) +
    theme_minimal()


  # plot the relationship between all variables
  compared_data <- data |>
    select(Income_2021:Labour_Force_Activity_2021) # nolint

  # Use ggpair to draw plots of relationship between variables
  compair_plot <- compared_data |>
    ggpairs(mapping = aes(alpha = 0.4)) +
    labs(caption = "Figure 1: Relationship between Variables") +
    theme(text = element_text(size = 20))

  ggsave(filename = opts$all_plot, plot = all_plot, device = "jpg")
  ggsave(filename = opts$plot_non_ind, plot = plot_non_ind, device = "jpg")
  ggsave(filename = opts$plot_first_na, plot = plot_first_na, device = "jpg")
  ggsave(filename = opts$plot_inuit, plot = plot_inuit, device = "jpg")
  ggsave(filename = opts$compair_plot, plot = compair_plot,
         width = 14, height = 7, device = "jpg")
  write.csv(table_mean, opts$table_mean, row.names = FALSE)

}

# Call the main function with the input and output path argument
main(opts$input_data, opts$all_plot, opts$table_mean,
     opts$plot_non_ind, opts$plot_first_na, opts$plot_inuit,
     opts$compair_plot)
