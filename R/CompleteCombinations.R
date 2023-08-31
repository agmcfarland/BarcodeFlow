
CompleteCombinations <- function(data){
  #' CompleteCombinations
  #'
  #' @description Creates complete observations for each each sample_name_id, variable, and time_point column in `data`.
  #'
  #' @param data The `data.frame` object to have observations completed.
  #'
  #' @return A `data.frame` object with complete observations for each sample_name_id, variable, and time_point.
  #'
  #' @examples
  #' CompleteCombinations(df_barcodes)
  #'
  #' @details Helper function for `BarcodeFlow::FormatData`. Assumes column names are 'sample_name_id', 'variable', 'time_point', 'variable_proportion'.
  #'
  #' @import dplyr
  #' @import tidyr
  #'
  #' @export

  data2 <- data %>%
    tidyr::expand(sample_name_id, variable)

  data <- merge(
    data,
    data2,
    by = c('sample_name_id', 'variable'),
    all = TRUE
    ) %>%
    dplyr::mutate(variable_proportion = ifelse(is.na(variable_proportion) == TRUE, 0, variable_proportion))

  return(data)
}
#
# rm(list = ls())
#
# df_barcodes <- read.csv(test_path('testdata', 'barcode_table.csv')) %>%
#   dplyr::select(sample_name, barcode, dpi, proportion)
#
# colnames(df_barcodes) <- c('sample_name_id', 'variable', 'time_point', 'variable_proportion')
#
# df_barcodes <- df_barcodes %>%
#   dplyr::filter(variable_proportion > 0)
#
# nrow(df_barcodes)
#
# nrow(CompleteCombinations(df_barcodes))
