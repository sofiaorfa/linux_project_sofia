#!/bin/bash

# Read the paths and tool configurations from the YAML file
concatenated_genes_dir=$(yq e '.paths.concatenated_genes' linux.yaml)
gene_trees_dir=$(yq e '.paths.gene_trees' linux.yaml)
iqtree2=$(yq e '.tools.iqtree2' linux.yaml)

mkdir -p "$gene_trees_dir"

# Loop over concatenated gene files and construct gene phylogenetic trees
for gene_file in "$concatenated_genes_dir"/*.fa; do
    gene_name=$(basename "$gene_file" .fa)
    "$iqtree2" -s "$gene_file" -m MFP -bb 1000 -nt AUTO -pre "$gene_trees_dir/$gene_name"
done

echo "All gene trees have been created in $gene_trees_dir."
