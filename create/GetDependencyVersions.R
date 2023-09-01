rm(list = ls())

package_dir <- '/data/BarcodeFlow'

dependencies <- c('dplyr', 'tidyr', 'ggplot2', 'ggalluvial')

dependency_df <- lapply(dependencies, function(package){
  package_information <- c(package, as.character(packageVersion(package)) )
  return(package_information)
})

dependency_df <- as.data.frame(do.call(rbind, dependency_df))

colnames(dependency_df) <- c('package', 'version')

write.csv(dependency_df, file.path(package_dir, 'docs', 'dependencies.csv'), row.names = FALSE)
