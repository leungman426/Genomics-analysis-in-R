# Molecular Phylogeny with ClustalW
library('reutils')
# get the NCBI Accession Number
a = paste0("AY", 156734:156907)
efetch(a, db = "sequences", rettype = "fasta", outfile = ???~/all_gene.txt???)

# $ clustalw2 all_gene.txt
# $ clustalw2 all_gene.aln -tree
# $ clustalw2 all_gene.aln -bootstrap

# change the sample ID and build the phylogenetic tree
library("Biostrings")
# read the fasta file with readDNAString function
all = readDNAStringSet('~/all_gene.txt')
len = length(names(all))
# change the original id into a more readable name which reflect on its human origin
for ( i in (1:len)){
     split = strsplit(names(all)[i], " ")
     # the name I retrieve is on the 4th position of the ID
     new = split[[1]][4]
     names(all1)[i] = new
}
writeXStringSet(all, "~/all_genenew1.txt")
# The all_genenew1.phb was viewed in R with the help the package {ape}. library("ape")
tre = read.tree("~/all_genenew1.phb")
plot(tre, cex = 0.5)