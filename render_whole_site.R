library(rmarkdown)
library(tidyverse)
files <- 
list.files(path = '_sessions',
           recursive = TRUE,
           pattern = '\\.Rmd',
           include.dirs = TRUE)


for (i in 1:length(files)){
  rmarkdown::render(paste0('_sessions/', files[i]))
}