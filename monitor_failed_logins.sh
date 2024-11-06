#This script monitors the system's authentication log (/var/log/auth.log on most Linux systems) for failed login attempts.
#It counts the number of failed attempts and displays a list of IP addresses that attempted to log in.


#!/bin/bash

# Check if the script is run as root (necessary to access log files)
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root."
  exit
fi

# Specify the log file for monitoring failed login attempts
LOG_FILE="/var/log/auth.log"

# Check if the log file exists
if [ ! -f "$LOG_FILE" ]; then
  echo "Log file not found!"
  exit
fi

# Display the number of failed login attempts
echo "Counting failed login attempts..."
FAILED_ATTEMPTS=$(grep "Failed password" $LOG_FILE | wc -l)
echo "Total Failed Login Attempts: $FAILED_ATTEMPTS"

# Extract IP addresses of failed attempts and display the top offending IPs
echo "Top IPs with failed login attempts:"
grep "Failed password" $LOG_FILE | awk '{print $(NF-3)}' | sort | uniq -c | sort -nr | head -10

# Optional: block IPs with too many failed attempts (e.g., >10 attempts)
echo "Blocking IPs with more than 10 failed attempts..."
grep "Failed password" $LOG_FILE | awk '{print $(NF-3)}' | sort | uniq -c | awk '$1 > 10 {print $2}' | while read ip; do
  echo "Blocking $ip"
  iptables -A INPUT -s $ip -j DROP
done

echo "Script execution completed."

