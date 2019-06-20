library(optparse)
#library(Matrix)

# optparse
option_list <- list(make_option(c("-i", "--input"), default="NA"))
opt <- parse_args(OptionParser(option_list=option_list))

ListMandatory<-list("input")
for (param in ListMandatory) {
  if (length(grep('^NA$',opt[[param]], perl = T))) {
    stop(paste("Parameter -", param, " can't be 'NA.", sep = "", collapse = ""))
  }
}

# pre-processing
wigbed <- opt$input
x <- read.table(wigbed,header=F,sep="\t")
wigbed_basename <- basename(wigbed)

y <- data.frame(data.frame(paste(x[,1], x[,2], x[,3], sep=".")),x[,5])
x2 <- data.frame(y[,-1])
colnames(x2) <- c(wigbed_basename)
rownames(x2) <- y[,1]

colnames(y) <- c("bins",wigbed_basename)

# matrix and sparse matrix
mat1 <- as.matrix(x2)
print("Total count of 0s in matrix:")
colSums(mat1 == 0)

print("Percentage of 0s in matrix:")
(colSums(mat1 == 0)/nrow(mat1))*100

#sparse_mat1 <- Matrix(mat1, sparse = TRUE)
saveRDS(mat1, file=(paste0(wigbed_basename,"_matrix.rds")))

# plot
png(paste0("plots/",wigbed_basename,".png"))
hist(mat1, xlim=c(0,50), breaks=1000000, col="black")
dev.off()

