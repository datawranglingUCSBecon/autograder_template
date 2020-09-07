#----Set working directory to source file location----#

# clear workspace
rm(list = ls())



#SET THIS!!!#
loc       <- "local" # either local, or gradescope
#------------#

#------DON'T TOUCH THIS------#

if(loc=="local"){ #Setting working directory to source file location if local
    setwd(dirname(rstudioapi::getSourceEditorContext()$path))
}
source("inputs.R")
source("autograder_setup.R")

#----------------------------#



if (status != "Error") {
    # ----- Put the Autograder Functions Here ----- #
    
    # Create the answers. Notice they aren't named the same as the homework
    answer.1 <- tibble(Class=c(colnames(fakedata),"Total"),Num=c(colSums(is.na(fakedata)),sum(is.na(fakedata))))
    answer.2 <- fakedata
    answer.2$State[answer.2$State=='Arisona']<-'Arizona'
    answer.3 <- mean(answer.2$Invoice..USD..,na.rm =TRUE)
    answer.4 <- sum(answer.2[which(answer.2$Paid=='No'),3],na.rm = T)/sum(answer.2[,3],na.rm = T)

    # Grading <--> comparing answer key answers to student answers
    # Problem 1 score:
    p1.score <-
        if (is.error(missing) == TRUE) {
            #checking to make sure they saved the name right
            test.results[1, ] <- c(
                "Problem 1: Missing value (10 pt.)",
                0,
                10 ,
                "mssing not found. Please ensure the variable is properly named"
            )
        } else if (isTRUE (all_equal(missing , answer.1))) {
            test.results[1, ] <- c("Problem 1: Missing value (10 pt.)",
                                   10,
                                   10 ,
                                   "nice work")
        } else{
            test.results[1, ] <- c("Problem 1: Missing value (10 pt.)",
                                   0,
                                   10 ,
                                   "Try Again")
        }
    
    p2.score <-
        if (is.error(data.cleaned == TRUE)) {
            #checking to make sure they saved the name right
            test.results[2, ] <-
                c(
                    "Problem 2: Data cleaning (12 pt.)",
                    0,
                    12 ,
                    "data.cleaned not found. Please ensure the variable is properly named"
                )
        } else if (isTRUE(all_equal(data.cleaned,answer.2))) {
            test.results[2, ] <- c("Problem 2: Data cleaning (12 pt.)",
                                   12,
                                   12 ,
                                   "nice work")
        } else{
            test.results[2, ] <- c("Problem 2: Data cleaning (12 pt.)",
                                   0,
                                   12 ,
                                   "Try Again")
        }
    p3.score <-
        if (is.error(avg_invoice == TRUE) || is.error(avg_invoice_paid==TRUE)) {
            #checking to make sure they saved the name right
            if (is.error(avg_invoice==TRUE)){
                if (is.error(avg_invoice_paid==TRUE)){
                    test.results[3, ] <-
                        c(
                            "Problem 3: Average (8 pt.)",
                            0,
                            8 ,
                            "both avg_invoice and avg_invoice_paid not found. Please ensure the variable is properly named"
                        )
                } else {
                    if (avg_invoice_paid==answer.4){
                        test.results[3, ]<-c(
                            "Problem 3: Average (8 pt.)",
                            4,
                            8 ,
                            "avg_invoice not found. Please ensure the variable is properly named"
                        )
                    }  else{
                        test.results[3, ]<-c(
                            "Problem 3: Average (8 pt.)",
                            0,
                            8 ,
                            "avg_invoice not found. ang_invoice_paid incorrect. Please ensure the variable is properly named"
                        )
                    }
                }
            }      else{
                if (avg_invoice==answer.3){
                    test.results[3, ]<- c(
                        "Problem 3: Average (8 pt.)",
                        4,
                        8 ,
                        "avg_invoice_paid not found. Please ensure the variable is properly named"
                    )
                }    else{
                    test.results[3, ]<- c(
                        "Problem 3: Average (8 pt.)",
                        0,
                        8 ,
                        "avg_invoice incorrect and avg_invoice_paid not found. Please ensure the variable is properly named"
                    )
                }
            }} else {
                if (avg_invoice == answer.3) {
                    if (avg_invoice_paid==answer.4){
                        test.results[3, ] <- c("Problem 3: Average (8 pt.)",
                                               8,
                                               8 ,
                                               "nice work")} else {
                                                   test.results[3, ] <- c("Problem 3: Average (8 pt.)",
                                                                          4,
                                                                          8 ,
                                                                          "check avg_invoice_paid")
                                               }
                }     else {
                    if (avg_invoice_paid==answer.4){
                        test.results[3, ] <- c("Problem 3: Average (8 pt.)",
                                               4,
                                               8 ,
                                               "check avg_invoice")}  else{
                                                   test.results[3, ] <-
                                                       c(
                                                           "Problem 3: Average (8 pt.)",
                                                           0,
                                                           8 ,
                                                           "Try again")        }
                    
                }
            }
    p4.score<-
        if (is.error(data.cleaned.split==TRUE)){
            test.results[4,]<- c("Problem 4: Split Data (2 pt.)",
                                 0,
                                 2,
                                 'check data.cleaned.split')
        } else{
            if( isTRUE (all_eqqual(data.cleaned.split,answer.5))){
                test.results[4,]<- c("Problem 4: Split Data (2 pt.)",
                                     2,
                                     2,
                                     'Well done.')
            } else{
                test.results[4,]<- c("Problem 4: Split Data (2 pt.)",
                                     0,
                                     2,
                                     'Try again')
            }
        }
    

    # --------------------------------------------- #
    
    JSONmaker(test.results, loc)
}
