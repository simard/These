#!/usr/bin/env Rscript
setwd("./files/")
source("Rinit")
out_file = get_outname(commandArgs())

exp1_dat_mon = exp1_dat[exp1_dat$Group == "monome", ]
bp_mon = boxplot(exp1_dat_mon$Time~exp1_dat_mon$Pattern, range=2, plot=FALSE)
titles = c("\\myresidue{1}","\\myresidue{2}","\\myresidue{3}","\\myresidue{4}","\\myresidue{5}","\\myresidue{6}","\\myresidue{7}","\\myresidue{8}","\\myresidue{9}","\\myresidue{10}")
names(bp_mon$stats) = titles
write.table(bp_mon$stats,
			file = out_file,
			quote = FALSE,
			sep = ",",
			eol = "\n",
			dec = ".",
			row.names = FALSE,
			col.names = titles)
exp1_dat_bin = exp1_dat[exp1_dat$Group == "binome", ]
bp_bin = boxplot(exp1_dat_bin$Time~exp1_dat_bin$Pattern, range=2, plot=FALSE)
titles = c("\\myresidue{1}","\\myresidue{2}","\\myresidue{3}","\\myresidue{4}","\\myresidue{5}","\\myresidue{6}","\\myresidue{7}","\\myresidue{8}","\\myresidue{9}","\\myresidue{10}")
names(bp_bin$stats) = titles
write.table(bp_bin$stats,
			file = out_file,
			quote = FALSE,
			sep = ",",
			eol = "\n",
			dec = ".",
			row.names = FALSE,
			col.names = FALSE,
			append=TRUE)
