# Examine Taxonomy Data

library("reutils")
library("tibble")
library("XML")
library("methods")

# get the taxID of these species
a1 = c("monodelphis domestica", "Isoodon macrourus", "Echymipera
       rufescens australis", "Trichosurus vulpecula","Phalanger interpositus",
       "Macropus robustus", 'Dactylopsila  trivirgata', "Potorous tridactylus",
       "Vombatus ursinus", "Phascogale tapoatafa", "Sminthopsis crassicaudata", 
       'Myrmecobius fasciatus', "Thylacinus cynocephalus","Notoryctes typhlops", "Canis
       lupus")
b = esearch(a1, db = "taxonomy")
id = uid(b)

# get partly the taxonomy info: "species" and "common name"
b2 = esummary(id, db = "taxonomy")
x = content(b2, "parsed")
x1 = as.data.frame(x)
common_names = x1['CommonName']
species = x1['ScientificName']

# get partly the taxonomy info: "lineage"
b3 = efetch(id, db = "taxonomy", outfile = "~/tax.txt")
a <- xmlToDataFrame("~/tax.txt", stringsAsFactors = FALSE)
lineages = a["Lineage"]

# make the html table
table = data.frame("Species" = species, "Common Names" = common_names,
                   "Lineages" = lineages)
library("xtable")
table1 <- xtable(table)
print(table1, type = "html", file = ???~/tax.html")
