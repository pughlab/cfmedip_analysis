#!/bin/bash
#
#$ -cwd

# load bedops (needed for wig to bed conversion) and R (for matrix creation and QC plots)
module load bedops
module load R

# directory with the MEDIPS outputs i.e. files ending in _Counts.wig
cd /mnt/work1/users/home2/smohanra/pughlab/projects/BAMgineer/kui/HCC_Counts_wig/wigs-backup_no_span_change
mkdir -p plots

# Loop through all the wig files
for i in *_Counts.wig

do

wigbed=$i$".bed"
wig2bed --zero-indexed --do-not-sort < $i > $wigbed

# this Rscript creates a matrix to be used for downstream analysis (as .rds files) using the bed file from the previous step and also makes QC plots 
Rscript ../preprocessing_kui.R -i $wigbed
done

# this Rscript is for merging multiple matrices together; -i is the directory where the .rds files to be merged are (generated from the previous step); -s is a sample id to name the final full matrix (default is "HCC_all") 
Rscript ../merge_kui.R -i /mnt/work1/users/home2/smohanra/pughlab/projects/BAMgineer/kui/HCC_Counts_wig/wigs-backup_no_span_change -s HCC_all
