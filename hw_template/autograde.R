rm(list = ls())

#--------------Set This------#
#loc       <- "local" # either "local", or "gradescope"
loc       <- "gradescope"


#------DON'T TOUCH THIS------#

#Setting working directory to source file location
if(loc=="local"){
    setwd(dirname(rstudioapi::getSourceEditorContext()$path))
}
source("inputs.R")
source(paste0(here::here(),"/helper_functions/autograder_setup.R",""))

#----------------------------#



if(status!="Error"){

    # ----- Put the Autograder Functions Here. aka ADD CODE HERE ----- #
    
 
    
    # ----------------------------------------------------------- #

    JSONmaker(test.results, loc)
}
