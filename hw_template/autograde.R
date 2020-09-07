#----Set working directory to source file location----#
rm(list = ls())

#--------------Set This------#
loc       <- "local" # either "local", or "gradescope"
#loc       <- "gradescope"


#------DON'T TOUCH THIS------#

if(loc=="local"){ #Setting working directory to source file location if local
    setwd(dirname(rstudioapi::getSourceEditorContext()$path))
}
source("inputs.R")
source("autograder_setup.R")

#----------------------------#



if(status!="Error"){

    # ----- Put the Autograder Functions Here. aka ADD CODE HERE ----- #
    
 
    
    # ----------------------------------------------------------- #

    JSONmaker(test.results, loc)
}
