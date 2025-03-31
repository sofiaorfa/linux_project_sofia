#!/bin/bash
#Concatenate the sequences for each gene for the same organism

# Read the paths from the YAML file using 'yq'
# Get the directory containing grouped gene sequences
grouped_genes_dir=$(yq e '.paths.grouped_genes' linux.yaml)

# Get the directory where concatenated gene sequences will be stored
concatenated_genes_dir=$(yq e '.paths.concatenated_genes' linux.yaml)

# Make the concatenated genes directory exists (create it if necessary)
mkdir -p "$concatenated_genes_dir"

# Loop through each gene folder in the grouped genes directory
for gene_folder in "$grouped_genes_dir"/*; do
    # Extract the gene name from the folder name
    gene=$(basename "$gene_folder")

    # Define the output file for the concatenated sequences
    output_file="$concatenated_genes_dir/$gene.fa"

    # Clear the output file if it already exists
    > "$output_file"

    # Declare an associative array to store sequences by organism
    declare -A sequences

    # Process each exon file (FASTA format) within the gene folder
    for file in "$gene_folder"/*.fa; do
        while read -r line; do
            if [[ $line == ">"* ]]; then
                # Identify the sequence header (FASTA format)
                header="$line"
                # Extract the organism ID (assuming it's the second field separated by '_')
                organism=$(echo "$header" | cut -d'_' -f2)
            else
                # Append the sequence data to the corresponding organism entry in the array
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

# Print a message indicating completion
echo "Gene sequences have been concatenated and saved to $concatenated_genes_dir."
