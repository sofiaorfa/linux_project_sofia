HOW TO RUN THE PROJECT IN ORDER:

1.wget "https://hgdownload.soe.ucsc.edu/goldenPath/hg38/multiz20way/alignments/knownCanonical.
exonAA.fa.gz" --> Download the alignments 

2.Seperate first 500 alignments 
split_alignments.sh 

3.Construct 500 phylogentix trees(1per alignment)
sudo apt update
sudo apt install iqtree2
phylo_trees.sh

4.Merge Sequences
./merge_sequences <split_alignments> merged_totalout.fa
iqtree2 -s merged_totalout.fa -B 1000

5.Compare trees 
compare_trees.sh 

6.Find the 5 exons with the minimum rf 
five_exons.sh 
chatgpt_five_exons.txt --> for information about the exons 

7.Create the gene's sequences
identify_genes.sh 
conc_genes

8.Create the trees for the genes
create_gene_trees.sh

9.Compare gene trees with the merged_totalout.fa.treefile
compare_gene_trees.sh

10.Find the 5 with the minimum and the 5 with the maximum rf 
gene_smallest_largest_rf.sh

11. Chatgpt for the results of the previous step
    five_genes_chatgpt.txt


Consult the Dockerfile and the linux.yaml for necessary tools and filepaths

