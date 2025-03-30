#!/bin/bash

# Read the paths from the YAML file
rf_gene_distances_file=$(yq e '.paths.rf_gene_distances' linux.yaml)
smallest_rf_file=$(yq e '.paths.smallest_rf_file' linux.yaml)
largest_rf_file=$(yq e '.paths.largest_rf_file' linux.yaml)

# Sort and find the smallest and largest RF distances
sort -k2 -n "$rf_gene_distances_file" | head -n 5 > "$smallest_rf_file"
sort -k2 -n "$rf_gene_distances_file" | tail -n 5 > "$largest_rf_file"

echo "Smallest and largest RF distances have been saved."

