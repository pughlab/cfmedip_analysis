library(optparse)
require(data.table)
require(tidyverse)

# optparse
option_list <- list(make_option(c("-i", "--input"), default="NA"), make_option(c("-s","--sample_id", default="HCC_all")))
opt <- parse_args(OptionParser(option_list=option_list))

ListMandatory<-list("input")
for (param in ListMandatory) {
  if (length(grep('^NA$',opt[[param]], perl = T))) {
    stop(paste("Parameter -", param, " can't be 'NA.", sep = "", collapse = ""))
  }
}

# merge pre-processing
workdir <- opt$input
sampleid <- opt$sample_id
setwd(workdir)

files <- list.files(path = workdir, pattern = "\\_table.rds$", full.names = TRUE)
data_list = lapply(files, function (x) data.table(readRDS(x)))
hcc_final <- reduce(data_list, full_join, by = "bins")

x2 <- data.frame(hcc_final[,-1])
rownames(x2) <- hcc_final[,1]
colnames(x2) <- gsub(".wig.bed", "", colnames(x2))

# matrix
mat1 <- as.matrix(x2)
saveRDS(mat1, file=(paste0(sampleid,"_final_fullmatrix.rds")))
