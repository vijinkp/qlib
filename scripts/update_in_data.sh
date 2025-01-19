#!/bin/bash

# Check if the required arguments are provided
if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage: $0 <root_directory> <qlib_data_directory>"
    exit 1
fi

# Assign arguments to variables
root_dir="$1"
qlib_data_dir="$2"

# Get the current date in YYYY-MM-DD format
current_date=$(date +%Y-%m-%d)

# Create the root directory with the format 'run_<date>'
run_dir="$root_dir/run_${current_date}"
mkdir -p "$run_dir/raw" "$run_dir/normalized"

# Get absolute paths for the directories
raw_dir=$(realpath "$run_dir/raw")
normalized_dir=$(realpath "$run_dir/normalized")

# Path to the Python script
python_script="scripts/data_collector/yahoo/collector.py"

# Execute the Python script with the required arguments
python "$python_script" update_data_to_bin --source_dir "$raw_dir" \
                        --normalize_dir "$normalized_dir" \
                        --qlib_data_1d_dir "$qlib_data_dir" \
                        --end_date "$current_date" \
                        --region IN
