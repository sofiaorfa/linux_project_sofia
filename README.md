HOW TO RUN THE PROJECT IN ORDER:

1.wget "https://hgdownload.soe.ucsc.edu/goldenPath/hg38/multiz20way/alignments/knownCanonical.
exonAA.fa.gz" --> Download the alignments 

2.Seperate first 500 alignments 
 Use split_alignments.sh 

3.Construct 500 phylogentix trees(1per alignment)
sudo apt update
sudo apt install iqtree2
 use phylo_trees.sh

4.Merge Sequences
use ./merge_sequences <split_alignments> merged_totalout.fa
iqtree2 -s merged_totalout.fa -B 1000

5.Compare trees 
use compare_trees.sh 

6.Find the 5 exons with the minimum rf 
use five_exons.sh 
chatgpt_five_exons.txt --> for information about the exons 

7.Create the gene's sequences
use first identify_genes.sh 
and then conc_genes

8.Create the trees for the genes
use create_gene_trees.sh

9.Compare gene trees with the merged_totalout.fa.treefile
use compare_gene_trees.sh

10.Find the 5 with the minimum and the 5 with the maximum rf 
use gene_smallest_largest_rf.sh

11. Chatgpt for the results of the previous step
    five_genes_chatgpt.txt


Consult the Dockerfile and the linux.yaml for necessary tools and filepaths
I couldn't submit the split alignments and the phylogenetic trees folders as they have too many files and it is not practical to upload them in a GitHub if you need them maybe consider another way.
I made comments for each line oof code on the scripts to make it easier instead of a report.
