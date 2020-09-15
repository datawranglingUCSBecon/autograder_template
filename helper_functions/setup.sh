#!/usr/bin/env bash


# This is installing R 3.6.3
apt-get install -y libxml2-dev libcurl4-openssl-dev libssl-dev libudunits2-dev
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran35/'
apt update
apt-get install -y r-base

# These are all the packages being used. Make sure you have all the necessary packages
  # If Gradescope is running slow, consider using less packages
  # Make sure to keep your dependencies=TRUE otherwise things break :/ 
Rscript -e "install.packages('berryFunctions', dependencies = TRUE)"
Rscript -e "install.packages('choroplethr', dependencies = TRUE)"
Rscript -e "install.packages('choroplethrMaps', dependencies = TRUE)"
Rscript -e "install.packages('compare', dependencies = TRUE)"
Rscript -e "install.packages('devtools', dependencies = TRUE)"
Rscript -e "install.packages('here', dependencies = TRUE)"
Rscript -e "install.packages('jsonlite', dependencies = TRUE)"
Rscript -e "install.packages('janitor', dependencies = TRUE)"
Rscript -e "install.packages('kableExtra', dependencies = TRUE)"
Rscript -e "install.packages('lucid', dependencies = TRUE)"
Rscript -e "install.packages('lubridate', dependencies = TRUE)"
Rscript -e "install.packages('magrittr', dependencies = TRUE)"
Rscript -e "install.packages('nycflights13', dependencies = TRUE)"
Rscript -e "install.packages('purrr', dependencies = TRUE)"
Rscript -e "install.packages('readr', dependencies = TRUE)"
Rscript -e "install.packages('summarytools', dependencies = TRUE)"
Rscript -e "install.packages('stringr', dependencies = TRUE)"
Rscript -e "install.packages('tidyverse', dependencies = TRUE)"
Rscript -e "install.packages('textclean', dependencies = TRUE)"