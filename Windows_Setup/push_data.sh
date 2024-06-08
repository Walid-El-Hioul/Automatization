#!/bin/bash

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

# Loop through each application
for app_folder in "$destination_dir"/*; do
    # Check if it's a directory
    if [ -d "$app_folder" ]; then
        app_name=$(basename "$app_folder")
        if [ -d "$app_name" ]; then
            # Copy application data to destination application folder
            echo "Copying data of $app_name folder to destination application folder..."
            cp -r "$source_dir"/"$app_folder" "$destination_dir"
            echo "Data fetched for $app_name."
        else
            echo "Data for $app_name doesn't exists in "$destination_dir" directory."
        fi
    fi
done

echo "Data fetch completed."
