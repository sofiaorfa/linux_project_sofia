#!/bin/bash

# Read the paths from the YAML file
rf_gene_distances_file=$(yq e '.paths.rf_gene_distances' linux.yaml)
merged_tree_file=$(yq e '.paths.merged_sequences' linux.yaml).treefile
gene_trees_dir=$(yq e '.paths.gene_trees' linux.yaml)

# Compare each gene tree with the merged tree
for file in "$gene_trees_dir"/*.treefile; do
    Rscript compare_trees.R "$merged_tree_file" "$file" >> "$rf_gene_distances_file"
done

echo "Gene tree comparison complete. RF distances saved to $rf_gene_distances_file."
