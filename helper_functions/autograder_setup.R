##############################################
############### DO NOT TOUCH #################
##############  ANY OF THIS  #################
#############################################

# Getting location:
if(loc=="local"){
  dir_loc<- gsub(paste(".*",
                       basename(rprojroot::is_rstudio_project$find_file()),
                       "/",
                       sep = ""),
                 "",
                 dirname(rstudioapi::getSourceEditorContext()$path)
  )
}  


# pull in aux files: DO NOT TOUCH
library(here)
for(i in c("setup.R","JSONmaker.R","packages.R")){ # list of helper functions
    source(paste0(here::here(),"/","helper_functions/", i, ''))
}

#Sometimes, students will have rm(list=ls()) which will mess up the autograder. 
#Let's get rid of it

readr::write_lines((
  mgsub(readr::read_lines(rScript), # load the student submission
        c("rm\\(", "setwd\\(","View\\("), # What we want to get rid of
        c("#","#","#") # Just hashtag out the remaining letters
  )
),
paste("autograde_",rScript,sep = "") # Here I'm making their homework without the rm(list=ls()) command
)


if(loc=="local" ){ #Ensuring we don't run this on Gradescope and only run it when the zip file isn't already made
  source(paste0(here::here(),"/","helper_functions/zip_for_gradescope_2.R", ''))
}


# ---------Relies on all preset defined at the top of the page!!! DO NOT TOUCH------------ #
setup.helper(paste("autograde_",rScript,sep = ""),     # The student's Rscript name
             data,        # The name of the datafile they were given
             datatitle,   # The name they were supposed to give the datafile
             loc,         # Either local or gradescope. Default is Gradescope
             parts,       # Number of parts to the question
             Master,      # The name of the master datafile
             DGP          # Student data generating process. 
             #The file name should be the same as the process
)

# Remove the student's edited submission.
file.remove(paste("autograde_",rScript,sep = ""))

