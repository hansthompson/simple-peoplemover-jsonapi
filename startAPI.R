#devtools::install_github("trestletech/plumber")
library(plumber)
r <- plumb("/home/hans/simple-peoplemover-jsonapi/my_file.R") 
r$run(port=8001	)
