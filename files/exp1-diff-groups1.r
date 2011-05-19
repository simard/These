#!/usr/bin/env Rscript
setwd("./files/")
source("Rinit")
out_file = get_outname(commandArgs())

exp1_dat_bin = exp1_dat[exp1_dat$Group == "binome" & (exp1_dat$Pattern == 6 | exp1_dat$Pattern == 9), ]
# Convert in millimeters
exp1_dat_bin = aggregate(
			   exp1_dat_bin,
			   by = list(Name = exp1_dat_bin$Name),
			   FUN = smart_mean)
values = t(sort(10*exp1_dat_bin$MoyDiff, decreasing=TRUE))
values1 = values
values1[values1<12] = 0
values2 = values
values2[values2>12 | values<6] = 0
values3 = values
values3[values3>6] = 0
titles = c("\\mygroup{1}","\\mygroup{2}","\\mygroup{3}","\\mygroup{4}","\\mygroup{5}","\\mygroup{6}","\\mygroup{7}","\\mygroup{8}","\\mygroup{9}","\\mygroup{10}","\\mygroup{11}","\\mygroup{12}")
print(values)
print(titles)
out_file1 = gsub("\\.csv", "1.csv", out_file)
out_file2 = gsub("\\.csv", "2.csv", out_file)
out_file3 = gsub("\\.csv", "3.csv", out_file)
write.table(values1,
			file = out_file1,
			quote = FALSE,
			sep = ",",
			eol = "\n",
			dec = ".",
			row.names = FALSE,
			col.names = titles)
write.table(values2,
			file = out_file2,
			quote = FALSE,
			sep = ",",
			eol = "\n",
			dec = ".",
			row.names = FALSE,
			col.names = FALSE)
write.table(values3,
			file = out_file3,
			quote = FALSE,
			sep = ",",
			eol = "\n",
			dec = ".",
			row.names = FALSE,
			col.names = FALSE)
