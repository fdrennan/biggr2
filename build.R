# Title     : build.R
# Objective : A Package Management Script
# Created by: fdrennan
# Created on: 10/27/20

cat(readr::read_file('build.R'))

library(devtools)
library(conflicted)
library(cli)
library(fs)
library(stringr)
library(glue)

args <- commandArgs(trailingOnly = TRUE)
if (length(args) == 0) {
  args <- 'all'
}

working_directory <- dir_ls(all = TRUE)

if ("all" %in% args) {
  base_args <- c("clean", "style", "document", "build", "check")
  if ("show" %in% args) {
    args <- c(base_args, "show")
  } else {
    args <- base_args
  }
}

if ("clean" %in% args) {
  system("rm -rf *.rda")
  system("rm -rf *.zip")
  system("rm -rf *.pdf")
  cli_alert_success("Deleted Files from Working Directory")
}

if ("style" %in% args) {
  styler::style_dir("R")
  cli_alert_success("Styling Completed")
}

if ("document" %in% args) {
  cli_alert_info("Creating Documentation")
  tryCatch(file_delete("NAMESPACE"), error = function(err) {
    cli::cli_alert('NAMESPACE did not exist...')
  })
  tryCatch(dir_delete("man"), error = function(err) {
    cli::cli_alert('Folder `man` did not exist. Creating...')
  })
  document()
  build_manual(path = "project_files")
  cli_alert_success("Documentation and Manual has been built.")

  if ("show" %in% args) {
    system("xdg-open project_files/*.pdf")
  }
  dir_ls(all = TRUE)
}

if ("build" %in% args) {
  file_remove <- str_detect(working_directory, "Rd2")
  dir_delete(working_directory[file_remove])
  devtools::build()
  devtools::install()
}

if ("check" %in% args) {
  devtools::check(build_args = "--as-cran")
  print(covr::package_coverage())
  print(covr::report())
}

if ("report" %in% args) {
  print(covr::package_coverage())
  print(covr::report())
}

if ("restore" %in% args) {
  print(renv::restore())
}

if ("snapshot" %in% args) {
  renv::settings$snapshot.type("all")
  renv::snapshot()
}
