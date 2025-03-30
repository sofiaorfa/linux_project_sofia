#!/bin/bash

# Read the path from the YAML file
grouped_genes_dir=$(yq e '.paths.grouped_genes' linux.yaml)
split_alignments_dir=$(yq e '.paths.split_alignments' linux.yaml)

mkdir -p "$grouped_genes_dir"

# Group by gene
for file in "$split_alignments_dir"/alignment_*.fa; do
    gene_id=$(awk '/^>/ {print substr($1,2)}' "$file" | cut -d'_' -f1 | sort -u)
    mkdir -p "$grouped_genes_dir/$gene_id"
    cp "$file" "$grouped_genes_dir/$gene_id/"
done

echo "Gene grouping complete.The results are in the '$grouped_genes_dir'"
