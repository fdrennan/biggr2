.PHONY: all style document generate check r_env clean

all: style document build

style:
	@echo 'Styling R Directory'
	R	-e	"styler::style_dir('R')"

document:
	@echo "Documenting Package"
	rm -rf man | echo 'man does not exist'
	rm NAMESPACE | echo 'NAMESPACE does not exist'
	R	-e	"devtools::document()"
	R	-e	"devtools::build_manual(path='project_files')"

build:
	@echo "Building Package..."
	R	-e	"devtools::build()"
	R	-e	"devtools::install()"

check:
	@echo "Checking Packages"
	R	-e	"devtools::check()"
	R	-e	"covr::package_coverage()"
	R	-e	"covr::report()"

r_env:
	@echo "Setting Up Environment..."
	pip install --upgrade pip
	@rm -rf renv | echo 'deleting renv if exists'
	@rm -rf .Rprofile | echo 'deleting .Rprofile if exists'
	R	-e	"install.packages('renv')"
	R	-e	"renv::consent(provided=TRUE)"
	R	-e	"renv::init()"
	R	-e	"renv::restore()"
	R	-e	"renv::use_python(type='virtualenv')"
	R	-e	"reticulate::virtualenv_install(packages = 'boto3')"
	R	-e	"reticulate::import('boto3')"

clean:
	@echo "Removing unnecessary files"
	rm *.zip | echo "No ZIP Files"
	rm *.csv | echo "No CSV Files"
	rm *.xlsx | echo "No XLSX Files"
	rm *.txt | echo "No TXT files"
	rm *.pdf | echo "No PDF files"
