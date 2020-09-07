rm(list=ls())

PERMID         <- 1212

fakedata       <- read.csv("fakedata.csv")

# Problem 1

invoice.kansas <- 11 #sum(fakedata$State=="Kansas")

# Problem 2

P1             <- sum(fakedata$Paid == "Yes")


