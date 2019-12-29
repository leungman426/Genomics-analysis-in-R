# search the NCBI database with various Entrez query

library('reutils')
# provide the UIDs for efetch
         id = c("CY073775.1", "cy022055.1", 'U47817.1')
# retrieve the sequence in fasta file
efetch(id, db = "sequences", rettype = "fasta", outfile = "~/efetch.txt") 
# Esearch 
# provide the keywords for esearch
term = c("h1n1", "segment 6", "influenza a virus")
id = esearch(term, db = "nuccore", retmax = 100)
# get the UIDs from the search
UIDS = uid(id)
# search for the entries with the UIDs
efetch(UIDS, db = "sequences", rettype = "fasta", outfile = "~/esummary.txt")

#Elink
library('reutils')
# provide the GI number for three different nucleotide sequences.
         query = c("306412420", "306412402", '306412365')
# gain the protein UIDs
id = elink(query, dbFrom = "nuccore", dbTo = "protein", linkname =
             "nuccore_protein")
# provide with the UIDs to search for the sequences.
efetch(id, db = "sequences", rettype = "fasta", outfile = "~/elink.txt")




