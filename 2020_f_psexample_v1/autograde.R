rm(list = ls())

#--------------Set This------#
#loc       <- "local" # either "local", or "gradescope"
loc       <- "gradescope"


#------DON'T TOUCH THIS------#

if(loc=="local"){ #Setting working directory to source file location if local
    setwd(dirname(rstudioapi::getSourceEditorContext()$path))
}
source("inputs.R")
source("autograder_setup.R")

#----------------------------#
if(status!="Error"){

    # ----- Put the Autograder Functions Here. aka ADD CODE HERE ----- #
    answer.1 <- sum(fakedata$State == "Kansas")
    answer.2 <- sum(fakedata$Paid == "Yes")
    
    # Problem 1 score:
    p1.score <-
        if (is.error(invoice.kansas) == TRUE) {
            #checking to make sure they saved the name right
            test.results[1, ] <- c(
                "Problem 1: Kansas (10 pt.)",
                0,
                10 ,
                "invoice.kansas not found. Please ensure the variable is properly named"
            )
        } else if (invoice.kansas == answer.1) {
            test.results[1, ] <- c("Problem 1: Kansas (10 pt.)",
                                   10,
                                   10 ,
                                   "nice work")
        } else{
            test.results[1, ] <- c("Problem 1: Kansas (10 pt.)",
                                   0,
                                   10 ,
                                   "Try Again")
        }
    
    p2.score <-
        if (is.error(P1 == TRUE)) {
            #checking to make sure they saved the name right
            test.results[2, ] <-
                c(
                    "Problem 2: Invoice Completion (10 pt.)",
                    0,
                    10 ,
                    "P1 not found. Please ensure the variable is properly named"
                )
        } else if (P1 == answer.2) {
            test.results[2, ] <- c("Problem 2: Invoice Completion (10 pt.)",
                                   10,
                                   10 ,
                                   "nice work")
        } else{
            test.results[2, ] <- c("Problem 2: Invoice Completion (10 pt.)",
                                   0,
                                   10 ,
                                   "Try Again")
        }
    
    # ----------------------------------------------------------- #

    JSONmaker(test.results, loc)
}

