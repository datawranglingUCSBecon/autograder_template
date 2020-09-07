# This is how each student is assigned their unique dataset
  # The DGP may change depending on the assignment. 
  # Please Please Please Please do not change the name of the DGP nor the inputs of the DGP
      # Simply change how the dataset "d" is created (line 9)

DGP <- function(masterdata="Masterdata.csv", PERMID=PERMID, dataname=dataname){
  masterdata <- read.csv(masterdata)
  set.seed(PERMID)
  #---------------#
  #You can change this line however you please, Do not change any other lines in the 
    # folder PLEASE PLEASE PLEASE :) 
  d <- masterdata[sample(1:nrow(masterdata), 1000, replace = F),]
  #---------------#

  write_csv(d, dataname)
}
