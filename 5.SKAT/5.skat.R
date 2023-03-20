## SKAT


library(tidyverse)
library(SKAT)



# Create the MW File
File.Bed = "data/Example1.bed"
File.Bim = "data/Example1.bim"
File.Fam = "data/Example1.fam"
File.SetID = "data/Example1.SetID"
File.SSD = "data/Example1.SSD"
File.Info = "data/Example1.SSD.info"
File.Cov = "data/Example1.Cov"


## Generate SSD file
Generate_SSD_SetID(File.Bed, File.Bim, File.Fam, File.SetID, File.SSD, File.Info)

## Load the SSD file
SSD.INFO = Open_SSD(File.SSD, File.Info)

# Number of samples
SSD.INFO$nSample

# Number of Sets
SSD.INFO$nSets


## load FAM data
FAM = Read_Plink_FAM(File.Fam, Is.binary=FALSE)

## Load covariate data
FAM_Cov = Read_Plink_FAM_Cov(File.Fam, File.Cov, Is.binary=FALSE)

# First 5 rows
FAM_Cov[1:5,]


# set phenotype
y = FAM_Cov$Phenotype

# set covariates
X1 = FAM_Cov$X1
X2 = FAM_Cov$X2



obj = SKAT_Null_Model(y ~ X1 + X2, out_type="C", data=FAM, Adjustment=FALSE) 


######## SKAT model
out_skat = SKAT.SSD.All(SSD.INFO, obj, method="SKAT")

## results
out

## First 5 rows
out_skat$results[1:5,]


######## SKAT-O model
out_skato = SKAT.SSD.All(SSD.INFO, obj, method="SKATO")

## results
out

# First 5 rows
out_skato$results[1:5,]



# The output object of SKAT.SSD.All has an output dataframe object “results”. You can save it using write.table function

df.out_skat = out_skat$results
write.table(df.out_skat, file="results/skat_result.txt", col.names=TRUE, row.names=FALSE, sep = "\t", quote = F)

df.out_skato = out_skato$results
write.table(df.out_skato, file="results/skato_result.txt", col.names=TRUE, row.names=FALSE, sep = "\t", quote = F)


