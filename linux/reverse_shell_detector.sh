#!/bin/bash

# Define parameters
ExcludedProcesses=("sshd" "httpd" "nginx")


# Define ANSI escape sequences for green color
Green='\033[0;32m'
ResetColor='\033[0m'

# Function to detect reverse shell
DetectReverseShell() {
    netstat -ntp | grep ESTABLISHED | while read line; do
        remotePort=$(echo "$line" | awk '{print $5}' | cut -d ':' -f2)
        remoteIP=$(echo "$line" | awk '{print $5}' | cut -d ':' -f1)
        processId=$(echo "$line" | awk '{print $7}' | cut -d '/' -f1)
        processName=$(ps -p $processId -o comm= 2>/dev/null)
        if [ -z "$processName" ]; then
            processName="(Unknown)"
        fi
        echo -e "${Green}Connection detected to $remoteIP on port $remotePort${ResetColor}"
        echo -e "${Green}Process ID: $processId${ResetColor}"
        echo -e "${Green}Process Name: $processName${ResetColor}"
        echo -e "${Green}-----------------------------------------${ResetColor}"
        if [[ ! " ${ExcludedProcesses[@]} " =~ " $processName " ]]; then
            if [[ $remoteIP =~ ^127\.|^10\.|^192\.168\.|^::1|^localhost$ ]]; then
                echo -e "${Green}Suspicious connection detected from a private IP or localhost.${ResetColor}"
                echo -e "${Green}!!! Possible Reverse Shell Detected !!!${ResetColor}"
            else
                echo -e "${Green}Connection from public IP.${ResetColor}"
            fi
        fi
    done
}

# Function to kill a process by ID
KillProcessById() {
    read -p "${Green}Enter the Process ID to kill: ${ResetColor}" process_id
    if [ -n "$process_id" ]; then
        kill -9 "$process_id" 2>/dev/null
        if [ $? -eq 0 ]; then
            echo -e "${Green}Process with ID $process_id killed successfully.${ResetColor}"
        else
            echo -e "${Green}Failed to kill process with ID $process_id.${ResetColor}"
        fi
    else
        echo -e "${Green}Process ID cannot be empty.${ResetColor}"
    fi
}

# Function to display the menu
ShowMenu() {
    echo -e "${Green}Welcome to Reverse Shell Detector${ResetColor}"
    echo -e "${Green}1. Detect Reverse Shell${ResetColor}"
    echo -e "${Green}2. Kill Process${ResetColor}"
    echo -e "${Green}3. Exit${ResetColor}"

    read -p "${Green}Select an action (1, 2, or 3): ${ResetColor}" choice

    case $choice in
        1) DetectReverseShell
           ShowMenu ;;
        2) KillProcessById
           ShowMenu ;;
        3) echo -e "${Green}Exiting...${ResetColor}"
           exit ;;
        *) echo -e "${Green}Invalid choice. Please select again.${ResetColor}"
           ShowMenu ;;
    esac
}

# Show the menu
ShowMenu
