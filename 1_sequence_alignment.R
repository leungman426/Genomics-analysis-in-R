# Pairwise Sequence Alignment with BLAST

# 1. Download the database from FTP
# 2.Download with blastdbcmd
# $ blastdbcmd -db swissprot -entry all -out all_sp.fa
# $ blastdbcmd -db all_sp.fa -entry ABL_HUMAN > abl_human.fa
# 3. BLAST Tool Use a Protein Query Sequence to Search a Protein Database
# $ blastp -query A9UF02.fasta.txt -db all_sp.fa -out brcabl.blastp

# Multiple Sequence Alignment with ClustalW
# 1. protein sequences were retrieved from the Swiss-Prot database as foxp2.fa:
#FOXP2_HYLLA, FOXP2_GORGO, FOXP2_MACMU, FOXP2_PANTR, FOXP2_HUMAN, FOXP2_PONPY, FOXP2_MOUSE, FOXP2_XENLA
# 2. clustalw2 foxp2.fa > foxp2.dnd
# 3. clustalw2 foxp2.fa -output=fasta

# 4. find out the positions where human sequence was different from all the sequences of non-human species
library("Biostrings")
all = readAAStringSet("~/foxp2.fasta")
all_df = as.data.frame(all)
all_df['names'] = rownames(all_df)
len = length(all_df['names'])
names(all_df) = c("seq", 'id')
# get the human sequence
humanseq = all_df[grep("HUMAN", unlist(all_df['id'])), ]
# get the non-human sequence
nonhuman = all_df[-grep("HUMAN", unlist(all_df['id'])), ]
# Analyse the multiple alignment
len_id = length(nonhuman["id"][[1]])
len_seq = length(strsplit(nonhuman$seq[1], "")[[1]])
# when the human AA is different from all the AA in all non human seq
unique = 1
nonhuman_c = vector()
for (i in (1:len_seq)){
    # get the AA from huamn seq
    human_c = strsplit(humanseq$seq, "")[[1]][i]
    # get the collection of AA from nonhuman seq
    for (j in (1:len_id)){
        nonhuman_c = c(nonhuman_c, strsplit(nonhuman$seq[j], "")[[1]][i])
    }
    # see whether the human AA is different from all the AA in non humanseq
    if (human_c %in% nonhuman_c){
        unique = 0
    }
    # if it is yes...
    if (unique == 1){
        for (j in (1:len_id)){
             print(paste(nonhuman$id[j], strsplit(nonhuman$seq[j], "") [[1]][i])) 
        }
        print(paste(humanseq$id, human_c))
        print(paste("At position", i))
    }
    unique = 1
    nonhuman_c = vector()
}


