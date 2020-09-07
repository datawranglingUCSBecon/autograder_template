##############################################
############### DO NOT TOUCH #################
##############  ANY OF THIS  #################
#############################################

# Getting location:
if (loc=="local") {
  dir_loc<- gsub(paste(".*",
                       basename(rprojroot::is_rstudio_project$find_file()),
                       "/",
                       sep = ""),
                 "",
                 dirname(rstudioapi::getSourceEditorContext()$path)
  )
  
  
  # Count distance from autograderecon:
  
  dist <- stringr::str_count(dir_loc,"/")+1  #counting number of backslashes to know how far "up" to go in the filepath. Have to do +1 because there is one at beginning not accounted for
  up   <- paste(rep("../",dist),
                sep = "", 
                collapse = ""
  ) #moving up the directory
  
}

# pull in aux files: DO NOT TOUCH
for(i in c("setup.R","JSONmaker.R","packages.R")){ # list of helper functions
  if(loc == "gradescope"){
    source(i)
  }else{
    source(paste0(up,"helper_functions/", i, ''))
  }
}

#Sometimes, students will have rm(list=ls()) which will mess up the autograder. 
#Let's get rid of it

readr::write_lines((
  mgsub(readr::read_lines(rScript), # load the student submission
        c("rm\\(", "setwd",'View'), # What we want to get ride of
        c("#","#","#") # Just hashtag out the remaining letters
  )
),
paste("autograde_",rScript,sep = "") # Here I'm making their homework without the rm(list=ls()) command
)


if(loc=="local" ){ #Ensuring we don't run this on Gradescope and only run it when the zip file isn't already made
  source(paste0(up,"helper_functions/zip_for_gradescope_2.R", ''))
}


# ---------Relies on all preset defined at the top of the page!!! DO NOT TOUCH------------ #
setup.helper(filename=paste("autograde_",rScript,sep = ""),     # The student's Rscript name
             dataname=data,        # The name of the datafile they were given
             datatitle=datatitle,   # The name they were supposed to give the datafile
             type=loc,         # Either local or gradescope. Default is Gradescope
             number.of.tests=parts,       # Number of parts to the question
             Master=Master,      # The name of the master datafile
             DGP=DGP          # Student data generating process. 
             #The file name should be the same as the process
)

# Remove the student's edited submission.
file.remove(paste("autograde_",rScript,sep = ""))

