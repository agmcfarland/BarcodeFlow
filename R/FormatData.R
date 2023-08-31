
FormatData <- function(data, sample_name_id, variable, time_point, variable_proportion){
  #' FormatData
  #'
  #' @description Extract relevant features from a dataframe necessary for alluvial plotting.
  #'
  #' @param data The `data.frame` object to be used for plotting.
  #' @param sample_name_id The column name containing a sample identifier.
  #' @param variable The column name containing the variable that is being examined. Must be in the same unit i.e. Days/Months/Years
  #' @param time_point The column name containing time point information.
  #' @param variable_proportion The column name that has the proportion value for each variable that was measured.
  #'
  #' @return A `data.frame` object with standardized column name outputs.
  #'
  #' @examples
  #' FormatData(df_barcodes, 'sample_name', 'barcode', 'dpi', 'proportion')
  #'
  #' @details Generates a `data.frame` object with original data and additional columns that are ordered factors to be used for plotting.
  #' Uses `BarcodeFlow::CompleteCombinations()`
  #'
  #' @import rlang
  #' @import dplyr
  #' @import tidyr
  #'
  #' @export

  sample_name_id <- rlang::sym(sample_name_id)
  variable <- rlang::sym(variable)
  time_point <- rlang::sym(time_point)
  variable_proportion <- rlang::sym(variable_proportion)

  data <- data %>%
    dplyr::select(
      !!sample_name_id,
      !!variable,
      !!time_point,
      !!variable_proportion,
    )

  colnames(data) <- c('sample_name_id', 'variable', 'time_point', 'variable_proportion')

  data <- CompleteCombinations(data)

  data <- data %>%
    ## time_point standardization
    # time_point changed to numeric
    # Make a factor of the original time_point input following the order of appearance of the ordered numeric time_point
    dplyr::mutate(
      time_point_original = time_point,
      time_point = gsub('[^0-9]', '', time_point_original),
      time_point = as.numeric(time_point),
      ) %>%
    dplyr::arrange(time_point) %>%
    dplyr::mutate(
      time_point_factor = factor(time_point_original, levels = base::unique(time_point_original))
    ) %>%
    ## sample_name_id standardization
    # sample_name_id order follows that of the time_point
    dplyr::arrange(time_point) %>%
    dplyr::mutate(
      sample_name_id_factor = factor(sample_name_id, levels = base::unique(sample_name_id))
    ) %>%
    ## variable standardization
    # variable follows order of time_point and then proportion of variable.
    # this makes the first time_point order-defining
    dplyr::arrange(time_point, variable_proportion) %>%
    dplyr::mutate(
      variable_order = seq(1, nrow(.), by = 1),
      variable_factor = factor(variable, levels = base::unique(variable))
    )

  return(data)
}




