# Makefile
# authors: Sri Chaitanya, Selena Shaw, Shawn Li, Lesley Mai, Mar 2024
# date: 2024-03-15

# This driver script produces an html and pdf report of our analysis on "Predicting Canada's # Community Well-Being Index Scores". This script takes no arguments.

# example usage:
# make all
# make clean

all: Results/all_plot.jpg \
	Results/plot_non_ind.jpg \
	Results/plot_first_na.jpg \
	Results/plot_inuit.jpg \
	Results/compair_plot.jpg \
	Results/table_mean.csv \
	Results/train_data.csv \
	Results/test_data.csv \
	Results/model.csv \
	Results/summary.csv \
	reports/quarto_report.html \
	reports/quarto_report.pdf

# generate figures and objects for report
Results/all_plot.jpg Results/plot_non_ind.jpg Results/plot_first_na.jpg Results/plot_inuit.jpg Results/compair_plot.jpg Results/table_mean.csv: R/data_visualizing.R
	Rscript R/data_visualizing.R --input_dir="data/CWB_2021.csv" \
		--out_dir="Results"

Results/train_data.csv Results/test_data.csv Results/model.csv Results/summary.csv: R/data_analysis.R
	Rscript R/data_analysis.R --input_dir="data/CWB_2021.csv" \
		--out_dir="Results"

# render quarto report in HTML and PDF
reports/quarto_report.html: Results ../report.qmd
	quarto render ../report.qmd --to html

reports/quarto_report.pdf: Results ../report.qmd
	quarto render ../report.qmd --to pdf

# clean
clean:
	rm -rf Results
	rm -rf reports/quarto_report.html \
		reports/quarto_report.pdf \
		reports/quarto_report_files
