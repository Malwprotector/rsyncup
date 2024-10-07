#!/bin/bash

# Colors for formatting
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Check if figlet is installed, otherwise prompt to install it
if ! command -v figlet &> /dev/null; then
    echo -e "${RED}/!\ The 'figlet' command is required but not installed. Please install it using:${NC}"
    echo "sudo apt install figlet"
    exit 1
fi

# Display the title using figlet
figlet -c -f slant RSyncup
echo -e "${CYAN}\n                         *** Welcome to RSyncup! ***${NC}"
echo -e "RSyncup is a tool specially designed to allow you to have images of your\nimportant folders in other places. For example, you can regularly back up\nyour files from one hard drive to another, to reduce the risk of data loss.\nRSyncup supports both file modifications and deletions from the source\nharddisk, making it a good solution for backing up your files. RSyncbackup\nuses the rsync utility to operate."

# Function to list available drives and let the user choose one
function select_device() {
    echo -e "${YELLOW}\n                             *Available devices :*\n${NC}"
    lsblk -o NAME,SIZE,MOUNTPOINT | grep "/media"
    echo -e "${CYAN}\n! Please enter the path from the source device you want to backup\n(e.g., /media/username/device1): ${NC}"
    read -rp "Source path: " SOURCE

    if [ ! -d "$SOURCE" ]; then
        echo -e "${RED}/!\ Invalid source path! Exiting...${NC}"
        exit 1
    fi

    echo -e "${CYAN}\n! Please enter the path to the destination device where you want to save\nthe backup folder\n(e.g., /media/username/device2): ${NC}"
    read -rp "Destination path: " DESTINATION

    if [ ! -d "$DESTINATION" ]; then
        echo -e "${RED}/!\ Invalid destination path! Exiting...${NC}"
        exit 1
    fi
}

# Function to calculate total size of files to be transferred
function calculate_total_size() {
    TOTAL_SIZE=$(du -sb "$SOURCE" | awk '{print $1}')
    echo -e "${CYAN}Total size of data to back up: $(du -sh "$SOURCE" | awk '{print $1}')${NC}"
}

# Function to confirm the backup operation
function confirm_backup() {
    echo -e "${YELLOW}\n*** Summary of Backup Operation ***${NC}"
    echo -e "${CYAN}Source: $SOURCE${NC}"
    echo -e "${CYAN}Destination: $DESTINATION${NC}"
    echo -e "${CYAN}Total size to backup: $(du -sh "$SOURCE" | awk '{print $1}')${NC}"
    
    read -rp "Do you want to proceed with the backup? (y/n): " confirmation
    if [[ ! $confirmation =~ ^[Yy]$ ]]; then
        echo -e "${RED}/!\ Backup operation canceled.${NC}"
        exit 0
    fi
}

# Function to perform backup with a global progress bar
function perform_backup() {
    echo -e "${GREEN}Starting backup from $SOURCE to $DESTINATION...${NC}"

    # Backup with rsync and display a single progress bar for the entire operation
    rsync -a --delete --info=progress2 "$SOURCE" "$DESTINATION" | \
    pv -pte -s "$TOTAL_SIZE" > /dev/null
    # rsync options:
    # -a: Archive mode, preserving properties
    # --delete: Delete files in the destination that are not in the source
    # --info=progress2: Shows total progress during rsync

    if [ $? -eq 0 ]; then
        echo -e "${GREEN}\n                         ***Backup completed successfully!***\n\nGoodbye and have a nice day!${NC}"
    else
        echo -e "${RED}/!\ Backup failed! Check the paths and permissions.${NC}"
        exit 1
    fi
}

# Check if pv command is installed
if ! command -v pv &> /dev/null; then
    echo -e "${RED}/!\ The 'pv' command is required but not installed. Please install it using:${NC}"
    echo "sudo apt install pv"
    exit 1
fi

# Run the functions
select_device
calculate_total_size
confirm_backup
perform_backup
