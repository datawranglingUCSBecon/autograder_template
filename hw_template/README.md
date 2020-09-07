# Intro 

The template folder houses the key functions to run the autograder. Please see the manual for an in depth review of each of the helper functions. 

The README.md for a homework assignment should cover:

1) Which lectures this homework reviews.

2) Key commands the students review.

3) Any potential issues discovered while writing the autograders.

Below, is a brief overview of the functions in the hw_template. This can be deleted when used in each individual homework assignment.

## autograde.R

This is the meat and potatoes of the autograder. This file will be grading the student's work. The TA will write the autograder functions between lines 20 and 24. Good autograders will take into account all possible inputs a student can enter. 

## autograder_setup.R

Gradescope requires specific output to grade student submissions. `autograder_setup.R` performs all of the "behind the scenes". Mainly, it calls the helper functions `setup.R`, `JSONmaker.R`, and `packages.R`. See the **helper_functions** folder for a description of each function. Also, refer to the *manual*. 

## clean_dat

Many times, TAs find datasets and clean them/messy them for the homework assignment. This folder is meant to hold the cleaning process. At the end of the cleaning process, the TA will create *Masterdata.csv* and save it in hw_template (no folders). 

## DGP.R

DGP.R is designed to pull from*Masterdata.csv*. This course is set up where each homework assignment has one massive dataset in which a random subsample is drawn per student. DGP.R is how the sample is drawn. Notice that only one line needs to be edited in DGP.R (line 12). Currently, DGP.R draws random rows from the masterdata dataset and saves the individual file for the student. However, more complex draws can be made. Performing more complex draws would guarantee students all received "messy" datasets. The current setup could lead to one lucky student receiving a perfectly clean dataset.

Take for example the basic DGP

```{#numCode .R .numberLines}
DGP <- function(masterdata="Masterdata.csv", PERMID=PERMID, dataname=dataname){
  masterdata <- read.csv(masterdata)
  set.seed(PERMID)
  d <- masterdata[sample(1:nrow(masterdata), 100, replace = T),]
  write_csv(d, dataname)
}
```

## inputs.R

The TA will input the basics of the homework here. For the autograder to properly operate, students must name their Rscripts the same, their dataframe must be named the same, and they must title their data the same name. Here is where the TA specifies these parameters. These parameters should be explicitely said in the prompt.

In addition, the TA must specify the number of parts of the homework assignment. For example, if there are 3 questions with 2 parts each, the TA will set `parts <- 6`. See the manual for more information.

## mass_email

Students are sent individualized datasets. The **mass_email** folder holds the email function. The email function references credentials and helper functions in the **helper_functions** folder. See the README.MD in the folder for more information or the manual.

## prompt_rubric

House the prompt and the rubrics here.

## README.md

This is the file that you are currently reading.

## Gradescope.zip

This zip folder is automatically made when `autograde.R` is run for the first time. It creates two files in the zip folder: `run_autograder` and `setup.sh`. These files are directly loaded into Gradescope. The TA will not need to touch these files. Rather, they simply pull and drag `Gradescope.zip` into the autograder spot on Gradescope. See the manual for more (and clearer) directions.

## solved_ta

TAs tend to solve the problems many different ways. In addition, many TAs tend to work on the same homework assignment. To keep things organized, they are recommended to store their files in this folder.
