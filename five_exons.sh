#!/bin/bash

# Read the paths from the YAML file
rf_distances_file=$(yq e '.paths.rf_distances' linux.yaml)
exons_output_file=$(yq e '.paths.exons_output_file' linux.yaml)

# Sort the RF distances file and get the top 5 smallest
sorted_files=$(sort -k2,2n "$rf_distances_file" | head -n 5 | awk '{print $1}' | sed 's/^RF_//')


for file in $sorted_files; do
    exon=$(grep -oP '_\d+_\d+' "$file" | head -n 1 | sed 's/^_//')
    if [ -n "$exon" ]; then
        echo "$exon" >> "$exons_output_file"
    fi
done

echo "Exons have been saved to $exons_output_file."
