#!/bin/bash

# Ask for permission to pull data
read -p "Do you want to pull data from $2 to $1" check
# Pull data
if [ $check == "YES" || $check == "yes" ]
then
    ./pull_data.sh
else
    echo "Continue..."
fi

# Check if source and destination paths are provided as arguments
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <source_path> <destination_path>"
    exit 1
fi

source_dir="$1"
destination_dir="$2"

# Check if source directory exists
if [ ! -d "$source_dir" ]; then
    echo "Error: Source directory '$source_dir' does not exist."
    exit 1
fi

# Check if destination directory exists
if [ ! -d "$destination_dir" ]; then
    echo "Error: Destination directory '$destination_dir' does not exist."
    exit 1
fi

# Check if application data folders exist in destination directory
# Loop through each application folder
for app_folder in "$destination_dir"/*; do
    # Check if it's a directory
    if [ -d "$app_folder" ]; then
        app_name=$(basename "$app_folder")
        echo "Checking for data of application: $app_name"
        if [ ! -d "$source_dir/$app_name" ]; then
            # Copy application data from parent folder to its child folder
            echo "Copying data of $app_name from parent folder to its child folder..."
            cp -r "$app_folder"/* "$app_name"
            echo "Data fetched for $app_name."
        else
            ./apps.ps1
        fi
    fi
done

echo "Data fetch completed."
