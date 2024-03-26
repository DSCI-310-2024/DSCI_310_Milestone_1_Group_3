# Makefile
# authors: Sri Chaitanya, Selena Shaw, Shawn Li, Lesley Mai
# date: 2024-03-15

# This driver script produces an html and pdf report of our analysis on "Predicting Canada's # Community Well-Being Index Scores". This script takes no arguments.

# example usage:
# make all
# make clean

all: results/clean_data.csv \
    results/all_plot.jpg \
	results/plot_non_ind.jpg \
	results/plot_first_na.jpg \
	results/plot_inuit.jpg \
	results/compair_plot.jpg \
	results/table_mean.csv \
	results/train_data.csv \
	results/test_data.csv \
	results/model.csv \
	results/summary.csv \
	reports/report.html \
	reports/report.pdf


# clean the raw data and rename the columns
results/clean_data.csv: R/data_preprocess.R
	Rscript R/data_preprocess.R --input_dir="data/raw_data.csv" \
		--out_dir="results"

# generate figures and objects for report
results/all_plot.jpg results/plot_non_ind.jpg results/plot_first_na.jpg results/plot_inuit.jpg results/compair_plot.jpg results/table_mean.csv: R/data_visualizing.R
	Rscript R/data_visualizing.R --input_dir="results/clean_data.csv" \
		--out_dir="results" 


# generate the model
results/train_data.csv results/test_data.csv results/model.csv results/summary.csv: R/data_analysis.R
	Rscript R/data_analysis.R --input_dir="results/clean_data.csv" \
		--out_dir="results" 

# render quarto report in HTML and PDF
reports/report.html: results reports/report.qmd
	quarto render reports/report.qmd --to html

reports/report.pdf: results reports/report.qmd
	quarto render reports/report.qmd --to pdf

# clean
clean:
	rm -rf results
	rm -rf reports/report.html \
		reports/report.pdf \
		reports/report_files \
		Rplots.pdf