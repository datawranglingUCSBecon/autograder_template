---
title: "Gradescope Autograder Tutorial with R"
author: Danny Klinenberg^[University of California, Santa Barbara]
date: "Last Updated: 2020-07-21"
output: 
  pdf_document:
    highlight: haddock
    toc: true
    number_sections: true
    latex_engine: xelatex
header-includes:
  - \usepackage[fontsize=12pt]{scrextend}
  - \usepackage{setspace}\doublespacing
  - \usepackage{pdfpages}
  - \usepackage{caption}
urlcolor: blue
---



\newpage

# Introduction

## Welcome

Welcome to **Data Wrangling for Economics**! This course will focus on students learning the basics of data cleaning and manipulation through the statistical software R. All homework and exams will have a coding component. To grade this, the class is utilizing a software called **Gradescope**. This software allows universities to automatically grade assignments including code. In this class, students will submit both their code and a breif writeup simulating real world data analysis. This manual will focus on the code aspect of their submissions.

Students will upload their code to Gradescope which will grade it. In order for Gradescope to do this, the instructor must supply an **autograder** for each assignment. An autograder is a script that reads scripts and assigns a score to the accuracy. This tutorial is meant to teach the reader how to write a Gradescope autograder in R.

After reading through the manual, you should:

(1) Know what R and Rstudio is as well as how to download both programs.

(2) Know how to log into Github, clone repositories to your computer, pull the repository to your computer, and upload.

(3) Know what Gradescope is, how to log in, and upload autograders.

(3) Know the components of an autograder.

(4) Be able to write your own autograder.

(5) Upload the autograder to Gradescope through Github.

(6) Confidently debug your autograder.

This manual is written for incoming TAs. It is assumed the infrastructure for the class is already in place. If you are building the course from scratch, see the *Building Infrastructure* section at the very end of the manual.

