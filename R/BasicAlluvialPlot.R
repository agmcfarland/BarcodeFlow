
BasicAlluvialPlot <- function(data) {
  #' BasicAlluvialPlot
  #'
  #' @description Takes in a formatted table and produces a basic alluvial
  #'
  #' @param data A `data.frame` object in the format produced by  `BarcodeFlow::FormatData`
  #'
  #' @return A `ggplot2` object.
  #'
  #' @examples
  #' BasicAlluvialPlot(df_barcodes)
  #'
  #' @details `data.frame` object is expected to be in the format produced by `BarcodeFlow::FormatData`. But does not technically require it to work. Can have additional columns.
  #'
  #' @import dplyr
  #' @import ggplot2
  #' @import ggalluvial
  #'
  #' @export

  p1 <- ggplot(data %>%
                 dplyr::filter(variable_proportion > 0),
               aes(
                 x = time_point_factor,
                 y = variable_proportion,
                 fill = variable_factor,
                 stratum = variable_factor,
                 alluvium = variable_factor)
  ) +
    geom_flow(
      curve_type = "cubic",
      stat = 'flow',
      color = "darkgrey",
      show.legend = FALSE
    ) +
    geom_stratum(
      show.legend = FALSE
    ) +
    theme_classic() +
    theme(
      aspect.ratio = 1,
      legend.position = 'none',
      plot.title = element_text(face = 'bold', hjust = 0.5),
      axis.line = element_blank(),#element_line(color = '#333333'),
      axis.ticks.length = unit(.25, 'cm'),
      axis.ticks = element_line(color = '#333333'),
      axis.text = element_text(size = 12, color = '#333333'),
      axis.title = element_text(size = 12, color = '#333333', face = 'bold')
    ) +
    scale_y_continuous(expand = c(0, 0, 0, 0), limits = c(0, 1.2), breaks = seq(0, 1, 0.25)) +
    scale_x_discrete(expand = c(0, 0, 0, 0))

  return(p1)
}
#
#
#
# library(dplyr)
# library(ggalluvial)
# # library(tidyr)
# # library(stringr)
#
# rm(list = ls())
#
# package_dir <- '/data/BarcodeFlow'
#
# df_barcodes <- read.csv(file.path(package_dir, 'tests', 'testthat', 'testdata', 'barcode_table.csv'))
#
# df1 <- FormatData(df_barcodes, 'sample_name', 'barcode', 'dpi', 'proportion')
#
# p1 <- BasicAlluvialPlot(df1)
#
# print(p1)



