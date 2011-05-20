#!/usr/bin/env Rscript
setwd("./files/")
source("Rinit")
out_file = get_outname(commandArgs())

exp1_dat_bin = exp1_dat[exp1_dat$group.config == "binome", ]
exp1_dat_bin = aggregate(
			   exp1_dat_bin,
			   by = list(id = exp1_dat_bin$id),
			   FUN = smart_mean)
exp1_dat_bin = exp1_dat_bin[order(exp1_dat_bin$mean.diff, decreasing=TRUE), ]
values = t(exp1_dat_bin$group.affinity)
# To have not between 1 and 5 (instead of 0 to 4)
values = values+1
titles = c("\\mygroup{1}","\\mygroup{2}","\\mygroup{3}","\\mygroup{4}","\\mygroup{5}","\\mygroup{6}","\\mygroup{7}","\\mygroup{8}","\\mygroup{9}","\\mygroup{10}","\\mygroup{11}","\\mygroup{12}")
write.table(values,
			file = out_file,
			quote = FALSE,
			sep = ",",
			eol = "\n",
			dec = ".",
			row.names = FALSE,
			col.names = titles)
