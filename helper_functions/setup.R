# clear workspace

# packages
suppressMessages(library(readr))
suppressMessages(library(tibble))
suppressMessages(library(stringr))
suppressMessages(library(berryFunctions))
suppressMessages(library(tidyverse))
suppressMessages(library(jsonlite))
suppressMessages(library(textclean))

setup.helper <- function(filename, # The name of the student's script
                         dataname, # The name of the student's data file
                         datatitle, # The name the student is supposed to give their dataset
                         type=c("local","gradescope"), # Whether the testing is done locally or for gradescope
                         number.of.tests, # Size of the tests
                         Master, #The name of the master datafile,
                         DGP # Student data generating process
                         ){ 
  
  
  if (type=="local") {
    
    if(!all(sapply(
      list(length(data), length(datatitle), length(Master)#, length(DGP)
      ), 
      function(x) x == length(data)))){
      status <<-"Error"
      stop("Error: length of `data`, `datatitle`, `Master`, and `DGP` do NOT match. Please update inputs.R.")
    }
    
    # Making sure the name of the filename and dataname are correct form
    if(!(typeof(filename)%in% c("character","logical"))) {
      status <<-"Error"
      stop("Error: Filename must be a character")
    }
    if(substring(filename,nchar(filename)-1, nchar(filename)) != ".R") {
      status <<-"Error"
      stop("Error: Wrong filetype. Ensure the filename ends with .R")
    }
    if(!(typeof(dataname) %in% c("logical","character"))) {
      status <<-"Error"
      stop("Error: Filename must be a character")
    }
    for(i in 1:length(dataname)){
      if(!is.na(dataname[i]) & substring(dataname[i],nchar(dataname[i])-3, nchar(dataname[i])) != ".csv") {
        status <<-"Error"
        stop("Error: Wrong datatype Ensure the datatype ends with .csv")
      }
    }
    
    json.filename <- "results.json"
    
  } else if (type=="gradescope") {
    
    json.filename <- "/autograder/results/results.json"
    
  } else {
    
    stop("Error: Type must be defined as `local` or `gradescope`. `local` is
             for testing the autograder on your computer. `gradescope` is for
             uploading.")
    status <<-"Error"
    
  }
  
  
  number.of.tests <- number.of.tests # This is the number of parts that will be graded. If there
  # are three questions with three parts each, set this to 9. If
  # there are 2 questions with one part each, set it to 2.
  
  
  # Creating the test results
  test.results <- data.frame("name"= rep(NA,number.of.tests),
                             "score" = rep(NA,number.of.tests),
                             "maxscore" = rep(NA,number.of.tests),
                             "output" = rep(NA,number.of.tests))
  
  
  if(sum(is.na(c(Master,data)))==0){ # If the code does not require datasets, skips
    
    for(i in 1:length(Master)){
      data <- read_csv(Master[i])
      write_csv(data, dataname[i])
    }
    
    # Hoping to get perm id
    try(source(filename))
    
    if(is.error(PERMID)==TRUE) {
      
      test.results[,1] = "ERROR"
      test.results[,2] = 0
      test.results[,3] = 0
      test.results[,4] = print("No PERMID. set your permid as `PERMID <- ####` where #### is your school PERMID")
      tests <- list()
      tests[["tests"]] <- list()
      
      for (i in 1:nrow(test.results)) {
        tests[["tests"]][[i]] <- list("name" = (test.results$name[i]),
                                      "score" = as.character(test.results$score[i]),
                                      "max.score" = as.character(test.results$maxscore[i]),
                                      "output" = (test.results$output[i]))
      }
      
      write(toJSON(tests, auto_unbox = T), file = json.filename)
      print(tests)
      status <<-"Error"
      return("Error: Missing PERMID")
      
    }
    
    # Generate individual data
    source(DGP)
    for(i in 1:length(Master)){
      DGP(Master[i], PERMID, dataname[i])
    }

  }
  
  if (is.error(source(filename)) == TRUE) {
    
    test.results[,1] = "ERROR"
    test.results[,2] = 0
    test.results[,3] = 0
    test.results[,4] = print("Error in sourcing submitted R file. This may be caused by: 1) Errors in your script. Try clearing the environment and rerun your script. 2) Trying to import an unrecognized dataset. Please ensure you import the dataset with the same name as the one in the email. 3) Conflicts in functions. Try specifying the package prior to using a command. For example, write tidyr::extract instead of extract. 4) Having used commands that only work in an interactive R session. In this case, please contact a course staff.")
    tests <- list()
    tests[["tests"]] <- list()
    
    for (i in 1:nrow(test.results)) {
      tests[["tests"]][[i]] <- list("name" = (test.results$name[i]),
                                    "score" = as.character(test.results$score[i]),
                                    "max.score" = as.character(test.results$maxscore[i]),
                                    "output" = (test.results$output[i]))
    }
    
    write(toJSON(tests, auto_unbox = T), file = json.filename)
    print(tests)
    status <<-"Error"
    return("Error: Error in sourcing submitted R file")
    
  }
  
  if(sum(is.na(c(Master,data)))==0){
   
    for (i in 1:length(Master)) {
      if(is.error(eval(parse(text=datatitle[i])))==TRUE){
        test.results[,1] = "ERROR"
        test.results[,2] = 0
        test.results[,3] = 0
        test.results[,4] = print(paste("Error: A data name not found. Make sure the dataset",dataname[i], "is saved as", datatitle[i], sep = " "))
        tests <- list()
        tests[["tests"]] <- list()
        
        for (i in 1:nrow(test.results)) {
          tests[["tests"]][[i]] <- list("name" = (test.results$name[i]),
                                        "score" = as.character(test.results$score[i]),
                                        "max.score" = as.character(test.results$maxscore[i]),
                                        "output" = (test.results$output[i]))
        }
        
        write(toJSON(tests, auto_unbox = T), file = json.filename)
        print(tests)
        status <<-"Error"
        return(paste("Error: A data name not found. Make sure the dataset",dataname[i], "is saved as", datatitle[i], sep = " "))
      }
    }
     
  }
  
  
  # Preliminary checks and warning message:
  warning.message <<- "No warning"
  if (sum(is.na(c(Master,data)))==0 & sum(str_detect(readLines(filename),'read\\.csv\\(')-str_detect(readLines(filename),'#.*read\\.csv\\('))>0) {
    warning.message <<- 'You have used `read.csv()` to import data. This might cause unexpected conflicts with the autograder. Try using `read_csv()` next time.'
  }
  
  
  test.results <<- test.results #Assigns the the global environment
  status <<- "NO ERROR"
  
    
}
