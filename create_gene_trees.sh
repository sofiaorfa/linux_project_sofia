#!/bin/bash
#Main purpose:Create the trees for each gene

# Read the paths and tool configurations from the YAML file using 'yq'
# Get the directory containing concatenated gene sequences
concatenated_genes_dir=$(yq e '.paths.concatenated_genes' linux.yaml)

# Get the directory where the resulting gene trees will be stored
gene_trees_dir=$(yq e '.paths.gene_trees' linux.yaml)

# Get the path to the IQ-TREE2 executable
iqtree2=$(yq e '.tools.iqtree2' linux.yaml)

# Ensure the gene trees directory exists (create it if necessary)
mkdir -p "$gene_trees_dir"

# Loop through each concatenated gene sequence file
for gene_file in "$concatenated_genes_dir"/*.fa; do
    # Extract the gene name from the file name (remove the .fa extension)
    gene_name=$(basename "$gene_file" .fa)

    # Run IQ-TREE2 to construct the gene phylogenetic tree
    # -s: Specifies the input sequence file
    # -bb 1000: Performs 1000 ultrafast bootstrap replicates for support values
    # -nt AUTO: Automatically determines the number of CPU threads to use

    "$iqtree2" -s "$gene_file" -bb 1000 -nt AUTO "$gene_trees_dir/$gene_name"
done

# Print a message indicating completion
echo "All gene trees have been created in $gene_trees_dir."
