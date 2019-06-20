#!/bin/bash
#
#$ -cwd

module load bedops
module load R

# directory with the MEDIPS outputs i.e. files ending in .wig
workingdir="/mnt/work1/users/home2/smohanra/pughlab/projects/BAMgineer/kui/HCC_Counts_wig/wigs-backup_no_span_change"

cd $workingdir
mkdir -p plots

# Loop through all the wig files
for i in *.wig
do
wigbed=$i$".bed"
wig2bed --zero-indexed --do-not-sort < $i > $wigbed

# this Rscript creates a matrix to be used for downstream analysis (as .rds files) using the bed file from the previous step and also makes QC plots 
Rscript bed_to_matrix.R -i $wigbed

done

# this Rscript is for merging multiple matrices together
# -i is the directory where the .rds files to be merged are (generated from the previous step)
# -s is a sample id to name the final full matrix (default is "HCC_all") 
Rscript merge_matrices.R -i $workingdir -s HCC_all
