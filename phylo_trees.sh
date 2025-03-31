#!/bin/bash
#Main purpose: Create the phylogenetic trees for each alignment I seperated before

# Extract paths from the YAML configuration file using 'yq'
# Get the directory containing split alignments
split_alignments=$(yq e '.paths.split_alignments' linux.yaml)

# Get the directory where phylogenetic trees will be stored
phylogenetic_trees=$(yq e '.paths.phylogenetic_trees' linux.yaml)

# Get the path to the IQ-TREE2 executable
iqtree2=$(yq e '.tools.iqtree2' linux.yaml)

# Make the output directory for phylogenetic trees exists
mkdir -p "$phylogenetic_trees"

# Loop through each FASTA alignment file in the split alignments directory
for FILE in "$split_alignments"/*.fa; do
    # Extract the base name of the file (without the .fa extension)
    NAME=$(basename "$FILE" .fa)
    
    # Run IQ-TREE2 to construct a phylogenetic tree
    # -s: Specifies the input alignment file
    # -nt AUTO: Automatically determines the number of threads to use
    # -bb 1000: Performs 1000 ultrafast bootstrap replicates for support values
    # -bnni: Optimizes bootstrap trees 
    "$iqtree2" -s "$FILE" -nt AUTO -bb 1000 -bnni "$phylogenetic_trees/$NAME"
done

# Print a message when finished
echo "All phylogenetic trees have been created in $phylogenetic_trees"
