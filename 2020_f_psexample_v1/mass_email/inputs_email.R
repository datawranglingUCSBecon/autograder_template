rm(list=ls())
setwd(dirname(rstudioapi::getSourceEditorContext()$path)) #sets WD. Run this

roster       <- "class_roster_danny.csv" #Keep the .csv
message      <- paste("Hello student,

                 
                 Make sure you do the assignment attached. It is due eventually.
                      
                      The TA
                      
                      
                      ") # Put the message in the paste
                                        # Include due dates and stuff
subject       <- "Practice Assignment"
prompt_name   <- "2020_f_psexample_v1_prompt.pdf" #Don't forget the .pdf!

#Run this line to actually send the email. THIS WILL SEND THE EMAIL TO ALL THE STUDENTS!!!!
#NO TAKEBACKS!
source("../../helper_functions/email.R")

