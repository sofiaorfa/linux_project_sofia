#!/bin/bash

# Read the paths from the YAML file
grouped_genes_dir=$(yq e '.paths.grouped_genes' linux.yaml)
concatenated_genes_dir=$(yq e '.paths.concatenated_genes' linux.yaml)

mkdir -p "$concatenated_genes_dir"

# Loop through each gene folder and concatenate the sequences
for gene_folder in "$grouped_genes_dir"/*; do
    gene=$(basename "$gene_folder")
    output_file="$concatenated_genes_dir/$gene.fa"
    > "$output_file"  # Clear the file if it exists

    declare -A sequences

    # Process each exon file within the gene folder
    for file in "$gene_folder"/*.fa; do
        while read -r line; do
            if [[ $line == ">"* ]]; then
                header="$line"
                organism=$(echo "$header" | cut -d'_' -f2)
            else
                sequences["$organism"]+="$line"
            fi
        done < "$file"
    done

    # Write concatenated sequences to the output file
    for org in "${!sequences[@]}"; do
        echo ">$gene_$org" >> "$output_file"
        echo "${sequences[$org]}" >> "$output_file"
    done
done

echo "Gene sequences have been concatenated and saved to $concatenated_genes_dir."
