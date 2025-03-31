#!/bin/bash  # Specify the shell to use for this script
#Main purpose of the  script : Seperate the first 500 alignments of the knownCanonical file in a new folder





# Read the input file and paths from the YAML file
input_file=$(yq e '.data.input_file' linux.yaml)  # Extract 'input_file' from linux.yaml and store it in the 'input_file' variable
split_alignments=$(yq e '.paths.split_alignments' linux.yaml)  # Extract 'split_alignments' from linux.yaml and store it in the 'split_alignments' variable


## Create the directory for split alignments
mkdir -p "$split_alignments"  # Create the directory for split alignments, if it doesn't already exist

# Extract the first 500 alignments and save them as separate files
awk -v out_dir="$split_alignments" -v max_alignments=500 '  # Start an awk command, passing 'out_dir' and 'max_alignments' as variables
    BEGIN { RS=""; count=0 }  # Initialize record separator as blank lines (so 'awk' treats each alignment as a record), and initialize count
    count < max_alignments {  # Loop until 'count' reaches 'max_alignments' (500)
        count++;  # Increase the 'count' by 1 for each alignment processed
        filename = out_dir "/alignment_" count ".fa";  # Create a filename for each alignment (e.g., alignment_1.fa, alignment_2.fa)
        print $0 > filename;  # Print the current alignment to the corresponding file
    }
' "$input_file"  # Specify the input file to process with awk

echo "The alignments are in the $split_alignments directory."  # Output a message indicating where the alignments were saved



