# user inputs: CHANGE THESE TO MATCH THE ASSIGNMENT
rScript   <- "test.R" # The name the student is supposed to give the file
data      <- c("fakedata.csv","fakedata1.csv") #Name of the CSV file. If multiple datafiles, put in a vector. i.e. c("data1.csv","data2.csv")
                # If only one datafile, can just enter name i.e. "fakedata.csv"
datatitle <- c("fakedata","fakedata2") #What the student is supposed to call the datasource
# If multiple datafiles, put in a vector. i.e. c("data1","data2")
parts     <- 2 # Number of problems being graded
Master    <- c("MasterData.csv","MasterData.csv") #The name of the master data file. This should be in folder
# # If multiple datafiles, put in a vector. i.e. c("MasterData1.csv","MasterData2.csv")
DGP       <- "DGP.R" # The data generating process for individual student's datasets. 
#The filename "DGP" should have one function titled "DGP".
