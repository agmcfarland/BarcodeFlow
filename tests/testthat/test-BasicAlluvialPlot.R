test_that("BasicAlluvialPlot returns expected number of rows in data sub object", {

  df_barcodes <- read.csv(test_path('testdata', 'barcode_table.csv'))

  df_barcodes <- FormatData(df_barcodes, 'sample_name', 'barcode', 'dpi', 'proportion')

  p1 <- BasicAlluvialPlot(df_barcodes)

  expect_equal(352, nrow(p1$data))
})
