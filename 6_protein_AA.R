# Identifying the Protein Domain with Its Amino Acid Composition

# set up the input for the command line
library("argparse")
parser <- ArgumentParser()
parser$add_argument('file', help = "File in FASTA sequence format is to
                    be used arguments to the script")
parser$print_help()
args <- parser$parse_args()

# read the file line by line
con = file(args$file, open = "r")
line = readLines(con)
seq = vector()
for (i in (1:length(line))){
  # skip the lines which start with ???>??? and the blank line
  if (!(grepl('^>', line[i]) | line[i] == "")) {
    line1 = strsplit(line[i], '')
                     # separate the line by various number of blank space
                     seq = c(seq, line1)
  }
}

seq = unlist(seq)
wid = 100
i = 0 
len = length(seq)
pos_i = wid / 2
  
pos     = vector()
count_p = vector()
count_t = vector()
count_s = vector()

for (j in (0 : (len - wid))) {
  pos = c(pos, pos_i + j)
  count = table(seq[(1+j):(wid + j)])
  # count the percentage of proline, threonine and serine
  count_p = c(count_p, count["P"] / wid)
  count_t = c(count_t, count["T"] / wid)
  count_s = c(count_s, count["S"] / wid)
}
df = data.frame("position" = pos, "proline" = count_p, "threonine" =
                  count_t, "serine" = count_s)
# get the position where the condition is satisfied
pos_hit = df[df["proline"] > 0.05 & df['threonine'] + df["serine"] > 0.5,
             ][???position???]

