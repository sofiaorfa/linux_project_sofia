#!/bin/bash
#Main purpose:Define the five exons with the minimum RF distance

# Read the paths from the YAML file using 'yq'
# Get the path of the RF distances file
rf_distances_file=$(yq e '.paths.rf_distances' linux.yaml)

# Get the output file path for storing the selected exons
exons_output_file=$(yq e '.paths.exons_output_file' linux.yaml)

# Sort the RF distances file numerically by the second column
# Extract the top 5 smallest values
# Retrieve only the first column (file names) and remove the 'RF_' prefix
sorted_files=$(sort -k2,2n "$rf_distances_file" | head -n 5 | awk '{print $1}' | sed 's/^RF_//')

# Loop through each of the selected files
for file in $sorted_files; do
    # Extract the exon identifier from the filename (pattern: _number_number)
    exon=$(grep -oP '_\d+_\d+' "$file" | head -n 1 | sed 's/^_//')
    
    # If an exon identifier was found, append it to the output file
    if [ -n "$exon" ]; then
        echo "$exon" >> "$exons_output_file"
    fi
done

# Print a completion message
echo "Exons have been saved to $exons_output_file."
