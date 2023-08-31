rm(list = ls())

library(devtools)

package_dir <- '/data/BarcodeFlow'

usethis::create_package(package_dir)
usethis::use_mit_license('Alexander G. McFarland')
usethis::use_build_ignore(c('data','docs','raw-data'))

# Create raw-data to store all project creation instructions including this script
dir.create(file.path(package_dir, 'raw-data'))

# Create test folder with usethis, create testdata dir, and then remove test-whoop.R create initially
usethis::use_test('whoop')
dir.create(file.path(package_dir, 'tests', 'testthat', 'testdata'))
file.remove(file.path(package_dir, 'tests', 'testthat', 'test-whoop.R'))

# Package functions

## FormatData
usethis::use_r('FormatData')
usethis::use_test('FormatData')
devtools::test(filter = 'FormatData')

## CompleteCombinations
usethis::use_r('CompleteCombinations')
usethis::use_test('CompleteCombinations')
devtools::test(filter = 'CompleteCombinations')

## BasicAlluvialPlot
usethis::use_r('BasicAlluvialPlot')
usethis::use_test('BasicAlluvialPlot')
devtools::test(filter = 'BasicAlluvialPlot')


# Run all tests
devtools::test()

devtools::document() # updates NAMESPACE

# Create doc plot object for github
devtools::load_all(package_dir)
df_barcodes <- read.csv(file.path(package_dir, 'tests', 'testthat', 'testdata', 'barcode_table.csv'))

df_barcodes <- BarcodeFlow::FormatData(df_barcodes, 'sample_name', 'barcode', 'dpi', 'proportion')

p1 <- BarcodeFlow::BasicAlluvialPlot(df_barcodes)

cowplot::save_plot(p1, file.path(file.path(package_dir, 'doc', 'example.png')))



