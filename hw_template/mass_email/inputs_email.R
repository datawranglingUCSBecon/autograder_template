rm(list=ls())
setwd(dirname(rstudioapi::getSourceEditorContext()$path)) #sets WD. Run this

roster       <- "class_roster_danny.csv" #Keep the .csv
message      <- paste("Please find attached the homework,
                 
                 Make sure you do it.") # Put the message in the paste
                                        # Include due dates and stuff
subject       <- "Homework 2"
prompt_name   <- "hw2_prompt.pdf" #Don't forget the .pdf!

#Run this line to actually send the email. THIS WILL SEND THE EMAIL TO ALL THE STUDENTS!!!!
#NO TAKEBACKS!
source("../../helper_functions/email.R")