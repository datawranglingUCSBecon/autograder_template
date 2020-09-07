# Introduction

This repository hosts the source code for Gradescope autograders in R.  Gradescope is a 3rd party software designed to help universities grade assignments. One of their features is autograding code. Autograding code is, as expected, difficult. The process requires a basic knowledge of Github, filetypes, and dockers. Many social scientist have expert knowledge within specific coding languages but lack the foundations needed to properly write autograders. This repository was created for instructors and TAs teaching a class in R utilizing Gradescope's autograder functionality. Specifically, it was created for Econ 145: Data Wrangling for Economists. 

The main contribution of this repository is a structure and host of helper functions that allow R proficient faculty and TAs to write autograders for Gradescope. The repository is designed for someone who is proficient in R but has virtually no knowledge of other aspects of coding. Using this autograder does NOT require previous knowledge of filetypes (bash, .JSON, etc.) or knowledge of working in the terminal.

Users are expected to know:

1) How to code in R proficiently. This means writing loops, sourcing other files, and using very, very basic directory tools.

2) A very basic knowledge of Github. As more people work on the repository, a user's Github prowess must develop. However, this is not a prerequisite.

The general structure of the github, along with the functions written, can be expanded to any coding course. The infrastructure is meant to make Gradescope's autograders easier to implement.

An immediate question is: 
> Why use Github with Gradescope? I can just upload autograders to Gradescope!

While you can directly upload autograders to Gradescope without using Github, the debugging process is extremely painful. Every time a new autograder is uploaded to Gradescope, it builds a container image used for each student submission. Building these containers can take anywhere between 10-20 minutes. This means that the debugging stages will take 10-20 minutes to determine if your attempt at fixing your code worked. This is not a sustainable way to write autograders. This is a sustainable way to lose hair. Howevever, once the container is built, it's built. This repository has code in place that builds an image that takes the autograder code directly from Github. Whenever the Github code is updated, the autograder updates. Debuggers have now gone from 10-20 minutes in between attempts at fixing code to 10-20 seconds!

# First Thing's First

After completing this README.md, the **First** thing to do is to read the [manual](manuals/autograder_ta/00-manual1.pdf). The manual is located in `manual -> autograder_ta -> 00-manual1.pdf`. The manual exhaustively goes through each each line of each script. It also explains the basic underworkings of Gradescope that will be helpful for future debugging. Finally, it provides examples of homework assignments with a walkthrough of creating autograders and general advice.

# The Organization of the Class - Naming Conventions

The Github is organized for many years and many iterations of the class. The following naming convention is adopted:

- each homework folder is named `year_quarter_assignment_version#`. For example, version 1 of homework 1 of fall quarter in 2020 is named `2020_f_hw1_v1`. Lectures will be placed into one folder following the same naming convention (see `2020_f_lectures_v1`).

The only folders that should not follow this naming convention are:

1) `hw_template`

2) `manuals`

3) `helper_functions`

4) `class_roster`

## `hw_template`

This folder holds all the direct files for the autograder. When a new homework assignment is announced, the first step is to copy `hw_template` and rename the folder the name of the homework assignment. Then the TAs will work almost exclusively within this folder to create working autograders. More so, they will be able to work only in R files (except one step).

## `manuals`

`manuals` holds the manuals. The main manual of interest is `manual.pdf`. This goes through all the steps of the autograder. However, there are additional manuals related to other aspects of the course such as Nectir and using a virtual machine at UCSB. See the README.md in the folder for more information.


## `helper_functions`

`helper_functions` streamline alot of the Gradescope technicalities. These functions are meant to make writing autograders accessible to any individual who has proficient knowledge of R (and patience). As before, see the manual for an exhaustive discussion of the functions.

Gradescope requires output to be in a very specific JSON format. With this repository, there is no need to know what exactly this format is. The R helper functions create the output in the proper format. Under the hood, the helper functions are creating a dataframe that the TA is meant to fill in. Once they fill in the dataframe, the helper functions convert it to the appropriate .JSON format and export it in the appropriate location.

There is also `email.R`. This is used to mass email students individual datasets. In order to cut down on cheating, this course creates unique datasets for each student to analyze. 

## `class roster`

`class_roster` will be used for the automatic emailing. Check out the folder for a brief discussion of the roster. Refer to the manual for an in depth discussion.

# The Basic Structure

The basic workflow of the repository stems from two folders: `hw_template`, `helper_functions`, and `class_roster`. Suppose you need to write an autograder for a new homework assignment. The process begins by duplicating `hw_template` and renaming the folder following the naming convention above. Then, see the [manual](manuals/autograder_ta/manual.pdf).

Github manager/creator: Danny Klinenberg (dklinenberg@ucsb.edu)
