
rm(list = ls())

library(dplyr)
library(testthat)

package_dir <- '/data/BarcodeFlow'
set.seed(15)

# Generate a random barcode of specified length
generate_random_string <- function(characters = c("A", "C", "T", "G"), length) {
  characters <- c("A", "C", "T", "G")
  random_indices <- sample(length(characters), size = length, replace = TRUE)
  random_string <- paste0(characters[random_indices], collapse = "")
  return(random_string)
}

num_strings <- 100
string_length <- 12

generated_strings <- c()
for (i in 1:num_strings) {
  random_string <- generate_random_string(length = string_length)
  generated_strings <- c(generated_strings, random_string)
}

# Create barcode table with barcodes of count 0 to num_strings - 1. Use poisson distribution for sampling counts.
lower_limit <- 0
upper_limit <- num_strings - 1
lambda <- 4

df_barcodes <- data.frame(
  'barcode' = generated_strings,
  # 'stock' = sample(lower_limit : upper_limit, size = length(generated_strings), replace = TRUE),
  'stock_d0_stock' = rpois(lower_limit:upper_limit, lambda),
  'sample1_d14_plasma' = rpois(lower_limit:upper_limit, lambda - 1),
  'sample1_d120_plasma' = rpois(lower_limit:upper_limit, lambda - 1 - 1),
  'sample1_d300_plasma' = rpois(lower_limit:upper_limit, lambda - 1 - 1 - 1)
)

# Format barcode table to match the type of table that will be used as an input for plotting functions
df_barcodes <- df_barcodes %>%
  tidyr::pivot_longer(cols = -barcode, names_to = 'sample_name', values_to = 'count') %>%
  tidyr::separate(col = sample_name, into = c('animal_id', 'dpi', 'celltype'), remove = FALSE) %>%
  dplyr::group_by(sample_name) %>%
  dplyr::mutate(proportion = count/sum(count)) %>%
  dplyr::ungroup()

write.csv(df_barcodes, file.path(package_dir, 'tests', 'testthat', 'testdata', 'barcode_table.csv'), row.names = FALSE)

