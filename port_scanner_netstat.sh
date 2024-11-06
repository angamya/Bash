#!/bin/bash

#This script uses netstat to scan for open ports and identifies which services are running on the local machine.
#It’s useful to detect unnecessary open ports that could pose a security risk.

# Checking if the script is run as root (necessary for some netstat commands)
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root."
  exit
fi

echo "Scanning for open ports on the local machine..."

# Use netstat to list open TCP ports and the services listening on them: netstat --tcp --udp --listening --numeric, find "LISTEN"
netstat -tuln | grep LISTEN

echo ""
echo "Ports and services listening on this machine:"
echo "---------------------------------------------"

# Use netstat and awk to list open ports and associated services
netstat -tuln | grep LISTEN | awk '{print "Port: " $4 " | Service: " $1}'

echo ""
echo "Script execution completed."
