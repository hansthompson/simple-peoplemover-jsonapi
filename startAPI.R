library(plumber)
r <- plumb("my_file.R") 
r$run(port=8000)