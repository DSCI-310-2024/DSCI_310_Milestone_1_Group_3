# Makefile
# authors: Sri Chaitanya, Selena Shaw, Shawn Li, Lesley Mai
# date: 2024-03-15

# This driver script produces an html and pdf report of our analysis on "Predicting Canada's # Community Well-Being Index Scores". This script takes no arguments.

# example usage:
# make all
# make clean

all: results/all_plot.jpg \
	results/plot_non_ind.jpg \
	results/plot_first_na.jpg \
	results/plot_inuit.jpg \
	results/compair_plot.jpg \
	results/table_mean.csv \
	results/train_data.csv \
	results/test_data.csv \
	results/model.csv \
	results/summary.csv \
	reports/quarto_report.html \
	reports/quarto_report.pdf

# generate figures and objects for report
results/all_plot.jpg results/plot_non_ind.jpg results/plot_first_na.jpg results/plot_inuit.jpg results/compair_plot.jpg results/table_mean.csv: R/data_visualizing.R
	Rscript R/data_visualizing.R --input_dir="data/CWB_2021.csv" \
		--out_dir="results"

results/train_data.csv results/test_data.csv results/model.csv results/summary.csv: R/data_analysis.R
	Rscript R/data_analysis.R --input_dir="data/CWB_2021.csv" \
		--out_dir="results"

# render quarto report in HTML and PDF
reports/quarto_report.html: ./report.qmd $(wildcard results/*)
	quarto render ./report.qmd --to html

reports/quarto_report.pdf: ./report.qmd $(wildcard results/*)
	quarto render ./report.qmd --to pdf

# clean
clean:
	rm -rf results
	rm -rf reports/quarto_report.html \
		reports/quarto_report.pdf \
		reports/quarto_report_files