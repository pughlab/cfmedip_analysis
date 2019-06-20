# cfMeDIP Analysis 
### Maintainer 
Suluxan Mohanraj suluxan.mohanraj@uhnresearch.ca

## PRE-PROCESSING
### Dependencies 
|      Tool     |    Version    |      Info     |
| ------------- | ------------- | ------------- |
|     bedops    |    2.4.14     | converts wig to bed  |
|       R       |     3.5.0     | converts bed to matrix  |

Note: versions of tools above are versions that were used... any latest versions will work. 


### R Packages
Install using the install.packages("package_name") command in R.

|      Packages     |  
| ------------- |
|     data.table    | 
|       tidyverse       |    
|       optparse       |  


### Customizing the script
The cfmedip_preprocessing.sh script is the only script that needs a change. The only mandatory change is the workingdir variable. This directory should be where all the wig files are located and this is where the QC plots and rds files will go. It is also assumed the Rscripts are found in this same directory but the location of them can be changed in the cfmedip_preprocessing.sh script. 

Optional change: the -s parse in the second Rscript command can be changed to a sample id (this names the final merged matrix); the default for the -s is HCC_all.

### Summary of scripts
The cfmedip_preprocessing.sh script transforms wig files to bed files and then proceeds to run the Rscripts which are described below. 

The first Rscript (bed_to_matrix.R) transforms the bed files to tables (can uncomment line 37 in this script to create matrices as well for individual samples). 

The second Rscript (merge_matrices.R) merges all "_table.rds" files in the working directory into a large matrix of bins by samples. 

