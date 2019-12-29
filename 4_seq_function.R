# Learning the Functions of the Sequences with BLAST

# retrieve the one DNA sequence from the termites project
library("reutils")
efetch("ABDH01022858.1", db = "sequences", rettype = "fasta", outfile = '~/sample.txt')

# this DNA sequence is used as the query to search a protein database.
# $ blastx -db all_sp.fa -query sample.txt -out sample.blastx

# use tblastn which used a protein sequences as query in searches against a nucleotide database
# The database of termites sequences needs to be formatted for BLAST
search
# $ makeblastdb -in ABDH01.1.fsa_nt -dbtype nucl -parse_seqids

# retrieve the best hit protein sequence in swissprot with keyword ???GUNA_CLOLO???.
# $ blastdbcmd -db all_sp.fa -entry GUNA_CLOLO > guna_clolo.fa

# carry out the tblastn search and output in a tabular format with the parameter -outfmt 6
# $ tblastn -query guna_clolo.fa -db ABDH01.1.fsa_nt -outfmt 6 -out guna_clolo_against_ABDH01.tblastn
       
# read the output file one line at a time and spilt the column with '/t'
fileName = "~/guna_clolo_against_ABDH01.tblastn"
con = file(fileName, open = "r")
line = readLines(con)
line1 = strsplit(line, "\t")
len = length(line1)
id    = vector()
begin = vector()
end   = vector()

for ( i in (1:len)){
  # only the hits with an E-value of less than 10-10 are kept
  if (as.numeric(line1[[i]][11]) < 1E-10){
    id    = c(id, line1[[i]][2])
    eval  = c(eval, line1[[i]][11])
    begin = c(begin, line1[[i]][7])
    end   = c(end, line1[[i]][8])
  }
}
df = data.frame("id" = id, "eval" = eval, "begin" = begin, "end" = end)

       
       
