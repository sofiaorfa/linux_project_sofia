#!/bin/bash
#Main purpose: Identify the files from the alignments folder that contain the same genes


# Read the paths from the YAML file using 'yq'
# Get the directory where grouped gene files will be stored
grouped_genes_dir=$(yq e '.paths.grouped_genes' linux.yaml)

# Get the directory containing the split alignment files
split_alignments_dir=$(yq e '.paths.split_alignments' linux.yaml)

# Make the grouped genes directory exists (create it if necessary)
mkdir -p "$grouped_genes_dir"

# Loop through each alignment file in the split alignments directory
for file in "$split_alignments_dir"/alignment_*.fa; do
    # Extract the gene ID from the first sequence header in the FASTA file
    # - Searches for lines starting with ">" (FASTA headers)
    # - Removes the ">" character
    # - Extracts the gene ID (everything before the first underscore "_")
    # - Sorts and keeps unique gene IDs (to handle multiple sequences per gene)
    gene_id=$(awk '/^>/ {print substr($1,2)}' "$file" | cut -d'_' -f1 | sort -u)
    
    # Create a directory for the gene if it doesn't exist
    mkdir -p "$grouped_genes_dir/$gene_id"
    
    # Copy the alignment file into the corresponding gene directory
    cp "$file" "$grouped_genes_dir/$gene_id/"
done

# Print a message indicating completion
echo "Gene grouping complete. The results are in '$grouped_genes_dir'."
