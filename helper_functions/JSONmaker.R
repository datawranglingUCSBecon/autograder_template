# Installing necessary packages on computer if not already there
list.of.packages <- c("berryFunctions", "tidyverse","jsonlite")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if (length(new.packages)) install.packages(new.packages)


# packages
suppressMessages(library(berryFunctions)) #used to catch errors. Not used for now
suppressMessages(library(tidyverse)) # Used to see tidyverse packages
suppressMessages(library(jsonlite)) # Used to convert output to Gradescope Json format


# The json file maker for Gradescope
JSONmaker <- function(dat, type=c("local","gradescope")){
    dat <-dat %>% 
        type_convert()


    # Making sure that the type is properly defined
    if (type == "local") {
        json.filename <- "results.json"
    } else if (type == "gradescope") {
        json.filename <- "/autograder/results/results.json"
    } else {
        stop("Error: Type must be defined as `local` or `gradescope`. `local` is
             for testing the autograder on your computer. `gradescope` is for
             uploading.")
    }


    # Making sure the dataframe is properly labeled
    if ((typeof(dat) %in% c("list", "data.frame", "matrix")) == FALSE) {
        stop("Error: the input data must be a list or data frame. Please make sure
             the input data is of that class. This can be done by using the command
             as.data.frame")
    }

    if (sum(colnames(dat) == c("name","score","maxscore","output")) != 4) {
        stop("Error: There must be exactly 4 columns and  the column names must be
             exactly named `name`, `score`, maxscore`, and `output` in that order.
             Please make sure there are no capitals in the names. Gradescope is
             particular :/")
    }

    if (sum(is.na(dat)) != 0) {
        stop("Error: There is a missing value somewhere (NA). Please make sure all
             values are filled in. If a student recieved 0 points please make sure
             there is a 0 in the matrix")
    }

    if (sum(dat$score > dat$maxscore) != 0) {
        warning("A student's score is larger than the maximum score assigned in one
                of the tests. Is this correct? If so, ignore this warning. If not,
                please review :)")
    }


    dat$name <- as.character(dat$name)
    dat$score <- as.double(dat$score)
    dat$maxscore <- as.double(dat$maxscore)
    dat$output <- as.character(dat$output)


    if (sum(is.na(dat)) != 0) {
        stop("Something went wrong! An element of tests is now NA. This (probably)
             means that one of your columns had the wrong data type. Please make
             sure `name` is character, `score` is double, `maxscore` is double and
             `output` is character. You can change the type of column by using the
             command as._____. After making sure the columns are the right type,
             make sure there are no NAs. Sometimes changing a column type changes
             values to NA!")
    }
    
    dat <- dat %>% 
      add_row(name="Problem 0: Preliminary checks (0/0 pt.)",
              score=0,
              maxscore=0,
              output=warning.message,
              .before = 1)

    tests <- list()
    tests[["tests"]] <- list()
    
    for (i in 1:nrow(dat)) {
        tests[["tests"]][[i]] <- list("name" = (dat$name[i]),
                                      "score" = (dat$score[i]),
                                      "max.score" = (dat$maxscore[i]),
                                      "output" = (dat$output[i]))
    }

    write(toJSON(tests, auto_unbox = T), file = json.filename)
    return(dat)

}
