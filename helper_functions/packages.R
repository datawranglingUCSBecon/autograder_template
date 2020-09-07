# Where you store all the packages being used. Most files reference this. Makes life a little bit easier
if (!require("pacman")) install.packages("pacman"); library(pacman)

pacman::p_load("berryFunctions", #Used for grading code
               #"choroplethr",
               #"choroplethrMaps",
               "jsonlite",       # creates the Json output for gradescope
               "janitor",        # cleaning data in setup section
               "kableExtra",     # making tables
               "lucid",          # class package
               "lubridate",      # class package
               "magrittr",       # class 
               "mgsub",          # multiple string substitutions at once
               "nycflights13",   # dataset
               "purrr",          # classic tidyverse package
               "readr",          # cleaning
               "rprojroot",      # used to get working directory and project directory
               #"summarytools",
               "stringr",        # used for cleaning strings
               "textclean",      # goes with mgsub s
               "tidyverse",      # obvioulsy need this :)
               "zip"             # making autograder inputs
               )
