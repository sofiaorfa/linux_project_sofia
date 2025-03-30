#!/bin/bash

# Paths from the YAML file
split_alignments=$(yq e '.paths.split_alignments' linux.yaml)
phylogenetic_trees=$(yq e '.paths.phylogenetic_trees' linux.yaml)
iqtree2=$(yq e '.tools.iqtree2' linux.yaml)

mkdir -p "$phylogenetic_trees"

# Construct phylogenetic trees for the alignments
for FILE in "$split_alignments"/*.fa; do
    NAME=$(basename "$FILE" .fa)
    "$iqtree2" -s "$FILE" -nt AUTO -bb 1000 -bnni -pre "$phylogenetic_trees/$NAME"
done

echo "All phylogenetic trees have been created in $phylogenetic_trees"
