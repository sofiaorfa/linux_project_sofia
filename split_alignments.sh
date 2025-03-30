#!/bin/bash

# Read the input file and paths from the YAML file
input_file=$(yq e '.data.input_file' linux.yaml)
split_alignments=$(yq e '.paths.split_alignments' linux.yaml)


mkdir -p "$split_alignments_dir"

# Extract the first 500 alignments
awk -v out_dir="$split_alignments" -v max_alignments=500 '
    BEGIN { RS=""; count=0 } 
    count < max_alignments {
        count++;
        filename = out_dir "/alignment_" count ".fa";
        print $0 > filename;
    }
' "$input_file"

echo "The alignments are in the $split_alignments directory."
