# search for certain CpG sites in a given amino acid sequence

# retrieve the random sequence and read line by line
filename = "~/short.txt"
con = file(filename, open = "r")
line = readLines(con)
# get the sequence with all the character separated
seq = vector()
for (i in (1:length(line))){
  # remove the lines beginning with ???>??? and blank lines
  if (!(grepl('^>', line[i]) | line[i] == "")) {
    line1 = strsplit(line[i], "")# separate the line by various number of blank space
    seq = c(seq, line1)
  }
}
seq = unlist(seq)

win   = 500 # the window size is 500bp which is the minimum size for theCpG island.
step  = 10 # move the window in steps of 10
len   = length(seq)
pos_i = win / 2
pos        = vector()
cg_ratio   = vector()
cg_obs_exp = vector()

for (j in seq(0 , len - win+1, by = step)) {
  pos = c(pos, pos_i + j)
  count = table(seq[(1+j):(win + j)])
  # count count of the CG per window
  seq_continue = paste0(seq[(1+j):(win + j)], collapse = "")
  cg = lengths(regmatches(seq_continue, gregexpr("CG", seq_continue)))
  # count the content of C+G per window
  cg_ratio = c(cg_ratio, ((count["C"] + count["G"]) * 100 / win))
  # the ratio between the frequency of observed CpG sites and thefrequency of expected CpG sites
  cg_obs_exp = c(cg_obs_exp, (cg * win / (count["C"] * count["G"])))
  # the data frame which satisfies the Takai and Jones method
  if (cg_ratio >= 55 & cg_obs_exp >= 0.65){
    df1 = data.frame("position" = pos, "cpg" = 1, "cg_ratio" =
                       cg_ratio, "cg_obs_exp" = cg_obs_exp)
  }
  else {
    df2 = data.frame("position" = pos, "cpg" = 0, "cg_ratio" =
                       cg_ratio, "cg_obs_exp" = cg_obs_exp)
  }
}

