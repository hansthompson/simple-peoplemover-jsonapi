Requistes:
R, ubuntu, cron, and the R packages in the R files

1. Clone the repository
2. Change the full file paths in pull_realtime for loading stops.rda and writing the binary file with the data for the api. 
3. start cron
```
crontab -e 
```
write out the cron task to pull each minute
``` 
* * * * * Rscript full/path/to/pull_realtime.R

4. Edit my_file.R to load in the data created from pull_realtime.R

5. run startAPI.R

6. hit localhost:3000