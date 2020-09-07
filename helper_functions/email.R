# YOU DO NOT NEED TO TOUCH THIS
  # IF YOU NEED TO TOUCH THIS, SOMETHING WENT HORRIBLY WRONG :/ 
if (!require("pacman")) install.packages("pacman") 
# We need these to send emails.
pacman::p_load(berryFunctions,
               dplyr, 
               ggplot2,
               glue,
               gmailr,
               progress,
               tidyverse,
               quantmod, 
               xts
               ) #Loading more packages
# Making sure everything is entered in correctly:

if(is.error(source("../inputs.R"))==TRUE){
  stop("ERROR: Can not find inputs.R. Make sure you do not rename the file.")
}

if(is.error(source("../DGP.R"))==TRUE){
  stop("ERROR: Can not find DGP.R Make sure you do not rename the file.")
}

if(is.error(gm_auth_configure(path = "../../helper_functions/creds_econ_email.json"))==TRUE){
  stop("ERROR: Google tolken has a configuration issue. You can redownload a tolken following the steps here: https://blog.mailtrap.io/r-send-email/")
}

if(is.error(read_csv(paste("../../class_roster/", 
                           roster,
                           sep = "")))==TRUE){
  stop("ERROR: Something went wrong with the roster. Ensure the roster is name appropriately and ends with a .csv. Ask the head TA if problems persist.")
}

if(file.exists(paste("../prompt_rubric/",prompt_name,sep = ""))==FALSE){
  stop("ERROR: The prompt file does not exist. Ensure that you have the .pdf in the prompt file and the organization of the homework folder was not changed.")
}



source("../inputs.R") # Source the name of the dataset from the inputs file.
# This guarantees that the name of the dataset given to the students
# matches the one used in the autograder
source("../DGP.R") #Used to make the student data

gm_auth_configure(path = "../../helper_functions/creds_econ_email.json") #I use this to get access to my gmail.
class_roster <- read_csv(paste("../../class_roster/", 
                               roster,
                               sep = "")
                         ) #Loading in the class roster
class_roster <- read_csv(paste("../../class_roster/",roster, sep = "")) # Reference the class roster
                                              # Adds usability past this year
n <- nrow(class_roster) # Telling the program to loop through the roster

if(!(length(n)>0)){
  stop("Something went wrong with the roster. Noone is in the roster. Make sure you entered in the roster name appropriately.")
}

cat("List of broken emails: \n")
for (i in 1:n) {
  for(j in 1: length(Master)){
    if(is.na(Master[j])==FALSE){ #If there is no dataset like in HW1
      DGP(masterdata = paste("../",Master[[j]],collapse = "", sep = ""), #Generating unique dataset by PERMID
          PERMID=class_roster$`ID number`[i],
          dataname=data[[j]]) #Make the dataset for the student
    }
    }

  
  my_email_message <- gm_mime() %>% 
    gm_to(class_roster$`Email address`[i]) %>% 
    gm_from("econ-econ145@ucsb.edu") %>% 
    gm_subject(subject) %>% 
    gm_attach_file(paste("../prompt_rubric/",prompt_name,sep = "")) %>% 
    gm_text_body(message) 
  
  for( j in 1:length(Master)){
    if(is.na(Master[j])==FALSE){ 
      my_email_message <- my_email_message %>% 
        gm_attach_file(data[[j]])  
    }
    }

  if(berryFunctions::is.error(gm_send_message(my_email_message))==TRUE){
    cat("-",class_roster$`First name`[i],class_roster$`Last name`[i], "(PERM ID:", class_roster$`ID number`[i], ") has an invalid email. The invalid email is: \"",class_roster$`Email address`[i], "\"\n")
  }
  if(i==n){cat("--- End of broken emails --- \n Done! :) \n You have successfully emailed", subject, "to class roster:", roster, "\n Please make sure to follow up with the students who have broken emails.")}
}

for(k in 1:length(Master)){
  if(is.na(Master[k])==FALSE){
    file.remove(data[[k]])
  }
}

