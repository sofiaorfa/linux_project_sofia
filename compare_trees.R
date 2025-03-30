#!/usr/bin/env Rscript

# Load necessary library
if (!requireNamespace("ape", quietly = TRUE)) {
  install.packages("ape", repos = "https://cloud.r-project.org/")
}

library(ape)

# Function to extract labels between underscores
extract_label <- function(label) {
  match <- regmatches(label, regexpr("_(.*?)_", label))
  if (length(match) > 0) {
    return(gsub("_", "", match))  # Remove underscores from the extracted part
  } else {
    return(label)  # Return original label if no match
  }
}

# Function to display usage
usage <- function() {
  cat("Usage: compare_trees.R <tree_file1> <tree_file2>\n", file=stderr())
  quit(save = "no", status = 1)
}

# Check for command-line arguments
args <- commandArgs(trailingOnly = TRUE)
if (length(args) != 2) {
  usage()
}

# Read tree files from command-line arguments
tree_file1 <- args[1]
tree_file2 <- args[2]

# Read the trees
tree1 <- tryCatch(read.tree(tree_file1), error = function(e) {
  cat("Error reading tree file 1:", e$message, "\n", file=stderr())
  quit(save = "no", status = 1)
})

tree2 <- tryCatch(read.tree(tree_file2), error = function(e) {
  cat("Error reading tree file 2:", e$message, "\n", file=stderr())
  quit(save = "no", status = 1)
})

# Clean tip labels
tree1$tip.label <- sapply(tree1$tip.label, extract_label)
tree2$tip.label <- sapply(tree2$tip.label, extract_label)

# Find common taxa
common_tips <- intersect(tree1$tip.label, tree2$tip.label)

# Drop non-matching taxa
tree1 <- drop.tip(tree1, setdiff(tree1$tip.label, common_tips))
tree2 <- drop.tip(tree2, setdiff(tree2$tip.label, common_tips))

# Ensure there are enough matching taxa
if (length(tree1$tip.label) < 2 || length(tree2$tip.label) < 2) {
  cat("⚠️ Warning: Not enough matching taxa. Skipping", tree_file2, "\n", file=stderr())
  quit(save = "no", status = 1)
}

# Compute Robinson-Foulds distance
rf_distance <- dist.topo(tree1, tree2)

# Output results
cat(paste("RF_", tree_file2, "\t", rf_distance, "\n", sep=""))
