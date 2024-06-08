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
if [ -d "$destination_dir" ]; then
    # Copy application data folders from source to destination
    echo "Copying application data folders from $source_dir to $destination_dir..."
    cp -r "$source_dir"/* "$destination_dir"
else
    echo "$destination_dir doesn't exist"
fi
>>>>>>> origin/test

echo "Data pulled successfully."
