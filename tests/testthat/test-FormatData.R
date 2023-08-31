test_that("barcode_table.csv can be read in form testdata", {

  df_barcodes <- read.csv(test_path('testdata', 'barcode_table.csv'))

  expect_equal(nrow(df_barcodes), 400)
})

test_that("FormatData returns same number of rows as barcode_table", {

  df_barcodes <- read.csv(test_path('testdata', 'barcode_table.csv'))

  df_barcodes_formatted <- FormatData(df_barcodes, 'sample_name', 'barcode', 'dpi', 'proportion')

  expect_equal(nrow(df_barcodes), nrow(df_barcodes_formatted))

})

