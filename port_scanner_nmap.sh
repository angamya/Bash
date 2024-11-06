#!/bin/bash


#This script uses nmap to scan a range of ports on a given IP address or domain name and outputs the results to a .txt file.


# Checking if nmap is installed
if ! command -v nmap &> /dev/null
then
    echo "nmap is not installed. Please install it and try again."
    exit
fi

# Prompt the user for a target (IP address or domain)
read -p "Enter target IP address or domain: " target

# Prompt the user for a port range (optional)
read -p "Enter port range to scan (e.g., 1-1000 or leave blank for default): " ports

#Define the directory where the log files will be stored
LOG_DIR="./log_nmap/"


# Set the current date for log file naming
timestamp=$(date +"%Y-%m-%d_%H-%M-%S")

# Set the output file for results
output_file="$LOG_DIR/scan_result_$timestamp.txt"

#create the log directory  if it doesn't exist
mkdir -p "$LOG_DIR"

# If no port range is provided, scan common ports by default
if [ -z "$ports" ]
then
    ports="1-65535"  # Default to scanning all ports if no range is specified
fi

# Start the port scan using nmap and save the results to a file
echo "Starting scan on $target for ports $ports..."
nmap -p $ports $target -oN $output_file

# Output the result location
echo "Scan completed. Results saved in $output_file."

