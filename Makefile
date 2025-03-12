# author: Jordan Bourak & Tiffany Timbers
# date: 2021-11-22

all: results/horse_pop_plot_largest_sd.png \
	results/horse_pops_plot.png \
	results/horses_spread.csv \
	reports/qmd_example.html \
	reports/qmd_example.pdf \
	docs/index.html



# generate figures and objects for report
results/horse_pop_plot_largest_sd.png results/horse_pops_plot.png results/horses_spread.csv: source/generate_figures.R
	Rscript source/generate_figures.R --input_dir="data/00030067-eng.csv" \
		--out_dir="results"

# render quarto report in HTML and PDF
reports/qmd_example.html: results reports/qmd_example.qmd
	quarto render reports/qmd_example.qmd --to html

reports/qmd_example.pdf: results reports/qmd_example.qmd
	quarto render reports/qmd_example.qmd --to pdf


# Copy HTML report to GitHub Pages directory (/docs)
docs/index.html: reports/qmd_example.html
	mkdir -p docs  # Ensure docs/ exists
	cp reports/qmd_example.html docs/index.html

# clean
clean:
	rm -rf results
	rm -rf reports/qmd_example.html \
		reports/qmd_example.pdf \
		reports/qmd_example_files
	rm -rf docs/index.html  
