#!/bin/bash
#Main purpose of the script: Compare each one of the  alignment trees with the merged alignment tree and calculate the RF distance 

# Read the paths from the YAML file using 'yq'
# Extracts the directory path for RF distances and assigns it to 'rf_distances'
rf_distances=$(yq e '.paths.rf_distances' linux.yaml)

# Extracts the merged sequence file path and appends '.treefile' to form the full filename
merged_tree_file=$(yq e '.paths.merged_sequences' linux.yaml).treefile

# Loop through each tree file in the RF distances directory
for file in "$rf_distances"/*.treefile; do
    # Run the R script to compare the merged tree with the current gene tree
    # Append the output (RF distance) to the rf_distances file
    Rscript compare_trees.R "$merged_tree_file" "$file" >> "$rf_distances"
done

# Print a message indicating the process is complete
echo "Tree comparison complete. RF distances saved to $rf_distances."
