rm(list=ls())

PERMID         <- 1212

fakedata       <- read.csv("fakedata.csv")

# Problem 1

fakedata %>%
  select(everything()) %>%  # replace to your needs
  summarise_all(funs(sum(is.na(.))))

# Problem 2

P1             <- sum(fakedata$Paid == "Yes")


