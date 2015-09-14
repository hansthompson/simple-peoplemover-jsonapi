devtools::install_github("trestletech/plumber")
library(plumber)
r <- plumb("/home/ht/Desktop/git/simple-peoplemover-jsonapi/my_file.R") 
r$run(port=8000)
