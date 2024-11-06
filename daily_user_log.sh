#!/bin/bash

#This scrip daily_user_log.sh create every day after midnight file .txt with the users who are logged into the system at the time the script runs.
#This runs automatically every day after midnight based on the cron."


# Define the directory where the log files will be stored
LOG_DIR="./log/"


# Get the current date in YYYY-MM-DD format
CURRENT_DATE=$(date +"%Y-%m-%d")

# Define the output file with the current date in title
OUTPUT_FILE="${LOG_DIR}/${CURRENT_DATE}_logins.txt"

#create the log directory  if it doesn't exist
mkdir -p "$LOG_DIR"

#get the list of users currently logged in and save it to the file
whoami > "$OUTPUT_FILE"




# We schedule the script to run after midnight using /cron/.
# 1. Open the crontab editor by running: crontab -e
# 2. Add this line to the crontab file to schedule the script to run daily at 12:01 AM: 1 0 * * * /path/to/daily_user_log.sh
# Above means that the script will run every day at 00:01 (12:01 AM), right after midnight.



