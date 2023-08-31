test_that("CompleteCombinations generates expected number of combinations", {

  df_barcodes <- read.csv(test_path('testdata', 'barcode_table.csv')) %>%
    dplyr::select(sample_name, barcode, dpi, proportion)
  colnames(df_barcodes) <- c('sample_name_id', 'variable', 'time_point', 'variable_proportion')
  df_barcodes <- df_barcodes %>%
    dplyr::filter(variable_proportion > 0)

  df_barcodes_complete <- CompleteCombinations(df_barcodes)

  expect_equal(nrow(read.csv(test_path('testdata', 'barcode_table.csv'))), nrow(df_barcodes_complete))

})


