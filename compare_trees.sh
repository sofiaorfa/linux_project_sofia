#!/bin/bash

# Read the paths from the YAML file
rf_distances=$(yq e '.paths.rf_distances' linux.yaml)
merged_tree_file=$(yq e '.paths.merged_sequences' linux.yaml).treefile

# Compare each of the gene trees with the merged tree
for file in "$rf_distances"/*.treefile; do
    Rscript compare_trees.R "$merged_tree_file" "$file" >> "$rf_distances"
done

echo "Tree comparison complete. RF distances saved to $rf_distances."
