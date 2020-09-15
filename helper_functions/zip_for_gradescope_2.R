# Gradescope requires a .sh and an executable file in a zip. This takes those two files and puts them into a zip
# Slight changes have to be made to the run_autograder file though. Namely, change the file paths. This is now done automatically
#

#Removing old gradescope.zip
if(file.exists("gradescope.zip")==TRUE){
  file.remove("gradescope.zip") #remove old zip
}

if(file.exists("gradescope")==TRUE){
  unlink("gradescope", recursive = T) # remove folder if someone opened it
}



# Changing the project name
if(is.error(basename(rprojroot::is_rstudio_project$find_file()))){
  stop("Error! Make sure you are in the Rproject. Go to the beginning of the Github repo on your computer and click .Rproj. You will know you are in the .Rproj because the R logo will have a banner.")
}

if(basename(rprojroot::is_rstudio_project$find_file()) %in% c("autograder","submission","source","clone", "github")){
  stop(cat("Error! Change name of Github repository. Illegal names are: autograder,submission,source,clone, github"))
}

#First line establishing Bash
write("#!/usr/bin/env bash",file="run_autograder") 

write("\ncd /autograder/", file = "run_autograder",append = T)

# clone the github repo and find the "answers" script to be used in grading.
write("\ngit clone https://USERNAME:PASSWORD@github.com/USERNAME/REPOSITORY", "run_autograder",append = T)

# Moving student code form submission to source
write(paste("\ncp /autograder/submission/",rScript, 
            " /autograder/",basename(rprojroot::is_rstudio_project$find_file()),"/",dir_loc,"/",rScript, 
                   sep = ""), file="run_autograder",append=T)

# Moving into necessary folder
write(paste("\ncd ", 
            "/autograder/",basename(rprojroot::is_rstudio_project$find_file()),"/",dir_loc,"/", 
            sep = ""), file="run_autograder",append=T)

# Run your autograder script.
write(paste("\nRscript autograde.R", sep = ""),
      "run_autograder",append = T)

#make it a Unix executable file
system("chmod 755 run_autograder") # Making it an executable file

#zip the two necessary files together
zipr("gradescope.zip", c("run_autograder",
                         paste(here::here(),"/",
                               "helper_functions/setup.sh",
                               sep = "")
)
)

#Get rid of this file. It's inside the zip now.
file.remove("run_autograder")
