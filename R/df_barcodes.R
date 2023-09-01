#' Dataset of randomly created barcode counts.
#'
#' Barcode counts were obtained by sampling from a poisson distribution of
#' decreasing lambda values for increase DPI values to mimic selection.
#'
#' @format A data frame with 400 rows and 7 columns:
#' \describe{
#'   \item{barcode}{12 character ACTG barcode}
#'   \item{sample_name}{sample name given}
#'   \item{animal_id}{fake name of animal}
#'   \item{dpi}{fake days post infection assigned}
#'   \item{celltype}{fake cell type or stock}
#'   \item{count}{randomly sampled count for a barcode}
#'   \item{proportion}{calculated per sample_name and adds up to 1}
#' }
#' @examples
#'   df_barcodes
"df_barcodes"
