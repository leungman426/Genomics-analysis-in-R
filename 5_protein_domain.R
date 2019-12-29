#  check out the  Protein Domains

# the dataset is downloaded in a text-file format from the Pfam website and formatted for HMMER searches
# $ hmmpress Pfam-A.hmm

# retrieve the human swiss-prot proteins related to blood coagulation
library("reutils")
id = c("FA7_HUMAN", "FA7_HUMAN", "FA7_HUMAN", "FA7_HUMAN", "FA7_HUMAN",
       "FA7_HUMAN","TF_HUMAN", "PLMN_HUMAN", "TPA_HUMAN", "UROK_HUMAN",
       'THRB_HUMAN', "KLKB1_HUMAN",'HGF_HUMAN', "HGFA_HUMAN")
efetch(id, db = "sequences", rettype = "fasta", outfile = "~/blood.txt")

# search for the protein families of the blood coagulation sequence in Pfam database 
# and the output file is named clotting.tab
# $ Hmmscan ???domtblout clotting.tab Pfam-A.hmm blood.txt

# read the file line by line
fileName = "~/clotting.tab"
con = file(fileName, open = "r")
line = readLines(con)
protname = vector()
len      = vector()
domname  = vector()
begin    = vector()
end      = vector()

for (i in (1:length(line))){
  # only work on the lines which do not begin with ???#???
  if (!grepl('^#', line[i])){
  } 
}

df = data.frame("protname" = protname, "domname" = domname, "len" = len,
                "begin" = begin, "end" = end)