The flexibility of the infrastructure discussed allows for usage beyond **Data Wrangling in R**. While the target audience is the incoming TAs, the manual and infrastructure have uses for all individuals interested in assigning coding homework in R. Other resources exists for C++, Python and R. Please see the [community resource boards](https://gradescope-autograders.readthedocs.io/en/latest/resources/).

This is a working draft of the manual. Please do not distribute. Please do not share this manual with current or potential students of **Data Wrangling in R**.

## R and RStudio {#r_and_rstudio}

R is a powerful statistical software used for data analysis. R can be downloaded [here](https://cran.r-project.org/). Pick the appropriate version for your device.

Rstudio is a "skin" for R. This allows the user to script, create latex documents integrated to code, and much much more! The program can be downloaded [here](https://rstudio.com/products/rstudio/download/). Pick the free desktop version.

### RProjects

R projects create environments within R. These environments include files (Rfiles, datasets, etc.) as well as saved settings. This is extremely useful for integration with Github. You'll notice you are in a project when the R banner has a logo around it:

\begin{center}
\frame{\includegraphics[width=5in]{pictures/rproject.png} }
\end{center}

Creating projects will be discussed in the [Github](#github) section.

## Github

Github is an online code sharing platform. It allows for collaboration among many individuals on the same piece of code, saving past version. All autograders for this course will be uploaded to Github. This is done for two reasons: (i) reproducibility of the course and (ii) efficiency in debugging.

We will be working in a shared repository from individual accounts. Think of this as a shared folder in Google Drive: we can all edit, upload, and download in real time.

At the end of this document, you should be able to:

- log into Github

- create a clone of the repository on your computer

- be familiar with the main github commands

- upload and download from Github using RStudio

This is not an exhaustive manual. It is an introduction to Github with RStudio. 

### Getting Started

First, you will have to create a Github. Simply log onto [github.com](https://github.com/) and sign up. It's free! After creating a Github, you will be invited to the Github repository. Accept the invitation. The repository will look something like this:

\begin{center}
\frame{\includegraphics[width=5in]{pictures/github1.PNG} }
\end{center}

Click `clone or download` (the green button) then copy the *password protected SSH key* (where the green arrow is pointing). 

\begin{center}
\frame{\includegraphics[width=5in]{pictures_github/github_copy.PNG} }
\end{center}


In order to make working with Github as easy as possible, the TA will clone the repository to their home computer. This way they can do all their edits natively and then upload back to Github for everyone to use. If you are working with a PC, you will need to download [GitBash](https://gitforwindows.org). Mac computers have GitBash integrated into their terminal.

- Next, open RStudio. Go to `File` and choose `New Project`.

- Choose `Version Control`.

- Click `Git`.

- paste the *password protected SSH key* into `Repository URL`. Name the project whatever you want and save it wherever you want.

Congrats! Now you have the Github repository saved onto your computer. Everything you do on your computer can be synced with the Github repository and everything on the repository can be synced with your computer! The next section will go through how that works.

### The Basics of Git and Github

Many, many, many sources exist providing tutorials on using Github (e.g. [here](https://happygitwithr.com), [here](http://r-pkgs.had.co.nz/git.html) and [this one](https://towardsdatascience.com/getting-started-with-git-and-github-6fcd0f2d4ac6)). This manual will focus on the Github steps relevant to the course. Please read through at least the first two links. 

When we run into conflicts, check out this [link](https://medium.com/@RedRoxProjects/how-do-i-git-three-ways-to-solve-a-merge-conflict-cde4d7924c80).

The big ideas you need to take away from the links are: `git pull`, `git add`, `git commit`, `git push`, and `version control`. 


### The Git pane

The Git pane is a GUI interface for Git. Below is a picture of the pane with some key features highlighted:

\begin{center}
\frame{\includegraphics[width=5in]{pictures_github/github_pane.PNG} }
\end{center}

- Staged (pink arrow): Click the box to `git add`.

- Commit (pink box): This is equivalent to `git commit`.

**Pro Tip: `git commit` comments should be short. Each commit should be one task. Examples of this would be writing a line in a manual, or writing one answer for an autograder. This makes it easier to retrace steps in the future.**

- Blue arrow: `git pull`. Always do this before doing anything. `git pull` syncs the files on your computer with that in Github.

- green arrow: `git push`. This syncs Github with your changes on your computer.

`git add` stages your changes, `git commit` allows you to comment the changes, `git push` sends your changes to Github, and `git pull` pulls all changes to Github to your computer.

**Pro-tip: A git commit should equate to one task. Each git commit should be summarized in a sentence or less. This means that you will be constantly git committing and pushing to Github.**

### Version Control

Version control is used to ensure individuals don't "bump" into each other. With many people editing the same documents, sometimes changes are incompatible with merging. Imagine you and another colleague both edit the same line of code. Luckily, Github is perfectly equipped to handle these issues. This idea will be revisited in the **Version Control** section.

To end this section, I will state a few Git commandments I've made up or found:

$$\text{Github Commandment 1: Push and Pull often}$$
If you think you are pushing or pulling too much, you're not. People will be making changes constantly and this will lead to issues if everyone isn't on the same page.

$$\text{Github Commandment 2: Never, Ever, Ever, EVER git push --force}$$
This overrides any merge conflict. That means you are saying that your stuff should override everything. Don't do that. If there's a conflict, talk with your team and figure out what's the best course of action.

## Gradescope

### Intro

Gradescope is a $3^{rd}$ party software designed to make grading faster and easier. Gradescope allows for all types of assignments to be graded. This class will focus on using Gradescope to grade student written assignments and code. We will be utilizing Gradescope's autograder functions. Before delving into the autograder, this section will walk the reader through the basic navigation of Gradescope. For the purposes of the manual, we will be working in the course "Practice". This section will explain:

(1) How to find and log into Gradescope.

(2) How to navigate to assignments.

(3) How to setup new assignments.

(4) Where to enter in the autograder.

### Navigating Gradescope

To begin, simply type in [www.gradescope.com](https://www.gradescope.com/). If the user is not already logged in, they will be greeted with the following image:

\begin{center}
\frame{\includegraphics[width=5in]{pictures/gradescopeintro.png} }
\end{center}

Click the "log In" button in the top right hand corner. You will be redirected to a login screen. Click **School Credentials** and select UCSB. From there, you will log in using your **UCSB** login information. The page will then direct you here. Please click the relevant course (in our example, it is **Practice**):

\begin{center}
\frame{\includegraphics[width=5in]{pictures/gradescopeintro2.png} }
\end{center}

#### Making a New Assignment

Gradescope assignments are created using the button in the bottom right hand corner:

\begin{center}
\frame{\includegraphics[width=5in]{pictures/gradescopeinto3.png} }
\end{center}

A popup box will ask what type of assignment is being created. Select **</> Programming Assignment**, then click next.

Next, a popup creating the assignment setting will appear. Please fill in the setting appropriately. This will be provided to you by the head TA in the form of a rubric or via conversation. If you do not know the setting, **ASK A FELLOW TA OR INSTRUCTOR**. The example image has been filled in for illustrative purposes:

\begin{center}
\frame{\includegraphics[width=5in]{pictures/gradescopeintro4.png} }
\end{center}

Gradescope will then automatically open to the outline section. Notice that the autograder points are already in the top right hand corner. Add a new question titled "style" and set the point value to 0. This allows the grader to allocate points for "clean code". By setting it equal to 0, we are saying we don't care about the cleanliness of the code. In the future, this may become part of the rubric, but for now leave it as 0. Then click "save outline".

\begin{center}
\frame{\includegraphics[width=5in]{pictures/gradescopeintro5.png} }
\end{center}

Finally, we are at the upload autograder phase! This is where the reader will submit the autograder. What an autograder is and the components of an autograder are discussed in details in the following chapters. For the time being, just know the autograder comprises a zip file called "Autograder.zip" and an R file on Github. Click the "select Autograder.zip" file and upload your created autograder. 

\begin{center}
\frame{\includegraphics[width=5in]{pictures/gradescopeintro6.png} }
\end{center}

This concludes the section on Gradescope. At the end of this section, the reader should know:

(1) How to find and log into gradescope.

(2) How to navigate to assignments.

(3) How to setup new assignments.

(4) Where to enter in the autograder.zip. The reader does not yet know what constitutes the autograder.zip.



The following section will delve into the parts of the autograder and how to actually make one.

# How to Use This 

Now that R, RStudio, and Github are setup, we will go through the layout of the repository. If you have not yet set up [R or Rstudio](#r_and_rstudio) or [Github](#github), please click the links and do so. The Github repository will look similar to this:

\begin{center}
\frame{\includegraphics[width=5in]{pictures/github3.png} }
\end{center}


# The Autograder

An in depth review of autograders is provided on the gradescope [website](https://gradescope-autograders.readthedocs.io/en/latest/). This section will review the main features and what is directly applicable to this course.

## Parts of the Autograder

The Autograder is composed of multiple files. The files that go directly into gradescope are:

(1) **setup.sh**: installs all dependencies into Gradescope. This means the necessary packages, R, and the github codes. The file is a shell script. To open the setup file, right click on it and select "open with TextEdit" ("Notepad" for PC). You will simply copy this file over. **No editing needs to happen in this file!!** Just copy and paste. That said, the file looks like this:

\begin{center}
\frame{\includegraphics[width=5in]{pictures/setup1.png} }
\end{center}

The first line is saying that it's a bash file. The following 5 non-blank lines are downloading Linux and R. The following group of lines (Rscript -e) are installing the necessary Rpackages for the homework. Make sure you set dependenceis to **TRUE**. Otherwise, Gradescope will (probably) time out.

On a very technical note, Gradescope autograders run on Ubuntu 18.04 virtual machine. The default version of R downloaded on the machine is **R 3.4.4**. If you need a different version of R, you must specify specific lines in the setup.sh file. The code provided above (feor **setup.sh**) installs R 3.6.3.

Notice the line follows a pattern: **Rscript -e "install.packages('PACKAGE_NAME', dependencies=TRUE)"** where PACKAGE_NAME is the name of a package used in the software.


(2) **run_autograder**: runs and compiles the autograder suite and produces the output in the correct place. run_autograder is a .txt file. The file looks like this:

\begin{center}
\frame{\includegraphics[width=5in]{pictures/runautograder1.png} }
\end{center}

- **#!/usr/bin/env bash**: establishing this is a bash file

- **# move student submissions to appropriate locations on remote server**: Describing what the file is doing. This is not run.

- **cp /autograder/submission/test.R /autograder/source/test.R**: copies the student's submission from the autograder submission file to the source file. The source file is where your autograder will live along with *setup.sh* and *run_autograder*. You will have to change *test.R* to the name of the student's file name. 

- **cd /autograder/source**: copies the source directory. DO NOT TOUCH THIS.

- **git clone https://GITHUBUSERNAME:GITHUBPASSWORD@github.com/datawranglingUCSBecon/autograder**: This will clone the github repository. Each time the autograder is run it will reclone the repository. This allows for little changes to be made to the code. 

- **#Loading the preset functions. DO NOT CHANGE.**: A comment for those reading the code.

- **cp autograderecon/helperfunctions/JSONmaker.R /autograder/source/JSONmaker.R**: Copies the helper function *JSONmaker.R* into the source folder.

- **cp autograderecon/helperfunctions/setup.R /autograder/source/setup.R**: Copies the helper function *setup.R* into the source folder.

- **cp autograderecon/helperfunctions/packages.R /autograder/source/packages.R**: Copies the helper function *packages.R* into the source folder.

- **cp autograderecon/Template/autograder_setup.R** 

  **/autograder/source/autograder_setup.R**: Copies the helper function *autograder_setup.R* into the source folder.

- **# Grab the Data generating process.**: A comment.

- **cp autograderecon/Template/DGP.R /autograder/source/DGP.R**: Copies the unique student data generating process into the source folder.

- **# Grab the autograder you wrote.**: A comment.

- **cp autograderecon/Template/inputs_template.R** 
    
  **/autograder/source/inputs_template.R**: Copies the inputs into the source folder.

- **# Grab master datafile.**: A comment.

- **cp autograderecon/Template/MasterData.csv /autograder/source/MasterData.csv**: Copies the master datafile into the source folder.

- **Rscript autograder/Practice/autograde_test.R**: This runs the home-made autograder. You will change Practice to the name of the folder you are working in and autograde_test.R to the name of the Rscript you wrote. Make sure *autograde_test.R* matches the *autograde_test.R* which matches the name of your Rscript!

(3) **autograder_setup.R**: An R function that references the other helper functions. This will never need to be edited

(4) **inputs_template.R**: The pre-requisites necessary for the homework assignment. This is set to the specific homework assignment

```{#numCode .R .numberLines}
# user inputs: CHANGE THESE TO MATCH THE ASSIGNMENT
rScript   <- "test.R" # The name the student is supposed to give the file
data      <- "fakedata.csv" #Name of the CSV file
datatitle <- "fakedata" #What the student is supposed to call the datasource
parts     <- 2 # Number of problems being graded
Master    <- "Masterdata.csv" #The name of the master data file. This should be in folder
DGP       <- "DGP.R" # The data generating process for individual student's datasets. 
                     #The filename "DGP" should have one function titled "DGP".
```

Each line does the following:

- 2: The name the student is supposed to name their Rscript.

- 3: the name of the dataset each student is given.

- 4: the name the student is supposed to call their datafile.

- 5: The number of parts to the homework assignment.

- 6: The name of the master datafile.

- 7: The specific data generating process for each student's individual dataset. Ensure the filename matches the function name.

(5) **DGP.R**: The data generating process used to create each student's individual dataset. The default DGP will be:

```{#numCode .R .numberLines}
# This is how each student is assigned their unique dataset
  # The DGP may change depending on the assignment. 
  # Please Please Please Please do not change the name of the DGP nor the inputs of the DGP
      # Simply change how the dataset "d" is created

DGP <- function(masterdata="Masterdata.csv", PERMID=PERMID, dataname=dataname){
  masterdata <- read.csv(masterdata)
  set.seed(PERMID)
  d <- masterdata[sample(1:nrow(masterdata), 1000, replace = T),]
  write_csv(d, dataname)
}
```

Each line does the following:

- 1-4: Description of the function
- 6-11: The data generating process. In this example, the function inputs the master datafile, the student's PERM, and the name of the dataset (given in the homework assignment) and output the unique student dataset.

(6) **autograde_template.R**: This is the file that the TA will be editing. The autograde_test.R file is the Rscript that grades Rscripts. Basically, what that means is the TA will write the correct script with the correct answers, then compare their answers to the students answers. The hard part will be trying to account for how each student can mess up the answer! A general layout of the autograder is below followed by a line-by-line description of the code.

******************************

```{#numCode .R .numberLines}
#----Set working directory to source file location----#
rm(list = ls())

#--------------Set This------#
loc       <- "local" # either "local", or "gradescope"
#loc       <- "gradescope"


#------DON'T TOUCH THIS------#

source("inputs_template.R")
source("autograder_setup.R")

#----------------------------#



if(status!="Error"){

    # ----- Put the Autograder Functions Here. aka ADD CODE HERE ----- #
    
 
    
    # ----------------------------------------------------------- #

    JSONmaker(test.results, loc)
}
```

******************************

Each line does the following:

- 2: clears environment

- 5: Set whether you are working locally (aka your own computer) or sending to *Gradescope*. Forgetting to change this to *Gradescope* will be the number one reason why Gradescope will break.

- 11-12: Source two R files. This function was created to automatically grade issues such as mislabeled R-files, data, or other generally weird things that could occur. *autograder_setup* will check the student:

  - Called the function by the right name.
  
  - Called the data by the right name.
  
  - Included their PERMID
  
It then returns:

  - A dataframe called *test.results* that the TA will fill in with the student's score. This dataframe is a "parts" (line 22) x 4 dataframe. The *test.results* dataframe looks something like this when "parts"=2:
  

```
##   name score maxscore output
## 1   NA    NA       NA     NA
## 2   NA    NA       NA     NA
```
  
   All the TA has to do is fill in the name of the part (e.g. "Problem 1 (10 pt.)" ), the score the student received, the maximum possible score for that part, and any comment they'd like the student to see. Columns 1 and 3 will be some pre-determined value while columns 2 and 4 will be student dependent. This means there must be scripts that account for all possible answers (in theory).
   
   The creation of this table may seem a bit confusing. The reason for the table creation and fill-in method is Gradescope requires a specifically formatted JSON[^note] file in order to grade the students' work. To try and simplify the process, a helper function was written to convert a table to a JSON file. In order for the helper function to create the JSON file, it requires a pre-formatted dataframe. 

[^note]: JSON is a way to store data. No need to know anything else because of the fill-in-the-table approach!

- 18-27: Where the TA will fill in test.results. This is where all the magic happens. This is where the code is correctly run by the TA and then compared to the student's answers. The main takeaway here is that each line of test.results must follow the same pattern:

$$\text{c("Name", "Student Score", "Max Score", "Comments")}$$
The student score does not have to be filled in-line. The example above was a very simple grading scheme so that it could be put in-line. In later examples, I show more complex problems where the grader is done out-of-line.

How the table gets filled in is entirely up to the TA. The key is that the table is completed in that order. JSONmaker will report errors if the table does not match this specification.

- 27: A helper function that exports the test.results in the proper format for Gradescope to read. For those technically inclined, more information can be found [here](https://gradescope-autograders.readthedocs.io/en/latest/specs/#output-format) under **output format**.

## A Fully Worked Out Example.

Here is an example homework assignment:

******************************

$$\text{Problem Set Example}$$

 Hello student with PERMID 1234,

 Welcome to practice assignment 1. You have been given a dataset with 1000 observations and 4   columns titled: *Names*, *State*, *Invoice...USD...*, and *Paid*. You have been asked to do the following:

1) Save your Rfilename as *test.R*.
2) Locally read in your data file *fakedata.csv* and save it as *fakedata*.
3) Save your PERMID number as PERMID (e.g. PERMID <- #####)
4) Report how many invoices came from Kansas. Save this as *invoice.kansas* (yes, capitals matter)
5) Report how many individuals have paid their invoices. Save this as *P1*. 

Upload your R code to Gradescope.

**ALL CHANGES TO THE DATA MUST BE DONE WITHIN THE RSCRIPT SUBMITTED.**

******************************

We will write an autograder for this problem set. Below are the steps:

### Git pull

First, you must make sure your native repository is up to date. Many people will be updating the Github at once. Open the RProject and press the blue arrow.

This will update your github status.

### Enter the Autograderecon Folder

This folder is the folder that was downloaded from Github earlier in the manual. You should see many folders including a *template* folder. You should also see a folder with the same name as your assignment. In this case, it is *PSExample*. Copy the contents in the template folder into the PSExample folder. Rename *autograder_template.R* to *autograder_{name of assignment}.R* and *inputs_template.R* to *inputs_{name of assignment}.R*. In this case, it would be *autograder_PSExample.R* and *inputs_PSExample.R*. The *PSExample* folder should now include:

\begin{center}
\frame{\includegraphics[width=5in]{pictures/exampl1.png} }
\end{center}

Now would be a good time to git commit and push your work.

Notice that a master dataset was already in your folder. There are now seven files in your folder: (i) masterdata.csv, (ii) run_autograder, (iii) setup.sh, (iv) autograde_PSExample.r, (v) autograder_setup.R, (vi) DGP.R and (vii) inputs_PSExample.R. You copied in all but (i). Notice you only have to copy these three files in if they are not already there. 

**Pro Tip: Sometimes, the prompt and rubric will also be in the folder. Do not be alarmed if the prompt and rubric are in your folder.**


Now, we have to change the location in *run_autograder*. To do this, right click on *run_autograder* and open it with a text tool. On Macs, use TextEdit. To open TextEdit, right click on *run_autograder* and then click **open with** and click **other**. Once open, you should see the following:

\begin{center}
\frame{\includegraphics[width=5in]{pictures/exampl2.png} }
\end{center}

You will have to change the highlighted squares to the proper name. The highlighted squares (by color) should be:

green: The name the students are supposed to call their file. In the example, they are asked to call it "test.R".

purple: The name of the folder you are working in. In this case, it is PSExample. Change the name to "PSExample".

yellow: The name of the data generating process in the folder you are working in. In this case, it is "DGP.R".

blue: The name of the input template. In this case, it is called "inputs_PSExample.R".

red: The name of your autograder file. In this case, you were asked to name the autograder file "autograder_PSExample.R". Change "autograde_test.R" to "autograder_PSExample.R".

We are now done with the *run_autograder*. Save, commit, and push it. then return to the folder. In this example, it is *PSExample*.

Now enter *inputs_PSExample.R* Set the values according to the specifications:

```{#numCode .R .numberLines}
# user inputs: CHANGE THESE TO MATCH THE ASSIGNMENT
rScript   <- "test.R" # The name the student is supposed to give the file
data      <- "fakedata.csv" #Name of the CSV file
datatitle <- "fakedata" #What the student is supposed to call the datasource
parts     <- 2 # Number of problems being graded
Master    <- "Masterdata.csv" #The name of the master data file. This should be in folder
DGP       <- "DGP.R" # The data generating process for individual student's datasets. 
                     #The filename "DGP" should have one function titled "DGP".
```

Now, enter *autograde_PSExample.R*. Ensure that:

1) source file is set to working directory.

2) loc is set to "local".

3) line 11 is changed from "inputs_template.R" to "inputs_PSExample.R".

Run the whole R file. This will create two new datafiles: "fakedata.csv" and "results.json". "fakedata.csv" will be the unique dataset based off of student's PERMID number provided in the their submitted homework. In this case, it would be "test.R". If no such file is provided, the program will return "fakedata.csv" that is the same as MasterData.csv. This fakedata.csv is regenerated every time "autograde_PSExample.R" is run based off of the provided PERMID in the student's homework r file ("test.R"). Make sure to save, commit, and push.

Create an R file that is you solving the problem as if you were in the class. This part simply requires you to solve the homework. An example of this may look like:

```{#numCode .R .numberLines}

PERMID <- 1235

fakedata <- read.csv("fakedata.csv")

invoice.kansas <- sum(fakedata$State=="Kansas")

P1 <- sum(fakedata$Paid == "Yes")

```

You will be tweaking this file many times to make sure your autograder can handle all possible mistakes students will make.

Save, commit and push your work titled what the students will title their homework. In this example, it is "test.R". We will now return to the *autograder_PSExample.R*

### autograder_PSExample.R

- Open the *autograder_PSExample.R*.

- Run lines 1 through 17 If it does not run, make sure you set the working directory correctly. Check your global environment. You should see:

(1) student dataset (here it's fakedata.csv)

(2) test.results

(3) PERMID

(4) Student answers.

Of course, the autograder is simply reading your native test.R file right now! Now is the fun part. It's time to create the grader that grades. 

The grader that grades will live here:

```{#numCode .R .numberLines}
# ----- Put the Autograder Functions Here ----- #
    
 
    
# --------------------------------------------- #
```

You will write scripts that (i) get the right answers and then (ii) compare them to the student's answers. You will then fill in the *test.results* table as specified before.


\begin{center}
*REMINDER: Each student is assigned a different dataset, so there is no "universal right answer". P1 will be different for every student. That means your autograder must be script, NOT A HARD WIRED NUMBER.*
\end{center}

You will be provided a grading rubric for each homework assignment. It will look something like this:

******************************

$$\text{Problem Set Example Grading Rubric}$$
*Problem 1*

- Total number of points: 10
  
  - If correct: 10/10. else: 0/10

*Problem 2*

- Total number of points: 10
  
  - If correct: 10/10. else: 0/10

******************************


There are 101 different ways to write the autograders. One example for this homework assignment is:

```{#numCode .R .numberLines}
    # ----- Put the Autograder Functions Here ----- #
    answer.1 <-sum(fakedata$State=="Kansas")
    answer.2 <- sum(fakedata$Paid == "Yes")
    
    # Problem 1 score:
    p1.score <- if(is.error(invoice.kansas)==TRUE){ #checking to make sure they saved 
    #the name right
        test.results[1,] <- c("Problem 1: Kansas (10 pt.)", # Name of problem
                              0, # Student Score
                              10 , # Total Points
                              "invoice.kansas not found. 
                              Please ensure the variable is properly named" # Comment
                              )
    }else if(invoice.kansas==answer.1){
        test.results[1,] <- c("Problem 1: Kansas (10 pt.)", # Name of Problem
                              10, # Student Score
                              10, # Total Points
                              "nice work" # Comment
                              )
    }else{
        test.results[1,] <- c("Problem 1: Kansas (10 pt.)",
                              0,
                              10 ,
                              "Try Again")
    }
    
    p2.score <- if(is.error(P1==TRUE)){ #checking to make sure they saved the
    #name right
        test.results[2,] <- c("Problem 2: Invoice Completion (10 pt.)",
                              0,
                              10 ,
                              "P1 not found. Please ensure the 
                              variable is properly named")
    }else if(P1==answer.2){
        test.results[2,] <- c("Problem 2: Invoice Completion (10 pt.)",
                              10,
                              10 ,
                              "nice work")
    }else{
        test.results[2,] <- c("Problem 2: Invoice Completion (10 pt.)",
                              0,
                              10 ,
                              "Try Again")
    }
    
    # --------------------------------------------- #
```

*Pro tip: when naming your answers, choose a different name from the student names. Otherwise, you'll override their answers and it won't work :/*

### Diagnostics

There are some simple diagnostics that can be performed to check the autograder is performing optimally. Some of these are:

- In your toy homework assignment (test.R in the example), name the outputs by the wrong name. Instead of *P1*, call it *p1* or *potato* or whatever else.

- Experiment with rounding. Make sure a student won't get a 0 because they put 10.11 instead of 10.1. This can be avoided by rounding off the autograder values, or using the *almost.equal* command. To use this for part 1 with a .5 tolerance, you would write:

$$
\begin{aligned}
\text{almost.equal(answer.1, invoice.kansas, tolerance=.5)}
\end{aligned}
$$
The tolerance is saying that these two values are equal within .5 units.

When comparing dataframes, use the command ``all.equal()``. This command will return a true if the dataframes are identical.

Now that we have made our autograder, all that's left is uploading. Make sure to save, commit, and push.

### Make the Gradescope Input

In order to make the Gradescope input, we have to zip  the setup.sh and run_autograder together. To do this, simply highlight those two files and click "compress 2 items".

\begin{center}
\frame{\includegraphics[width=5in]{pictures/exampl3.png} }
\end{center}

Do not make a folder then zip the folder. That will NOT work in Gradescope. Highlight the 2 files and zip those together.

### Uploading to Gradescope

Put this zip into the *Select Autograder .zip* from steps in the Gradescope section. Then click "Update Autograder". This will take about 20 minutes to load. Make sure the Gradescope last update status keeps updating. 

\begin{center}
\frame{\includegraphics[width=8in]{pictures/exampl4.png} }
\end{center}

And now, we are done! You have uploaded an autograder to Gradescope. To check that it's working, try putting your fake assignment in and see what happens.

### Summary of steps:

1) Open RProject and press the blue arrow.

2) Put necessary files into homework folder.

3) Change autograder_run and setup.sh to right values.

4) Make a dummy homework R file. 

5) Open autograder_WHATEVERYOUNAMEDIT.R. Fill in the user inputs.

6) Write the autograder scripts in the prespecified part of autograder_WHATEVERYOUNAMEDIT.R.

7) Zip autograder_run and setup.sh together.

8) Upload to Gradescope.

9) Git push.

# Version Control

This section is dedicated to working in groups. Github can be an amazing tool and an even bigger headache. The key is to maximize the benefits and invest in aspirin. 

One way to mitigate the headaches is through a formalized version control approach. This manual recommends creating individual branches for each task. There are many resources discussing branching. One good place to start is [here](https://thenewstack.io/dont-mess-with-the-master-working-with-branches-in-git-and-github/).  A graphical example of this is depicted below:

\begin{center}
\frame{\includegraphics[width=5in]{pictures/github_flow.png} }
\end{center}

Notice at the center of the web is the master branch. Each pink square represents a different branch. Every time a new job needs to be done (e.g. a new homework assignment or tutorial), a new branch should be used. By having each project on it's own branch, there will be less of a chance of conflicts when uploading and pushing. In addition, this manual advocates **no one should be working directly on Master**. Actually, that should be a commandment:

$$\text{Github Commandment 3: Do Not Work Directly on Master Branch}$$
Making branches in R is extremely useful. First, make sure you are in the Rproject. Next, click the "create new branch" button. It is pointed out by the green arrow in the following picture:

\begin{center}
\frame{\includegraphics[width=5in]{pictures/branch.png} }
\end{center}

Name the branch. Notice the pink box that says *danny_testing* in the picture above? That should now be whatever you named your branch. You can click the name in the pink box and switch between branches with ease. However, be aware **YOU CAN SWITCH BETWEEN BRANCHES WITH EASE**. This means you need to be extra careful of which branch is selected.

When your work is finished on a branch, you can post a *pull request*. This is you proposing changes to Master in which the other TAs will review and approve. Pull requests can be made directly on Github:

\begin{center}
\frame{\includegraphics[width=5in]{pictures/pull_req.png} }
\end{center}

After clicking where the bright green arrow is pointing, click the bright green button that says **New pull request**.

In conclusion, the workflow will be as so:

1) You are given an assignment.

2) Create a new branch.

3) Do you work as described above. Do the normal push and pull and committing.

4) Once you are done with your assignment, submit a **new pull request**.

5) Have a friend confirm the pull request. If there are no conflicts, confirm your own pull request.

# Troubleshooting

Many things can break when working with Gradescope. There are some key issues that are bound to happen when working with Gradesope:

## Figuring out Filepaths

**run_autograder** relies heavily on using file paths. A good way to test if new filepaths work is in the terminal for Macs, and GitBash for PCs. Test the filepaths work locally before attempting to add them to **run_autograder**.

## Choosing the version of R

Ubuntu 18.04 will by default install R.3.4.4. If your class requires a more advanced version of R, you will have to call it in the **setup.sh** file. Figuring out the syntax for this file is very difficult without a background in computer science. The best way to learn is through a virtual machine (VM) on your own computer. A useful way to do this is with [Instant Ubuntu’s VMs](https://multipass.run/). This program will allow you to create instant VMs similar to the one used by Gradescope. They also have helpful [resources](https://ubuntu.com/server/docs/virtualization-multipass) for commands. This environment will allow you to troubleshoot **setup.sh** syntax. The best part about this is that VMs are independent of the rest of the computer: whatever you do in the VM won't affect anything out of the VM!

## When the Autograder Breaks

This is bound to happen. You upload the autograder and find out there's a mistake. Bummer! Because we're working through Github, all you have to do is edit your autograder and push it to Github. This is possible because the Gradescope virtual machine pulls the autograde_PSExample.R from github every time.

Common fixes to the autograder not working on Gradescope:

- Set the autograder_.r to "gradescope".

- Push the autograder to the github.

When in doubt, ask a fellow TA or a friend.

A useful resource is Michael Guerzhoy [github](https://github.com/guerzh/r_autograde_gradescope). He creates autograders for functions in R. Gradescope also has a list of useful links [here](https://gradescope-autograders.readthedocs.io/en/latest/resources/).

## Writing Questions

Because the autograder requires very specific inputs, it is very easy to write questions that are not condusive to grading code. These questions include too many parts or unclear objectives. Below is a fake assignment with poorly written questions for autograding code. This manual will go through each question, identify issues and provide suggestions to improve the question:

\begin{center}
\includepdf[pages=-,pagecommand={}, width=6in, frame=TRUE]{pictures/practice-assignment.pdf}
\end{center}

### Problem 1

- Notice that the students aren't told what to name their columns. This can lead to issues with reading the dataframe.

- The students aren't told if the dataframe should go up and down or left to right. The lack of clarity on the dimensionality can lead to issues.

- **Potential Solution**: Specify the number of columns and rows (if dataframes same) as well as the name of the columns.

### Problem 2

- There are multiple parts to the question.

- Each part isn't clearly labeled. The student's don't know what to  name the outcome of every problem.

- **Potential Solution**: Rewrite the question with subparts and clearly indicate what each part should be titled.

### Problem 3

- No issues. This is a very good problem for an autograder.

### Problem 4

- Same as problems 1 and 2. 

### Problem 5

- Is the answer the function or the results for *Jordyn Kang*? It is unclear from the writing. What should they label the output with *Jordyn Kang*?

- **Potential Solution**: Break the problem into two parts: one where they write the function and one where they save the answer for *Jordyn Kang* as jordyn_kang.


# Building Infrastructure

