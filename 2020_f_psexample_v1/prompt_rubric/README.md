The template folder houses the key functions to run the autograder. Please see the manual for an in depth review of each of the helper functions. Below is a discussion on the DGP.

DGP.R is designed to pull from a masterdata dataset. This course is set up where each homework assignment has one massive dataset in which a random subsample is drawn per student. DGP.R is how the sample is drawn. Notice that only one line needs to be edited in DGP.R (line 12). Currently, DGP.R draws random rows from the masterdata dataset and saves the individual file for the student. However, more complex draws can be made. Performing more complex draws would guarantee students all received "messy" datasets. The current setup could lead to one lucky student receiving a perfectly clean dataset.

Take for example the basic DGP

DGP <- function(masterdata="Masterdata.csv", PERMID=PERMID, dataname=dataname)\{
  masterdata <- read.csv(masterdata)
  set.seed(PERMID)
  d <- masterdata[sample(1:nrow(masterdata), 100, replace = T),]
  write_csv(d, dataname)
\}
