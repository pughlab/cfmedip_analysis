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
The cfmedip_preprocessing.sh script is the only script that needs a change. The only mandatory change is the workingdir variable. This directory should be where all the wig files are located and this is where the QC plots and rds files will go. The -s parse in the second Rscript line can be changed to a sample id (this names the final merged matrix); the default for the -s is HCC_all.

The first Rscript transforms the bed files to tables (can uncomment a line to create matrices as well for individual samples). 

The second Rscript merges all "_table.rds" files in the directory into a large matrix of bins by samples. 

