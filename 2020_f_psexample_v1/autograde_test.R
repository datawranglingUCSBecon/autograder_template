#list=ls())
#("~")

PERMID         <- 12

fakedata       <- read.csv("fakedata.csv")

invoice.kansas <- 11 #sum(fakedata$State=="Kansas")

P1             <- sum(fakedata$Paid == "Yes")


